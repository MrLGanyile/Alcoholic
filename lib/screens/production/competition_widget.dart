import 'package:alcoholic/controllers/production/store_controller.dart';
import 'package:flutter/material.dart';

import '../../models/production/stores/store.dart';
import '../../models/production/stores/store_draw.dart';


class CompetitionWidget extends StatefulWidget{


  const CompetitionWidget({
    super.key, 
    });

  @override 
  CompetitionWidgetState createState()=>CompetitionWidgetState();
}

class CompetitionWidgetState extends State<CompetitionWidget>{

    @override 
  Widget build(BuildContext context)=> Scaffold(
    appBar: AppBar(
      leading: IconButton(
        onPressed: ()=>Navigator.of(context).pop(), 
        icon: const Icon(Icons.arrow_back),
      ),
      title: const Text('Competition',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      
    ),
    body: const Center(child:Text('Lwandile')),
  );
  
}