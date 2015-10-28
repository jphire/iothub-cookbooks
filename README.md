# iothub-cookbooks
IoT-hub cookbooks project is used to easily build virtual environments that use the [IoT hub](https://github.com/uh-cs-iotlab/kahvihub) software for communication. Currently Debian 7 on the Intel Galileo board is supported, but more is to follow.  

## Dependencies

- [VirtualBox 5]("https://www.virtualbox.org/")
- [Vagrant]("https://www.vagrantup.com/")
- [Packer]("https://www.packer.io/")

## Install

Clone the repo, cd to it.

Then, either

1. Build your own base box


	Download the Galileo base VM for building with packer:


	```
	wget 
	```

	Build vagrant box like so:

	```
	packer build packer_teplate.json
	```

	This will create a Vagrant box that has OpenJDK 7 installed for the IoT Hub. Next, you need to add the created box to Vagrant boxes:

	```
	vagrant box add username/boxname created_box_name.box
	```

	Change the Vagrantfile to use the box just created, then run:
	```
	vagrant up [hubNo]
	```

	vagrant up without hub spcified will start all the hubs included in vagrantfile (Currently only 2). Now, the IoT Hub servers should be running in the created vagrant machines. You can test them with curl like so:
	```
	curl hub1:8080/feeds/1
	```

	The above should return an error saying that no feed no 1 exists.

2. Use public atlas box

	TBD

