import 'package:http/http.dart' as http;
import '../models/sensorDatas.dart';

class SensorDatasRepository {
  Future<List<SensorData>> getSensorDatas() async {
    final response = await http.get(Uri.http('192.168.1.3:5000', '/pigarden/'));
    return sensorDataFromJson(response.body);
  }
}