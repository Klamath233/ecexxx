### Prerequesite
This tutorial assumes you run Raspbian on your Pi and latest major operating systems, including Windows 10, Ubuntu 16.04 and macOS High Sierra.

### Enable SSH on Raspberry Pi
Before `ssh` onto your Raspberry Pi, you need to enable the SSH server on the Pi. On raspbian, this is as simple as several clicks in a utility called `raspi-config`.

#### Step 1
Firstly, you need to have a display (or a serial console) as a bootstrapper for the SSH functionality. Boot into raspbian. When you get the desktop, open terminal and type `sudo raspi-config`. You should be able to see the following interface.

> TODO: a picture

#### Step 2
In order, hit `Interface Options`, `SSH` and `Yes`. You will know SSH has been successfully enabled when you see the same message as the last picture.

> TODO: remaining pictures

