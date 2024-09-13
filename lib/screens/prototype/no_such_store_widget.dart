import 'package:flutter/material.dart';

class NoSuchStoreWidget extends StatelessWidget{
  const NoSuchStoreWidget({super.key});

  
  @override 
  Widget build(BuildContext context)=>const Center(
    child: Text(
      'No Such Store Exist.',
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}