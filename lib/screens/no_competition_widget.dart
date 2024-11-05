import 'package:flutter/material.dart';

import 'store_info_widget.dart';
import 'dart:developer' as debug;

class NoCompetitionWidget extends StoreInfoWidget {
  NoCompetitionWidget({
    super.key,
    required storeId,
    required storeName,
    required storeImageURL,
    required sectionName,
  }) : super(
          storeId: storeId,
          storeName: storeName,
          storeImageURL: storeImageURL,
          sectionName: sectionName,
        );

  @override
  State createState() => NoCompetitionWidgetState();
}

class NoCompetitionWidgetState extends State<NoCompetitionWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.createStoreImageURL(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child:
                    widget.retrieveStoreImage(context, snapshot.data as String),
              ),
              widget.retrieveStoreDetails(context),
              const Center(
                  child: Text(
                'No Competition',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              )),
            ]);
          } else if (snapshot.hasError) {
            debug.log(
                "Error Fetching Data No Store Image Data- ${snapshot.error}");
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
