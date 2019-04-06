# Copyright (c) 2012-2017 Ben Croston <ben@croston.org>.
# Copyright (c) 2019, NVIDIA CORPORATION. All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

import gpio_event as event
import gpio_pin_data
import os
import time
import warnings

# sysfs root
_SYSFS_ROOT = "/sys/class/gpio"

if (not os.access(_SYSFS_ROOT + '/export', os.W_OK) or
        not os.access(_SYSFS_ROOT + '/unexport', os.W_OK)):
    raise RuntimeError("The current user does not have permissions set to "
                       "access the library functionalites. Please configure "
                       "permissions or use the root user to run this")

# Pin Numbering Modes
BOARD = 'BOARD'
BCM = 'BCM'
TEGRA_SOC = 'TEGRA_SOC'
CVM = 'CVM'
_MODE_UNKNOWN = None

# The constants and their offsets are implemented to prevent HIGH from being used
# in place of other variables (ie. HIGH and RISING should not be interchangeable)

# Pull up/down options
PUD_OFF = 20
PUD_DOWN = 21
PUD_UP = 22

HIGH = 1
LOW = 0

# Edge possibilities
RISING = 11
FALLING = 12
BOTH = 13

# Pullup/down and Edge Offset
_PUD_OFFSET = -20
_EDGE_OFFSET = -10

# GPIO directions. UNEXPORTED constant is for gpios that are not yet setup
_UNEXPORTED = ''
OUT = 'out'
IN = 'in'

# check jetson model and prepare lookup table accordingly
def get_model(model_path='/proc/device-tree/model'):
    version_path = '/proc/device-tree/chosen/plugin-manager/ids'
    model_str = None

    try:
        with open(model_path, 'r') as f:
            model_str = f.read().rstrip('\x00')
    except:
        raise Exception('Could not determine Jetson model because model file'
                        '(%s) was not found.' % model_path)

    if 'tx1' in model_str:
        return gpio_pin_data.JETSON_TX1
    elif 'tx2' in model_str or 'quill' in model_str:
        return gpio_pin_data.JETSON_TX2
    elif 'xavier' in model_str:
        return gpio_pin_data.JETSON_XAVIER
    elif 'nano' in model_str:
        if int(os.listdir(version_path)[0][-3:]) >= 200:
            return gpio_pin_data.JETSON_NANO
        else:
            raise Exception('Jetson Nano revision must be newer than A02')

    raise Exception('Could not guess Jetson model from the model string (%s).'
                    % model_str)

_board_info, _gpio_chip_base = gpio_pin_data.get_gpio_data(get_model())
_pin_mapping = _board_info['gpio_numbers']
JETSON_INFO = _board_info['JETSON_INFO']
RPI_INFO = JETSON_INFO

# Dicitionary objects used as lookup tables for pin to linux gpio mapping
_pin_to_gpio = {}

_gpio_warnings = True
_gpio_mode = _MODE_UNKNOWN
_gpio_direction = {}

# Function used to enable/disable warnings during setup and cleanup.
# Param -> state is a bool
def setwarnings(state):
    global _gpio_warnings
    _gpio_warnings = bool(state)

# Function used to set the pin mumbering mode. Possible mode values are BOARD,
# BCM, TEGRA_SOC and CVM
def setmode(mode):
    global _gpio_mode, _pin_to_gpio

    # check if a different mode has been set
    if _gpio_mode != _MODE_UNKNOWN and mode != _gpio_mode:
        raise ValueError("A different mode has already been set!")

    # check if mode parameter is valid
    if mode != BOARD and mode != BCM and mode != TEGRA_SOC and mode != CVM:
        raise ValueError("An invalid mode was passed to setmode()!")

    _pin_to_gpio = _pin_mapping[mode]
    _gpio_mode = mode

# Function used to get the currently set pin numbering mode
def getmode():
    return _gpio_mode

# Function used to setup individual pins or lists/tuples of pins as
# Input or Output. Param channels must an integer or list/tuple of integers,
# direction must be IN or OUT, pull_up_down must be PUD_OFF, PUD_UP or
# PUD_DOWN and is only valid when direction in IN, initial must be HIGH or LOW
# and is only valid when direction is OUT
def setup(channels, direction, pull_up_down=PUD_OFF, initial=None):
    # check if channels are iterable
    channels = _make_iterable(channels)

    if _gpio_mode == BCM or _gpio_mode == BOARD:
        # check if all values in the iterable is an int
        if not all(isinstance(x, int) for x in channels):
            raise ValueError("Channel must be an integer or list/tuple of"
                              "integers")
    elif _gpio_mode == TEGRA_SOC or _gpio_mode == CVM:
        # check if all values in the iterable is a string
        if not all(isinstance(x, str) for x in channels):
            raise ValueError("Channel must be an string or list/tuple of"
                             "strings")

    # check direction is valid
    if direction != OUT and direction != IN:
        raise ValueError("An invalid direction was passed to setup()")

    # check if pullup/down is used with output
    if direction == OUT and pull_up_down != PUD_OFF:
        raise ValueError("pull_up_down parameter is not valid for outputs")

    # check if intial value is used with input
    if direction == IN and initial is not None:
        raise ValueError("initial parameter is not valid for inputs")

    # check if pullup/down value is valid
    if (pull_up_down != PUD_OFF and pull_up_down != PUD_UP and
            pull_up_down != PUD_DOWN):
        raise ValueError("Invalid value for pull_up_down - should be either"
                         "PUD_OFF, PUD_UP or PUD_DOWN")

    if direction == OUT:
        for idx in range(len(channels)):
            if isinstance(initial, (list, tuple)):
                if len(channels) != len(initial):
                    raise RuntimeError("Number of channels != number of "
                                       "initial values")
                _setup_single_out(channels[idx], initial[idx])
            else:
                _setup_single_out(channels[idx], initial)
    else:
        for idx in range(len(channels)):
            if isinstance(initial, (list, tuple)):
                if len(channels) != len(initial):
                    raise RuntimeError("Number of channels != number of "
                                       "initial values")
                _setup_single_in(channels[idx], pull_up_down + _PUD_OFFSET)
            else:
                _setup_single_in(channels[idx], pull_up_down + _PUD_OFFSET)


def _setup_single_out(channel, initial=None):
    gpio = _get_gpio_number(channel)
    func = gpio_function(channel)
    direction = _check_pin_setup(gpio)

    # warn if channel has been setup external to currently running program
    if _gpio_warnings and direction is None:
        if func == OUT or func == IN:
            warnings.warn("This channel is already in use, continuing anyway. "
                          "Use GPIO.setwarnings(False) to disable warnings",
                          RuntimeWarning)

    _export_gpio(gpio)
    gpio_dir_path = _SYSFS_ROOT + "/gpio%i" % gpio + "/direction"
    gpio_value_path = _SYSFS_ROOT + "/gpio%i" % gpio + "/value"

    with open(gpio_dir_path, 'w') as direction_file:
        direction_file.write(OUT)

    if initial == HIGH or initial == LOW:
        with open(gpio_value_path, 'w') as value:
            initial = int(initial)
            value.write(str(initial))

    _gpio_direction[gpio] = OUT

def _setup_single_in(channel, pull_up_down=PUD_OFF):
    gpio = _get_gpio_number(channel)
    func = gpio_function(channel)
    direction = _check_pin_setup(gpio)

    # warn if channel has been setup external to currently running program
    if _gpio_warnings and direction is None:
        if func == OUT or func == IN:
            warnings.warn("This channel is already in use, continuing anyway. "
                          "Use GPIO.setwarnings(False) to disable warnings",
                          RuntimeWarning)

    _export_gpio(gpio)
    gpio_dir_path = _SYSFS_ROOT + "/gpio%i" % gpio + "/direction"

    with open(gpio_dir_path, 'w') as direction:
        direction.write(IN)

    _gpio_direction[gpio] = IN

# Function used to cleanup channels at the end of the program.
# The param channel can be an integer or list/tuple of integers specifying the
# channels to be cleaned up. If no channel is provided, all channels are cleaned
def cleanup(channel=None):
    # warn if no channel is setup
    if _gpio_mode == _MODE_UNKNOWN:
        if _gpio_warnings:
            warnings.warn("No channels have been set up yet - nothing to "
                          "clean up! Try cleaning up at the end of your "
                          "program instead!", RuntimeWarning)
        return

    # clean all channels if no channel param provided
    if channel is None:
        _cleanup_all()
        return

    # check if channels are iterable
    channel = _make_iterable(channel)

    if all(isinstance(x, (str, int)) for x in channel):
        for idx in channel:
            _cleanup_one(idx)

    else:
        raise ValueError("Channel must be an integer/string or list/tuple of "
                         "integers/strings")

def _cleanup_one(channel):
    gpio = _get_gpio_number(channel)
    if gpio is not None or _check_pin_setup(gpio) is not None:
        _setup_single_in(channel)
        del _gpio_direction[gpio]
        event.event_cleanup(gpio)
        _unexport_gpio(gpio)

def _cleanup_all():
    global _gpio_mode

    for channel in _pin_to_gpio:
        if _pin_to_gpio[channel][0] is not None:
            _cleanup_one(channel)

    _gpio_mode = _MODE_UNKNOWN

# Function used to return the current value of the specified channel.
# Function returns either HIGH or LOW
def input(channel):
    gpio = _get_gpio_number(channel)
    direction = _check_pin_setup(gpio)
    if direction != IN and direction != OUT:
        raise RuntimeError("You must setup() the GPIO channel first")

    with open(_SYSFS_ROOT + "/gpio%i" % gpio + "/value") as value:
        value_read = int(value.read())
        return value_read

# Function used to set a value to a channel or list/tuple of channels.
# Parameter channels must be an integer or list/tuple of integers.
# Values must be either HIGH or LOW or list/tuple
# of HIGH and LOW with the same length as the channels list/tuple
def output(channels, values):
    # check if channels and values are iterable
    channels = _make_iterable(channels)
    values = _make_iterable(values)

    if _gpio_mode == BOARD or _gpio_mode == BCM:
        # check if all elements in the channels iterable are integers
        if not all(isinstance(x, int) for x in channels):
            raise ValueError("Channel must be an integer or list/tuple of "
                             "integers")
    elif _gpio_mode == TEGRA_SOC or _gpio_mode == CVM:
        # check if all elements in the channels iterable are strings
        if not all(isinstance(x, str) for x in channels):
            raise ValueError("Channel must be a string or "
                             "list/tuple of string")

    # check if all elements in the values iterable are integers/booleans
    if not all(isinstance(x, (int, bool)) for x in values):
        raise RuntimeError("Value list must consist of integers/booleans")

    # check that channels have been set as output
    if any((_check_pin_setup(_get_gpio_number(x)) != OUT)
           for x in channels):
        raise RuntimeError("The GPIO channel has not been set up as an "
                           "OUTPUT")

    # check if values contains more than 1 element and is not empty
    if values:
        try:
            values[1]
            if len(channels) != len(values):
                raise RuntimeError("Number of channels != number of values")
            else:
                for idx in range(len(channels)):
                    _output_one(channels[idx], values[idx])
        except:
            for idx in range(len(channels)):
                _output_one(channels[idx], values[0])
    else:
        raise ValueError("Value must not be empty")

def _check_pin_setup(gpio):
    return _gpio_direction.get(gpio, None)

def _make_iterable(iterable):
    try:
        for x in iterable:
            break
    except:
        iterable = [iterable]

    if isinstance(iterable, str):
        iterable = [iterable]

    return iterable

def _output_one(channel, value):
    gpio = _get_gpio_number(channel)
    value = int(value)
    if value != HIGH and value != LOW:
        raise ValueError("Invalid output value")

    with open(_SYSFS_ROOT + "/gpio%s" % gpio + "/value", 'w') as value_file:
        value = str(value)
        value_file.write(value)

# Function used to check if an event occurred on the specified channel.
# Param channel must be an integer.
# This function return True or False
def event_detected(channel):
    gpio = _get_gpio_number(channel)
    return event.edge_event_detected(gpio)

# Function used to add a callback function to channel, after it has been
# registered for events using add_event_detect()
def add_event_callback(channel, callback):
    if not callable(callback):
        raise TypeError("Parameter must be callable")

    gpio = _get_gpio_number(channel)
    if _check_pin_setup(gpio) != IN:
        raise RuntimeError("You must setup() the GPIO channel as an "
                           "input first")

    if not event.gpio_event_added(gpio):
        raise RuntimeError("Add event detection using add_event_detect first "
                           "before adding a callback")

    event.add_edge_callback(gpio, lambda: callback(channel))

# Function used to add threaded event detection for a specified gpio channel.
# Param gpio must be an integer specifying the channel, edge must be RISING,
# FALLING or BOTH. A callback function to be called when the event is detected
# and an integer bounctime in milliseconds can be optionally provided
def add_event_detect(channel, edge, callback=None, bouncetime=None):
    result = None

    if (not callable(callback)) and callback is not None:
        raise TypeError("Callback Parameter must be callable")

    gpio = _get_gpio_number(channel)

    # channel must be setup as input
    if _check_pin_setup(gpio) != IN:
        raise RuntimeError("You must setup() the GPIO channel as an input "
                           "first")

    # edge must be rising, falling or both
    if edge != RISING and edge != FALLING and edge != BOTH:
        raise ValueError("The edge must be set to RISING, FALLING, or BOTH")

    # if bouncetime is provided, it must be int and greater than 0
    if bouncetime is not None:
        if type(bouncetime) != int:
            raise TypeError("bouncetime must be an integer")

        elif bouncetime < 0:
            raise ValueError("bouncetime must be an integer greater than 0")

    result = event.add_edge_detect(gpio, edge + _EDGE_OFFSET, bouncetime)

    # result == 1 means a different edge was already added for the channel.
    # result == 2 means error occurred while adding edge (thread or event poll)
    if result:
        error_str = None
        if result == 1:
            error_str = "Conflicting edge already enabled for this GPIO channel"
        else:
            error_str = "Failed to add edge detection"

        raise RuntimeError(error_str)

    if callback is not None:
        event.add_edge_callback(gpio, lambda: callback(channel))

# Function used to remove event detection for channel
def remove_event_detect(channel):
    gpio = _get_gpio_number(channel)
    event.remove_edge_detect(gpio)

# Function used to perform a blocking wait until the specified edge
# is detected for the param channel. Channel must be an integer and edge must
# be either RISING, FALLING or BOTH.
# bouncetime in milliseconds and timeout in millseconds can optionally be
# provided
def wait_for_edge(channel, edge, bouncetime=None, timeout=None):
    gpio = _get_gpio_number(channel)

    # channel must be setup as input
    if _check_pin_setup(gpio) != IN:
        raise RuntimeError("You must setup() the GPIO channel as an input "
                           "first")

    # edge provided must be rising, falling or both
    if edge != RISING and edge != FALLING and edge != BOTH:
        raise ValueError("The edge must be set to RISING, FALLING_EDGE "
                         "or BOTH")

    # if bouncetime is provided, it must be int and greater than 0
    if bouncetime is not None:
        if type(bouncetime) != int:
            raise TypeError("bouncetime must be an integer")

        elif bouncetime < 0:
            raise ValueError("bouncetime must be an integer greater than 0")

    # if timeout is specified, it must be an int and greater than 0
    if timeout is not None:
        if type(timeout) != int:
            raise TypeError("Timeout must be an integer")

        elif timeout < 0:
            raise ValueError("Timeout must greater than 0")

    result = event.blocking_wait_for_edge(gpio, edge + _EDGE_OFFSET,
                                          bouncetime, timeout)

    # If not error, result == channel. If timeout occurs while waiting,
    # result == None. If error occurs, result == -1 means channel is
    # registered for conflicting edge detection, result == -2 means an error
    # occurred while registering event or polling
    if not result:
        return None
    elif result == -1:
        raise RuntimeError("Conflicting edge detection event already exists "
                           "for this GPIO channel")

    elif result == -2:
        raise RuntimeError("Error waiting for edge")

    else:
        return channel

def _get_gpio_number(channel):
    if (_gpio_mode != BOARD and _gpio_mode != BCM and
            _gpio_mode != TEGRA_SOC and _gpio_mode != CVM):
        raise RuntimeError("Please set pin numbering mode using "
                           "GPIO.setmode(GPIO.BOARD), GPIO.setmode(GPIO.BCM), "
                           "GPIO.setmode(GPIO.TEGRA_SOC) or "
                           "GPIO.setmode(GPIO.CVM)")

    if channel not in _pin_to_gpio or _pin_to_gpio[channel][0] is None:
        raise ValueError("The channel sent is invalid on a {} Board".format(
            get_model()))

    return _pin_to_gpio[channel][0] + _gpio_chip_base[_pin_to_gpio[channel][1]]

# Function used to check the currently set function of the channel specified.
# Param channel must be an integers. The function returns either IN, OUT,
# or UNEXPORTED
def gpio_function(channel):
    gpio = _get_gpio_number(channel)
    gpio_dir = _SYSFS_ROOT + "/gpio%i" % gpio

    if not os.path.exists(gpio_dir):
        return _UNEXPORTED

    with open(gpio_dir + "/direction", 'r') as f_direction:
        function_ = f_direction.read()

    return function_.rstrip()

def _export_gpio(gpio):
    if os.path.exists(_SYSFS_ROOT + "/gpio%i" % gpio):
        return

    with open(_SYSFS_ROOT + "/export", "w") as f_export:
        f_export.write(str(gpio))

    while not os.access(_SYSFS_ROOT + "/gpio%i" %gpio + "/direction",
                        os.R_OK | os.W_OK):
        time.sleep(0.01)

def _unexport_gpio(gpio):
    if not os.path.exists(_SYSFS_ROOT + "/gpio%i" % gpio):
        return

    with open(_SYSFS_ROOT + "/unexport", "w") as f_unexport:
        f_unexport.write(str(gpio))