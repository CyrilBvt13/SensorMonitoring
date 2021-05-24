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

How it works
-----------

First things first, we need to add all the dependencies which will be useful for our project. In our case, the only package that we need will be the `http <https://pub.dev/packages/http>`_ package. It will allow us to use the API we built.

In the pubspec.yaml file, after this block :

.. code-block:: yaml

    dependencies:
      flutter:
        sdk: flutter
    
Add the following packages :

.. code-block:: yaml

  http: ^0.13.3

By runnning the command ``flutter pub get``, you will add this package dependency to our app.

Now that this is done, we will be able to start coding our app! We will begin with the models files that kind of works like blueprints for our datas structures. The first one will be a chartPoints.dart which will be used to draw the chart points.

.. code-block:: dart

    class DataPoint {
      DataPoint(this.timestamp, this.data);

      String timestamp;
      double data;
    }
    
The second one, sonsorDatas.dart will be used to parse the JSON file the API is going to send us. I used this `wonderful website <https://app.quicktype.io/>`_ to build the methods, it's a real timesaver!

As a reminder, our JSON file looks like this :

.. code-block:: json

    {"id": "9c3e06fa0182479096df1a4ccc9cc676", "data": {"timestamp": "14/05/2021-15:08:34", "temperature": 22.15, "pressure": 1004.52502216, "humidity": 33.0590236331}}

So back to our sensorDatas.dart file, first we implement a serializer and a deserialiser functions converting the JSON string to a List of SensorData structure we will define and vice versa :

.. code-block:: dart

    List<SensorData> sensorDataFromJson(String str) => List<SensorData>.from(json.decode(str).map((x) => SensorData.fromJson(x)));

    String sensorDataToJson(List<SensorData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

As you can see in the JSON example, we have two levels of fields, the id and data ones and then the informations stocked in the data field. Therefor, we will need two classes to define the blueprints and the methods we are going to use to deserialize the datas. Let begins with the first layer which we call SensorData :

.. code-block:: dart

    class SensorData {
        SensorData({
            required this.id,
            required this.data,
        });

        String id;
        Data data;

        factory SensorData.fromJson(Map<String, dynamic> json) => SensorData(
            id: json["id"],
            data: Data.fromJson(json["data"]),
        );

        Map<String, dynamic> toJson() => {
            "id": id,
            "data": data.toJson(),
        };
    }

As we just did for the first layer, let's implement the class for the second layer containing timestamp, temperature, pressure and humidity :

.. code-block:: dart

    class Data {
        Data({
            required this.timestamp,
            required this.temperature,
            required this.pressure,
            required this.humidity,
        });

        String timestamp;
        double temperature;
        double pressure;
        double humidity;

        factory Data.fromJson(Map<String, dynamic> json) => Data(
            timestamp: json["timestamp"],
            temperature: json["temperature"].toDouble(),
            pressure: json["pressure"].toDouble(),
            humidity: json["humidity"].toDouble(),
        );

        Map<String, dynamic> toJson() => {
            "timestamp": timestamp,
            "temperature": temperature,
            "pressure": pressure,
            "humidity": humidity,
        };
}

Et voilà! We now have the blueprints of datas structures we are going to use in the main application file. But to feed our app with some datas, we now have to connect it to the API. This is done by the sensorDatas_repo.dart file stored in the repos/ directory. It contains a simple class calling the http.get method :

.. code-block:: dart

    class SensorDatasRepository {
      Future<List<SensorData>> getSensorDatas() async {
        final response = await http.get(Uri.http('<ip_adress:port>', '</path>'));
        return sensorDataFromJson(response.body);
      }
    }
    
That's it! We now have everthing we need to display datas served by the API! There are many ways to present those datas. You can find an example following `this link <https://github.com/CyrilBvt13/PiGarden/blob/main/AndroidApp/lib/screens/app.dart>`_. It displays the lasts temperature, pressure and humidity datas available and also a graph ploting the temperature variations for the 10 lasts calls. As the description of this file would deserve a whole article, I will not develop it here. Also as I said, it's only one of many ways you can imagine to display those datas. 

In my example, I used the `syncfusion_flutter_charts <https://pub.dev/packages/syncfusion_flutter_charts>`_ package, allowing me to draw the chart. Don't forget to add the package to the pubspec.yaml file under :

.. code-block:: yaml

    dependencies:
      flutter:
        sdk: flutter
      http: ^0.13.3
    
Add the following package :

.. code-block:: yaml

  syncfusion_flutter_charts: ^19.1.63

Have fun!
