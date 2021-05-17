import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../repos/sensorDatas_repo.dart';
import '../models/sensorDatas.dart';
import '../models/chartPoints.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: FutureBuilder<List<SensorData>>(
        future: SensorDatasRepository().getSensorDatas(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            showDialog(
              context: context,
              builder: (BuildContext context) => const AlertDialog(
                title: Text("Error"),
                content: Text('An error has occured...'),
              ),
            );
          } else if (snapshot.hasData) {
            //Modifier l'affichage ici
            return SfCartesianChart(
              primaryXAxis: CategoryAxis(),

              // Chart title
              title: ChartTitle(text: 'Température (°C)'),
              // Enable legend
              legend: Legend(
                isVisible: true,
                title: LegendTitle(text: 'Température'),
              ),
              // Enable tooltip
              tooltipBehavior: _tooltipBehavior,
              series: <LineSeries<DataPoint, String>>[
                LineSeries<DataPoint, String>(
                  // Bind data source
                  dataSource: <DataPoint>[
                    DataPoint(
                        snapshot
                            .data![snapshot.data!.length - 10].data.timestamp,
                        snapshot.data![snapshot.data!.length - 10].data
                            .temperature),
                    DataPoint(
                        snapshot
                            .data![snapshot.data!.length - 9].data.timestamp,
                        snapshot
                            .data![snapshot.data!.length - 9].data.temperature),
                    DataPoint(
                        snapshot
                            .data![snapshot.data!.length - 8].data.timestamp,
                        snapshot
                            .data![snapshot.data!.length - 8].data.temperature),
                    DataPoint(
                        snapshot
                            .data![snapshot.data!.length - 7].data.timestamp,
                        snapshot
                            .data![snapshot.data!.length - 7].data.temperature),
                    DataPoint(
                        snapshot
                            .data![snapshot.data!.length - 6].data.timestamp,
                        snapshot
                            .data![snapshot.data!.length - 6].data.temperature),
                    DataPoint(
                        snapshot
                            .data![snapshot.data!.length - 5].data.timestamp,
                        snapshot
                            .data![snapshot.data!.length - 5].data.temperature),
                    DataPoint(
                        snapshot
                            .data![snapshot.data!.length - 4].data.timestamp,
                        snapshot
                            .data![snapshot.data!.length - 4].data.temperature),
                    DataPoint(
                        snapshot
                            .data![snapshot.data!.length - 3].data.timestamp,
                        snapshot
                            .data![snapshot.data!.length - 3].data.temperature),
                    DataPoint(
                        snapshot
                            .data![snapshot.data!.length - 2].data.timestamp,
                        snapshot
                            .data![snapshot.data!.length - 2].data.temperature),
                    DataPoint(
                        snapshot
                            .data![snapshot.data!.length - 1].data.timestamp,
                        snapshot
                            .data![snapshot.data!.length - 1].data.temperature)
                  ],
                  xValueMapper: (DataPoint sales, _) => sales.timestamp,
                  yValueMapper: (DataPoint sales, _) => sales.data,
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ],
            );

            /*ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(snapshot.data![index].data.timestamp),
                subtitle: Text(
                  snapshot.data![index].data.temperature.toString() + '°C',
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );*/
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
