import 'package:flutter/material.dart';
import 'package:flutter_native/model/battery_info.dart';
import 'package:flutter_native/platform/battery_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late BatteryApi _batteryApi;
  late BatteryInfo _batteryInfo;

  @override
  void initState() {
    super.initState();
    _batteryApi = BatteryApi();
    _batteryInfo = BatteryInfo(
      batteryLevel: -1,
      batteryState: BatteryState.unknown,
    );

    _getBatteryInfo();
  }

  void _getBatteryInfo() async {
    final batteryInfo = await _batteryApi.getBatteryLevel();
    setState(() {
      _batteryInfo = batteryInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Current battery level:',
            ),
            Text(
              '${_batteryInfo.batteryLevel}',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text(
              'Current battery state:',
            ),
            Text(
              '${_batteryInfo.batteryState}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getBatteryInfo,
        tooltip: 'Battery Info',
        child: const Icon(Icons.battery_unknown),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
