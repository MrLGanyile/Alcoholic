import 'package:flutter/material.dart';

import '../main.dart';

class HomeWidget extends StatefulWidget {
  static const id = 'HomeScreen';

  HomeWidget({
    super.key,
  });

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  _HomeWidgetState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyApplication.logoColor2,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: const Center(
        child: Text('HomeWidget',
            style: TextStyle(
              fontSize: 50,
            )),
      ),
    );
  }
}
