Raspberry Pi Zero W and Hexiwear Bluetooth Experiment
===
### Introduction
In this guide, we are going to use a program written in Python on the Raspberry Pi to control the LED light on the Hexiwear. Our starting point will be the Pi image we have distributed and a slightly modified official BLE demostration firmware. (https://os.mbed.com/users/xihan94/code/Hexi_BLE_Example_Modified/)

### Hexiwear
We will simply use the mbed online compiler to build the binary, and program the Hexiwear by dragging the .bin file to it. After flashing, you will simply hit the reset button of the dock and be able to see a simple screen showing "BLUETOOTH" and "Tap Below". We will ignore the "Tap Below" in this experiment since the LED has been modified to be controlled by our Pi instead of the touch buttons below. The firmware will put our Hexiware in advertisement mode by default so you don't need to enable Bluetooth or start advertising manually.

### Raspberry Pi
In the image, we have already loaded the linux Bluetooth driver and software stack - BlueZ. You can verify that by typing `sudo hcitool lescan`. You should be able to see it scanning and outputing several entries among which there is a six-byte MAC address followed by 'HEXIWEAR'. This is the entry corresponding to the Hexiwear. The MAC address is the hardware address of our Hexiwear which is important to memorize as we will use it in all the commands later.

Now, we will install the python package `bluepy`. Before that, we need to install the dependency: `sudo apt install libglib2.0-dev`. Then, install `bluepy` by typing `sudo pip install bluepy`.

We are ready to let them talk to each other. Since writing a characteristic requires passcode authentication and bluepy doesn't support it now, we need to do that using another utility - `bluetoothctl`. Open it by typing `sudo bluetoothctl` and you should see a interactive shell prompt started with `[bluetooth]`. To pair using a passcode, we will need to switch to the `KeyboardOnly` agent:

```
agent KeyboardOnly
```
Then, try to scan and pair with our Hexiwear
```
scan on
pair 00:3A:40:0A:00:40
Enter passkey (number in 0-999999): 520955
```
You should replace the MAC address and passkey with your own version. After that, you should see something like "Pairing successful". If it doesn't request a passkey, repeat the steps after forgeting the device with `remove 00:3A:40:0A:00:40` until it asks for a passkey.

Next, we are ready to run the python script below. Copy'n'paste the code to your Pi and save it to a file. Run the script and you will see the LED blinking. Look at the source code of the python script and also the mbed project (maybe also the source code of the BTLE driver), can you figure out how it makes the LED blink?

```
import bluepy.btle
from bluepy.btle import Peripheral
import time

BT_MAC = '00:3A:40:0A:00:40'
CMD_TURN_ON = 'ledonledonledonledon'
CMD_TURN_OFF = 'ledoffledoffledoffle'

hexi = Peripheral()
hexi.connect(BT_MAC)
ledctl = hexi.getCharacteristics(uuid='2031')[0] # Alert Input

for i in range(10):
    ledctl.write(CMD_TURN_ON, True)
    
    j = 0
    while j < 1000000:
	j = j + 1
    ledctl.write(CMD_TURN_OFF, True)
    j = 0
    while j < 1000000:
        j = j + 1


hexi.disconnect()
```

### Useful links
Bluepy doc - https://ianharvey.github.io/bluepy-doc/index.html

KW40z (BT coprocessor) host-side driver - https://os.mbed.com/teams/Hexiwear/code/Hexi_KW40Z/

KW40z firmware - https://github.com/MikroElektronika/HEXIWEAR/tree/master/SW/KW40%20IAR/HEXIWEAR_bluetooth

