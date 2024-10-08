import 'package:flutter/material.dart';
import '../main.dart';

class GroupsScreen extends StatefulWidget {
  GroupsScreen({
    super.key,
  });

  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
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
          child: Text('Alcohol Screen',
              style: TextStyle(
                fontSize: 50,
              ))));
}
