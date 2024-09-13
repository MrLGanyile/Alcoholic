
import 'package:flutter/material.dart';

import '../../models/prototype/samples_for_testing.dart';
import '../../models/prototype/old_competition.dart';


class CompetitionScreenHelper extends StatefulWidget{

  final Competition competition;
  final int grandPriceIndex;  
  final bool isLive;
  AlignmentGeometry? alignmentGeometry;

  SampleForTesting sampleForTesting;

  CompetitionScreenHelper({super.key, 
    required this.competition,
    required this.grandPriceIndex,
    required this.isLive,
    required this.sampleForTesting,
    this.alignmentGeometry = Alignment.centerLeft,
  });
  

  @override 
  CompetitionScreenHelperState createState()=>CompetitionScreenHelperState();
}

class CompetitionScreenHelperState extends State<CompetitionScreenHelper>{

  void updateIsPointed(){
    setState(() {/*
      widget.sampleForTesting.updateGrandPriceIsPointed(widget.competition.competitionId!, 
      widget.competition.grandPrices[widget.grandPriceIndex].grandPriceId!);*/
    });
  }

  Widget? _buildPointer(){

    if(widget.competition.grandPrices[widget.grandPriceIndex].isPointed){
      return 
      // Display this ball on the correct current price to win.
      Container(
        width: 35,
        height: 35,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,

        ),  
      );
    }

    return null;
    
  }
  
  Widget showGrandPrice(){
    
    return Align(

      child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: AssetImage(widget.competition.grandPrices[widget.grandPriceIndex].imageLocation!),
              fit:BoxFit.cover,
            ),
            
          ),
          //child: Image(image: AssetImage(widget.competition.grandPrices[widget.grandPriceIndex].imageLocation!),),
          
            /*Image.network(
            
            widget.sampleForTesting.readGrandPrice(widget.competition.competitionId!, 
            widget.competition.grandPrices[widget.grandPriceIndex].grandPriceId!
            )!.imageLocation??= widget.sampleForTesting.readGrandPrice(widget.competition.
            competitionId!, widget.competition.grandPrices[widget.grandPriceIndex].
            grandPriceId!)!.drinks[0].imageLocation,
            color: Colors.green,
            fit: BoxFit.cover,
          ), */            
        ),
    );
    
  }
  
  @override
  Widget build(BuildContext context)=>Expanded(
    child: Stack(
      children: [
        //_buildPointer()!,
        showGrandPrice()
      ],
    ),
  );
  
}