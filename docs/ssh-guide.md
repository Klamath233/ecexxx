## Prerequesite
This tutorial assumes you run Raspbian on your Pi and latest major operating systems, including Windows 10, Ubuntu 16.04 and macOS High Sierra.

## Enable SSH on Raspberry Pi
Before `ssh` onto your Raspberry Pi, you need to enable the SSH server on the Pi. On raspbian, this is as simple as several clicks in a utility called `raspi-config`.

#### Step 1
Firstly, you need to have a display (or a serial console) as a bootstrapper for the SSH functionality. Boot into raspbian. When you get the desktop, open terminal and type `sudo raspi-config`. You should be able to see the following interface.

![SSH Picture 1](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/ssh_1.png)

#### Step 2
In order, hit `Interface Options`, `SSH` and `Yes`. You will know SSH has been successfully enabled when you see the same message as the last picture.

![SSH Picture 2](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/ssh_2.png)
![SSH Picture 3](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/ssh_3.png)
![SSH Picture 4](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/ssh_4.png)

## Configurate Internet Sharing
In the following sections, we present methods to configure internet sharing in three operating systems: Windows 10, Ubuntu 16.04 and macOS High Sierra. The basic mechanism is similar. A DHCP service is launched interally and assigns IP addresses to both the host and the Pi, so that the host serves as a internet gateway for the Pi. We assume the host is connected to the internet via Wi-Fi, and to the Pi via Ethernet.

### Windows 10
#### Step 1
Open `Control Panel`, go to `Network and Sharing Center`, and `Change Adapter Settings`.

![Win10 Picture 1](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/win10_1.png)

#### Step 2
Right click on `Wi-Fi`, and open `Property`.

![Win10 Picture 2](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/win10_2.png)


#### Step 3
In the `Property` window, switch to `Sharing` tab and check `Allow other network users to connect through this computer's Internet connection`. Finally, choose the Ethernet interface in the dropdown menu.

![Win10 Picture 3](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/win10_3.png)

#### Step 4
Connect the Pi and the host using an Ethernet cable. To be able to SSH into the Pi, you need to know the IP address of the Pi. This can be looked up using Windows' `arp` utility. Open `cmd` and type `arp -a` to display the ARP table. Find the interface associated with your Ethernet card. The IP address shown in the table within the same subnet of the IP of that interface and not the broadcast address is the IP address of the Pi. See the following image for an example.

![Win10 Picture 4](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/win10_4.png)

#### Step 5
Now you are good to use your favorite SSH client to access your Pi! The default username is `pi` and the password is `raspberry`. The Pi automatically gets internet connectivity from the sharing we have configured.

![Win10 Picture 5](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/win10_5.png)



