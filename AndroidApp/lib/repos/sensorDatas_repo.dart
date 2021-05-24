import 'package:http/http.dart' as http;
import '../models/sensorDatas.dart';

class SensorDatasRepository {
  Future<List<SensorData>> getSensorDatas() async {
    final response = await http.get(Uri.http('<ip_adress:port>', '</path>'));
    return sensorDataFromJson(response.body);
  }
}
