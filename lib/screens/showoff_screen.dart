import 'package:flutter/material.dart';

import '../main.dart';

class ShowoffScreen extends StatefulWidget {
  ShowoffScreen({
    super.key,
  });

  @override
  _ShowoffScreenState createState() => _ShowoffScreenState();
}

class _ShowoffScreenState extends State<ShowoffScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        color: MyApplication.logoColor2,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: const Center(
          child: Text('Showoff Screen',
              style: TextStyle(
                fontSize: 50,
              ))));
}
