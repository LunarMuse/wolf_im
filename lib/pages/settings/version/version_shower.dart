import 'package:flutter/material.dart';
import 'package:wolf_im/config/app/global_value.dart';

class VersionShower extends StatefulWidget {
  const VersionShower({super.key});

  @override
  _VersionShowerState createState() => _VersionShowerState();
}

class _VersionShowerState extends State<VersionShower> {
  String version = '1.0.0';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('Version $kAppVersion');
  }
}
