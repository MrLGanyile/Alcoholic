import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

import '../../controllers/store_controller.dart';
import "dart:developer" as debug;

class CompetitionScreenHelper extends StatefulWidget {
  String grandPriceImageURL;
  AlignmentGeometry? alignmentGeometry;
  bool isPointed;

  CompetitionScreenHelper({
    super.key,
    required this.grandPriceImageURL,
    this.alignmentGeometry = Alignment.centerLeft,
    this.isPointed = false,
  });

  @override
  CompetitionScreenHelperState createState() => CompetitionScreenHelperState();
}

class CompetitionScreenHelperState extends State<CompetitionScreenHelper> {
  StoreController storeController = StoreController.storeController;
  Reference storageReference = FirebaseStorage.instance
      .refFromURL("gs://alcoholic-expressions.appspot.com/");

  Future<String> retrieveGrandPriceImageURL() {
    return storageReference.child(widget.grandPriceImageURL).getDownloadURL();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget showGrandPrice() {
    return FutureBuilder(
        future: retrieveGrandPriceImageURL(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Align(
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(snapshot.data! as String),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            debug.log(
                'Error Fetching Draw Grand Price Image - ${snapshot.error}');
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

  @override
  Widget build(BuildContext context) => Expanded(
        child: widget.isPointed
            ? Stack(children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
                showGrandPrice(),
              ])
            : showGrandPrice(),
      );
}
