import 'package:flutter/material.dart';


import '../../models/prototype/samples_for_testing.dart';
import 'store_info_widget.dart';

class NoCompetitionWidget  extends StoreInfoWidget{

  SampleForTesting sampleForTesting;

  NoCompetitionWidget({super.key, 
    required store,
    required this.sampleForTesting,
    required duration,
  }):super(
    store:store,
    duration: duration,
  );

  @override
  State createState() =>NoCompetitionWidgetState();

}

class NoCompetitionWidgetState extends State<NoCompetitionWidget>{

  @override
  Widget build(BuildContext context) => Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical:20),
          child: widget.retrieveStoreImage(context),
        ),
        widget.retrieveStoreDetails(context),
        const Center(child: Text('No Competition', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),))
      ]
    );

}