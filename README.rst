PiGarden
=======

*Coded by Cyril Bouvart*

Description
-----------

This project aims to set up an automatic watering station controllable by an Android / iOS application. It consists of 3 parts:

* A python application allowing to read datas from sensors and send them to an API
* A python API allowing through CRUD commands to store datas
* A flutter application allowing to retrieve the data stored in the API

Setup
-----------

1. First things first, update your terminal by running the command ``sudo apt update``
2. Then install git by running the command ``sudo apt install git``
3. Download this repository with ``git clone https://github.com/CyrilBvt13/PiGarden.git``
4. You will need python to run this project, for this run ``sudo apt install python python-pip``

Python app : main.py
-----------

You are now be able to start with the python app for reading sensors datas and send them to the API.

In this exemple, we will use the BME280 sensor allowing you to get the temperature, pressure and humidity of the environnement. There is a lot of tutorials on the web showing how to setup a BME280 to work with a Raspberry Pi. Here i am going to show you how to do it with the I2C bus connection.

The wiring of the BME280 on a Raspberry Pi works like this :

* Vcc	: power up (3.6V max)
* GND	: ground
* SDI :	datas. Connect it to SDA for I2C bus method
* SCK : clock. Connect it to SCL for I2C bus method
* CSB : allows you to work with I2C  method by default
* SD0 : I2C adress choice. If SD0=0, then the address is 0x76, if SD0=1, then the address is 0x77

.. image:: http://gilles.thebault.free.fr/local/cache-vignettes/L360xH258/raspi_bme280_bb-4527a-22a99.jpg
  :width: 400
  :alt: Wiring diagram

You will need a little trick to make it works on a Raspberry Pi. Activate I2C support via raspi-config in a terminal :

  ``sudo raspi-config``

Then go to ``Interface options`` and enable ``I2C``.

To check the presence of the sensor from the command line, install this tools :

  ``sudo apt-get install python-smbus i2c-tools``

Then with the command ``sudo i2cdetect -y 1`` you will have this output :

.. image:: http://gilles.thebault.free.fr/local/cache-vignettes/L360xH163/i2cdetect_bme280-2-b3009-e654d.jpg
  :width: 400
  :alt: I2C address

If everything is fine, you will be able to run ``python bme280.py`` to get the temperature, pressure and humidity of the environnement :

.. image:: http://gilles.thebault.free.fr/local/cache-vignettes/L317xH91/bme280_1-7b187-53110.jpg
  :width: 400
  :alt: BME280 output

Now that we made the sensor working, we will configure the main.py script to make this work with the API service.

In order to make this script works, we should install the requests package in order to be able to contact the API :

  ``pip install requests``

Then we need to configure the IP address of te devices which will serve this API service, using ``nano main.py`` :

.. code-block:: python

    BASE = 'http://<*The IP address of your server*>:5000/'

You can now start this script by typing :

  ``python main.py``
  
Yeah you did it! Next step : setting up the API service...
    
Python API : RestAPI/apiservice.py
-----------

Please refer to the README.rst file in the RestAPI/ directory.

Start the scripts at boot
-----------

In ordrer to start the main script and the API when the Raspberry Pi boots, we are going to use Supervisor control system process. Supervisor is a client/server system that allows its users to monitor and control a number of processes on UNIX-like operating systems. To learn more about it check `Supervisor <http://supervisord.org/installing.html>`_ documentation. In the example bellow, we are going to configure the autostart of the API apiservice.py script.

Install the package by running :

``pip install supervisor``

In the RestAPI directory, create the configuration file :

``echo_supervisord_conf > supervisord.conf``

Edit it with the command ``nano supervisord.conf``, add at the end of the file :

.. code-block:: python

      [program:flask_app]
      command = python apiservice.py &
      directory = <path_to_the_script>/
      autostart = true
      autorestart = true

Start the Supervisor service by typing ``supervisord``.

Then update it and check if the script has started as expected :

``supervisorctl update``

``supervisorctl status``

Repeat this process for starting the main.py script at the boot up of the Raspberry Pi and this will be done for the server part of this project!

Android/iOS app
-----------

Please refer to the README.rst file in the AndroidApp/ directory.
