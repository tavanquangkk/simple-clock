import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  late Timer _timer;
  String hour = '00';
  String minute = '00';
  String second = '00';

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      hour = now.hour.toString().padLeft(2, '0');
      minute = now.minute.toString().padLeft(2, '0');
      second = now.second.toString().padLeft(2, '0');
    });
  }

  Widget _buildDigit(String digit) {
    return Container(
      width: 90,
      alignment: Alignment.center,
      child: Text(
        digit,
        style: const TextStyle(
          fontSize: 150,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDigit(hour[0]),
            _buildDigit(hour[1]),
            _buildDigit(':'),
            _buildDigit(minute[0]),
            _buildDigit(minute[1]),
            _buildDigit(':'),
            _buildDigit(second[0]),
            _buildDigit(second[1]),
          ],
        ),
      ),
    );
  }
}
