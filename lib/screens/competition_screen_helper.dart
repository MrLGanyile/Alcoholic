import '../models/stores/draw_grand_price.dart';
import 'package:flutter/material.dart';

import '../../controllers/store_controller.dart';
import '../../models/stores/store_draw.dart';

class CompetitionScreenHelper extends StatefulWidget {
  final StoreDraw storeDraw;
  final int grandPriceIndex;
  AlignmentGeometry? alignmentGeometry;

  CompetitionScreenHelper({
    super.key,
    required this.storeDraw,
    required this.grandPriceIndex,
    this.alignmentGeometry = Alignment.centerLeft,
  });

  @override
  CompetitionScreenHelperState createState() => CompetitionScreenHelperState();
}

class CompetitionScreenHelperState extends State<CompetitionScreenHelper> {
  StoreController storeController = StoreController.storeController;
  late List<DrawGrandPrice> drawGrandPrices;

  @override
  void initState() {
    super.initState();

    drawGrandPrices = storeController.findDrawGrandPrices(
            widget.storeDraw.storeFK, widget.storeDraw.storeDrawId)
        as List<DrawGrandPrice>;
  }

  Widget showGrandPrice() {
    return Align(
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(30),
          image: const DecorationImage(
            image: AssetImage(''),
            //image: AssetImage(drawGrandPrices[widget.grandPriceIndex].imageURL),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Expanded(child: showGrandPrice());
}
