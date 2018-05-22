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

```python
import bluepy.btle
from bluepy.btle import Peripheral
import time

def try_until_success(func, exception=bluepy.btle.BTLEException, msg='reattempting', args=[]):
    retry = True
    while True:
        try:
            func(*args)
            retry = False
        except exception:
            print msg

        if not retry:
            break

BT_MAC = '00:3A:40:0A:00:40'
CMD_TURN_ON = 'ledonledonledonledon'
CMD_TURN_OFF = 'ledoffledoffledoffle'

hexi = Peripheral()

try_until_success(hexi.connect, msg='error connect', args=[BT_MAC])

ledctl = hexi.getCharacteristics(uuid='2031')[0] # Alert Input

for i in range(10):
    try_until_success(ledctl.write, msg='error turn on', args=[CMD_TURN_ON, True])
    time.sleep(2)
    try_until_success(ledctl.write, msg='error turn off', args=[CMD_TURN_OFF, True])
    time.sleep(2)
```

### Another Example on Reading BTLE Characteristics
This piece of code read the battery remaining in HEXI using BTLE notifications. It also shows other features of BluePy such as scanning.

```python
from bluepy import btle
from bluepy.btle import Scanner, DefaultDelegate, ScanEntry, Peripheral
import struct

# This is a delegate for receiving BTLE events
class BTEventHandler(DefaultDelegate):
    def __init__(self):
        DefaultDelegate.__init__(self)

    def handleDiscovery(self, dev, isNewDev, isNewData):
    	# Advertisement Data
        if isNewDev:
            print "Found new device:", dev.addr, dev.getScanData()

        # Scan Response
        if isNewData:
            print "Received more data", dev.addr, dev.getScanData()

    def handleNotification(self, cHandle, data):
    	# Only print the value when the handle is 40 (the battery characteristic)
        if cHandle == 40:
            print struct.unpack('B', data)
            
handler = BTEventHandler()

# Create a scanner with the handler as delegate
scanner = Scanner().withDelegate(handler)

# Start scanning. While scanning, handleDiscovery will be called whenever a new device or new data is found
devs = scanner.scan(10)

# Get HEXIWEAR's address
hexi_addr = [dev for dev in devs if dev.getValueText(0x8) == 'HEXIWEAR'][0].addr

# Create a Peripheral object with the delegate
hexi = Peripheral().withDelegate(handler)

# Connect to Hexiwear
hexi.connect(hexi_addr)

# Get the battery service
battery = hexi.getCharacteristics(uuid="2a19")[0]

# Get the client configuration descriptor and write 1 to it to enable notification
battery_desc = battery.getDescriptors(forUUID=0x2902)[0]
battery_desc.write(b"\x01", True)

# Infinite loop to receive notifications
while True:
    hexi.waitForNotifications(1.0)

```

### Useful links
Bluepy doc - https://ianharvey.github.io/bluepy-doc/index.html

KW40z (BT coprocessor) host-side driver - https://os.mbed.com/teams/Hexiwear/code/Hexi_KW40Z/

KW40z firmware - https://github.com/MikroElektronika/HEXIWEAR/tree/master/SW/KW40%20IAR/HEXIWEAR_bluetooth

