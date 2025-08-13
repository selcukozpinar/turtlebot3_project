import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_joystick_customisable/flutter_joystick_customisable.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TurtleBot3 Controller',
      home: ControllerPage(),
    );
  }
}

class ControllerPage extends StatefulWidget {
  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  WebSocket? ws;

  @override
  void initState() {
    super.initState();
    // Emülatör için 10.0.2.2 kullanıyoruz
    WebSocket.connect('ws://10.0.2.2:9090').then((socket) {
      ws = socket;
      print('✅ WebSocket connected!');
    }).catchError((e) {
      print('❌ WebSocket connection failed: $e');
    });
  }

  void move(double linear, double angular) {
    if (ws != null && ws!.readyState == WebSocket.open) {
      // ✅ Ölü bölge ekle
      if (linear.abs() < 0.05) linear = 0.0;
      if (angular.abs() < 0.05) angular = 0.0;

      // ✅ Maksimum hız sınırları
      double maxLinear = 0.8;  // m/s
      double maxAngular = 1.0; // rad/s

      linear = linear.clamp(-maxLinear, maxLinear);
      angular = angular.clamp(-maxAngular, maxAngular);

      final msg = {
        "op": "publish",
        "topic": "/cmd_vel",
        "msg": {
          "linear": {"x": linear, "y": 0.0, "z": 0.0},
          "angular": {"x": 0.0, "y": 0.0, "z": angular}
        }
      };
      ws!.add(jsonEncode(msg));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TurtleBot3 Controller')),
      body: Center(
        child: Joystick(
          stickSize: 60,
          dragPadColor: Colors.blueAccent,
          onDragStart: () {},
          onDragEnd: () {
            move(0.0, 0.0); // Joystick bırakıldığında robot durur
          },
          dragCallback: (details) {
            // ✅ Daha hassas ve güvenli katsayılar
            double linear = details.y * 0.8;   // ileri/geri
            double angular = -details.x * 0.4; // sağ/sol
            move(linear, angular);
          },
        ),
      ),
    );
  }
}
