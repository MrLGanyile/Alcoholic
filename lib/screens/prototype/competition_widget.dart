import 'package:flutter/material.dart';

import '../../models/prototype/old_store.dart';

class CompetitionWidget extends StatefulWidget{

  
  final Store store;

  const CompetitionWidget({
    super.key, 
    required this.store,
  });

  @override 
  CompetitionWidgetState createState()=>CompetitionWidgetState();
}

class CompetitionWidgetState extends State<CompetitionWidget>{
  
  int _findSpecialDateIndex(){

    for(int i = 0; i < widget.store.competitions.length;i++){
      if(widget.store.competitions[i].dateTime.year==DateTime.now().year &&
      widget.store.competitions[i].dateTime.month==DateTime.now().month &&
      widget.store.competitions[i].dateTime.day==DateTime.now().day){
        return i;
      }
    }
    return -1;
  }

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