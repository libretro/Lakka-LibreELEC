#!/bin/bash

# Copyright (c) 2019, NVIDIA CORPORATION. All rights reserved.
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

# prints usage
print_help() {
    cat << EOF
Usage: ./run_sample.sh <sample application>
sample_application: simple_input.py
                    simple_output.py
                    button_led.py
                    button_event.py
                    button_interrupt.py
EOF
    exit 1
}

# Set PYTHONPATH to locate the required python modules
export PYTHONPATH="/opt/nvidia/jetson-gpio/lib/python/:${PYTHONPATH}"

# check if the necessary argument is provided
if [ "$#" != "1" ]; then
    print_help
fi

arg="$1"
# check if --help or -h switch is the argument
if [ "${arg}" = "--help" ] || [ "${arg}" = "-h" ]; then
    print_help
fi

# run the requested sample application
./"${arg}"
