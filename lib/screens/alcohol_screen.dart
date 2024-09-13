import 'package:flutter/material.dart';
import '../main.dart';

class AlcoholScreen extends StatefulWidget {
  AlcoholScreen({
    super.key,
  });

  @override
  _AlcoholScreenState createState() => _AlcoholScreenState();
}

class _AlcoholScreenState extends State<AlcoholScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        color: MyApplication.scaffoldBodyColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: const Center(
          child: Text('Alcohol Screen',
              style: TextStyle(
                fontSize: 50,
              ))));
}
