Raspberry Pi SSH and Internet Sharing Guide
===

## Prerequisite
This tutorial demonstrates how to connect your computer to your Pi and share the computer's Wi-Fi connection to the Pi via an Ethernet cable. It is assumed that you run Raspbian on your Pi and latest major operating systems, including Windows 10, Ubuntu 16.04 and macOS High Sierra. Also, if you already have a home router, you are good to SSH by simply using the Pi's LAN IP address. This tutorial is useful if you are on campus where it is tricky to connect your Pi directly to the campus Wi-Fi and establish unobstructed SSH connection between the Pi and your computer.

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

## Configurate Interconnection and Internet Sharing
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

### Ubuntu 16.04
#### Step 1
Right click on the WiFi icon at the top-right corner, then click on `Edit Connections...`

![Ubuntu Picture 1](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/ubuntu_1.png)

#### Step 2
In the popped-up window, select the Ethernet interface and hit `Edit`.

![Ubuntu Picture 2](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/ubuntu_2.png)

#### Step 3
The editing interface will show up. Switch to `Ethernet` tab and select your Ethernet device node name to be your `device`. Then switch to `IPv4 Settings` tab and choose `Share to other computers`.

![Ubuntu Picture 3](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/ubuntu_3.png)
![Ubuntu Picture 4](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/ubuntu_4.png)

#### Step 4
Now, the connection is made. Query the Pi's IP by using the `arp` utility inside Terminal. Pi's IP is the one whose `iface` colume has value of your Ethernet device node.

![Ubuntu Picture 5](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/ubuntu_5.png)

#### Step 5
SSH onto the Pi and verify the internet is also available on the Pi. The default username is `pi` and the password is `raspberry`.

![Ubuntu Picture 6](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/ubuntu_6.png)

### macOS High Sierra
#### Step 1
Go to `System Preferences` and enter `Sharing`.

![macOS Picture 1](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/macOS_1.png)

#### Step 2
Click on `Internet Sharing`. In the right pane, select `Share your connection from Wi-Fi` and `to computers using <your ethernet adapter>`. After that, check the `Internet Sharing` box in the left pane. The window should show a green dot to the left of the message "Internet Sharing: On".

![macOS Picture 2](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/macOS_2.png)
![macOS Picture 3](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/macOS_3.png)

#### Step 3
We will need to know what IP address has been assigned to the Pi. Open a Terminal and type `arp -a`. The line with `[bridge]` is what you are looking for; the IP address is the IP of the Pi.

![macOS Picture 4](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/macOS_4.png)

#### Step 4
It's time to SSH onto the Pi! The default username is `pi` and the password is `raspberry`. Verify that the Pi also has internet connection by pinging Google.

![macOS Picture 5](https://github.com/Klamath233/ecexxx/raw/master/docs/pics/macOS_5.png)