================================================================================
                            README-Jetson.GPIO
                             Linux for Tegra
          Using the Jetson GPIO Python Library and Sample Applications
================================================================================

Jetson TX1, TX2 and AGX Xavier development boards contain a 40 pin GPIO header,
similar to the 40 pin header in the Raspberry Pi. These GPIOs can be controlled
for digital input and output using the Python library provided in the Jetson
GPIO Library package. The library has the same API as the RPi.GPIO library for
Raspberry Pi in order to provide an easy way to move applications running on the
Raspberry Pi to the Jetson board.

This document walks through what is contained in The Jetson GPIO library
package, how to configure the system and run the provided sample applications,
and the library API.

--------------------------------------------------------------------------------
                            Package Components
--------------------------------------------------------------------------------

In addition to this document, the Jetson GPIO library package contains the
following:

1. The lib/python/ subdirectory contains the Python modules that implement all
   library functionality. The gpio.py module is the main component that will be
   imported into an application and provides the needed APIs. The gpio_event.py
   and gpio_pin_data.py modules are used by the gpio.py module and must not be
   imported directly in to an application.

2. The samples/ subdirectory contains sample applications to help in getting
   familiar with the library API and getting started on an application. The
   simple_input.py and simple_output.py applications show how to perform read
   and write to a GPIO pin respectively, while the button_led.py,
   button_event.py and button_interrupt.py show how a button press may be used
   to blink an LED using busy-waiting, blocking wait and interrupt callbacks
   respectively.

--------------------------------------------------------------------------------
              Configuring the system and running sample scripts
--------------------------------------------------------------------------------

In order to use the Jetson GPIO Library, the correct user permissions/groups must
be set first.

Create a new gpio user group. Then add your user to the newly created group.
        sudo groupadd -f -r gpio
        sudo usermod -a -G gpio your_user_name

Install custom udev rules by copying the 99-gpio.rules file into the rules.d
directory:
        sudo cp /opt/nvidia/jetson-gpio/etc/99-gpio.rules /etc/udev/rules.d/

Please note that for the new rule to take place, you may either need to reboot
or reload the udev rules by issuing this command:
        sudo udevadm control --reload-rules && sudo udevadm trigger

With the permissions set as needed, the sample applications provided in the
samples/ directory can be used. The following describes the operation of each
application:

1. simple_input.py: This application uses the BCM pin numbering mode and reads
   the value at pin 12 of the 40 pin header and prints the value to the
   screen.

2. simple_out.py: This application uses the BCM pin numbering mode from
   Raspberry Pi and outputs alternating high and low values at BCM pin 18 (or
   board pin 12 on the header) every 2 seconds.

3. button_led.py: This application uses the BOARD pin numbering. It requires a
   button connected to pin 18 and GND, a pull-up resistor connecting pin 18
   to 3V3 and an LED and current limiting resistor connected to pin 12. The
   application reads the button state and keeps the LED on for 1 second every
   time the button is pressed.

4. button_event.py: This application uses the BOARD pin numbering. It requires a
   button connected to pin 18 and GND, a pull-up resistor connecting the button
   to 3V3 and an LED and current limiting resistor connected to pin 12. The
   application performs the same function as the button_led.py but performs a
   blocking wait for the button press event instead of continuously checking the
   value of the pin in order to reduce CPU usage.

5. button_interrupt.py: This application uses the BOARD pin numbering. It
   requires a button connected to pin 18 and GND, a pull-up resistor connecting
   the button to 3V3, an LED and current limiting resistor connected to pin 12
   and a second LED and current limiting resistor connected to pin 13. The
   application slowly blinks the first LED continuously and rapidly blinks the
   second LED five times only when the button is pressed.

In order to set up the correct environment variables for Python, the
run_sample.sh script can be used to run these sample applications. This can be
done with the following command when in the samples/ directory:
        ./run_sample.sh <name_of_application_to_run>

The usage of the script can also be viewed by using:
        ./run_sample.sh -h
        ./run_sample.sh --help

--------------------------------------------------------------------------------
                           Complete library API
--------------------------------------------------------------------------------

The Jetson GPIO library provides all public APIs provided by the RPi.GPIO
library with the exception of the Software PWM APIs. The following discusses the
use of each API:

1. Importing the libary

To import the Jetson.GPIO module use:

    import Jetson.GPIO as GPIO

This way, you can refer to the module as GPIO throughout the rest of the
application. The module can also be imported using the name RPi.GPIO instead of
Jetson.GPIO for existing code using the RPi library.

2. Pin numbering

The Jetson GPIO library provides four ways of numbering the I/O pins. The first
two correspond to the modes provided by the RPi.GPIO library, i.e BOARD and BCM
which refer to the pin number of the 40 pin GPIO header and the Broadcom SoC
GPIO numbers respectively. The remaining two modes, CVM and TEGRA_SOC use
strings instead of numbers which correspond to signal names on the CVM/CVB
connector and the Tegra SoC respectively.

To specify which mode you are using (mandatory), use the following function
call:

    GPIO.setmode(GPIO.BOARD)
    # or
    GPIO.setmode(GPIO.BCM)
    # or
    GPIO.setmode(GPIO.CVM)
    # or
    GPIO.setmode(GPIO.TEGRA_SOC)

To check which mode has be set, you can call:

    mode = GPIO.getmode()

The mode must be one of GPIO.BOARD, GPIO.BCM, GPIO.CVM, GPIO.TEGRA_SOC or
None.

3. Warnings

It is possible that the GPIO you are trying to use is already being used
external to the current application. In such a condition, the Jetson GPIO
library will warn you if the GPIO being used is configured to anything but the
default direction (input). It will also warn you if you try cleaning up before
setting up the mode and channels. To disable warnings, call:

    GPIO.setwarnings(False)

4. Set up a channel

The GPIO channel must be set up before use as input or output. To configure
the channel as input, call:

    # (where channel is based on the pin numbering mode discussed above)
    GPIO.setup(channel, GPIO.IN)

To set up a channel as output, call:

    GPIO.setup(channel, GPIO.OUT)

It is also possible to specify an initial value for the output channel:

    GPIO.setup(channel, GPIO.OUT, initial=GPIO.HIGH)

When setting up a channel as output, it is also possible to set up more than one
channel at once:

    # add as many as channels as needed. You can also use tuples: (18,12,13)
    channels = [18, 12, 13]
    GPIO.setup(channels, GPIO.OUT)

5. Input

To read the value of a channel, use:

    GPIO.input(channel)

This will return either GPIO.LOW or GPIO.HIGH.

6. Output

To set the value of a pin configured as output, use:

    GPIO.output(channel, state)

where state can be GPIO.LOW or GPIO.HIGH.

You can also output to a list or tuple of channels:

    channels = [18, 12, 13] # or use tuples
    GPIO.output(channels, GPIO.HIGH) # or GPIO.LOW
    # set first channel to HIGH and rest to LOW
    GPIO.output(channel, (GPIO.LOW, GPIO.HIGH, GPIO.HIGH))

7. Clean up

At the end of the program, it is good to clean up the channels so that all pins
are set in their default state. To clean up all channels used, call:

    GPIO.cleanup()

If you don't want to clean all channels, it is also possible to clean up
individual channels or a list or tuple of channels:

    GPIO.cleanup(chan1) # cleanup only chan1
    GPIO.cleanup([chan1, chan2]) # cleanup only chan1 and chan2
    GPIO.cleanup((chan1, chan2)  # does the same operation as previous statement

8. Jetson Board Information and library version

To get information about the Jetson module, use/read:

    GPIO.JETSON_INFO

This provides a Python dictionary with the following keys: P1_REVISION, RAM,
REVISION, TYPE, MANUFACTURER and PROCESSOR. All values in the dictionary are
strings with the exception of P1_REVISION which is an integer.

To get information about the library version, use/read:

    GPIO.VERSION

This provides a string with the X.Y.Z version format.

9. Interrupts

Aside from busy-polling, the library provides three additional ways of
monitoring an input event:

* The wait_for_edge() function

  This function blocks the calling thread until the provided edge(s) is
  detected. The function can be called as follows:

    GPIO.wait_for_edge(channel, GPIO.RISING)

  The second parameter specifies the edge to be detected and can be
  GPIO.RISING, GPIO.FALLING or GPIO.BOTH. If you only want to limit the wait
  to a specified amount of time, a timeout can be optionally set:

    # timeout is in milliseconds
    GPIO.wait_for_edge(channel, GPIO.RISING, timeout=500)

  The function returns the channel for which the edge was detected or None if a
  timeout occurred.

* The event_detected() function

  This function can be used to periodically check if an event occurred since the
  last call. The function can be set up and called as follows:

    # set rising edge detection on the channel
    GPIO.add_event_detect(channel, GPIO.RISING)
    run_other_code()
    if GPIO.event_detected(channel):
        do_something()

As before, you can detect events for GPIO.RISING, GPIO.FALLING or GPIO.BOTH.

* A callback function run when an edge is detected

  This feature can be used to run a second thread for callback functions. Hence,
  the callback function can be run concurrent to your main program in response
  to an edge. This feature can be used as follows:

    # define callback function
    def callback_fn(channel):
        print("Callback called from channel %s" % channel)

    # add rising edge detection
    GPIO.add_event_detect(channel, GPIO.RISING, callback=callback_fn)

  More than one callback can also be added if required as follows:

    def callback_one(channel):
        print("First Callback")

    def callback_two(channel):
        print("Second Callback")

    GPIO.add_event_detect(channel, GPIO.RISING)
    GPIO.add_event_callback(channel, callback_one)
    GPIO.add_event_callback(channel, callback_two)

  The two callbacks in this case are run sequentially, not concurrently since
  there is only thread running all callback functions.

  In order to prevent multiple calls to the callback functions by collapsing
  multiple events in to a single one, a debounce time can be optionally set:

    # bouncetime set in milliseconds
    GPIO.add_event_detect(channel, GPIO.RISING, callback=callback_fn,
                          bouncetime=200)

If the edge detection is not longer required it can be removed as follows:

    GPIO.remove_event_detect(channel)

10. Check function of GPIO channels

This feature allows you to check the function of the provided GPIO channel:

    GPIO.gpio_function(channel)

The function returns either GPIO.IN or GPIO.OUT.
