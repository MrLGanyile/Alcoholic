import 'package:flutter/material.dart';


import 'store_info_widget.dart';

class NoCompetitionWidget  extends StoreInfoWidget{

  NoCompetitionWidget({super.key, 
    required storeId,
    required storeName,
    required storeImageURL,
    required sectionName,
  }):super(
    storeId:storeId,
    storeName:storeName,
    storeImageURL:storeImageURL,
    sectionName:sectionName,
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