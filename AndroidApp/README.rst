Android App
=======

*Coded by Cyril Bouvart*

Description
-----------

This is a Android app writed in Flutter to read the datas stoked in the API.

Setup
-----------

1. Install Flutter following the official  `Flutter <https://flutter.dev/docs/get-started/install>`_ documentation
2. I recommand using the `Visual Studio Code <https://code.visualstudio.com/>`_ IDE with the Dart and Flutter extensions to code in Flutter
3. Once you installed Flutter, create a new project by runnning the command ``flutter create <app_name>`` in the desired location
4. Replace the lib/ folder and the pubspec.yaml file with those in this repository
5. You now have a complete Flutter project to call the API datas and display it in a chart, have fun!

Quick Start
-----------

The only parameter to set for using the app is the connection to the API server. In the file lib/repos/sensorDatas_repo.dart, add the IP address and the path on which the API is served :

.. code-block:: python

    final response = await http.get(Uri.http('<ip_address:port>', '</path>'));
    
For example, if you PiGarden RestAPI service is hosted on a Raspberry Pi which IP is 192.168.1.1, the lib/repos/sensorDatas_repo.dart will look like this :

.. code-block:: python

    final response = await http.get(Uri.http('192.168.1.1:5000', '/PiGarden'));

Advanced Usage
-----------



Have fun!
