import 'dart:convert';

List<SensorData> sensorDataFromJson(String str) => List<SensorData>.from(json.decode(str).map((x) => SensorData.fromJson(x)));

String sensorDataToJson(List<SensorData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
