import '../../controllers/production/store_controller.dart';
import '../../models/production/stores/store_draw.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/section_name.dart';

class StoreInfoWidget extends StatefulWidget {
  String storeName;
  String storeId;
  String storeImageURL;
  SectionName sectionName;

  StoreInfoWidget({
    super.key,
    required this.storeId,
    required this.storeName,
    required this.storeImageURL,
    required this.sectionName,
  });

  Column retrieveStoreDetails(BuildContext context) {
    // Information About The Hosting Store.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The Name Of A Store On Which The Winner Won From.
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Store Name',
                style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    color: MyApplication.storeInfoTextColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  storeName,
                  style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    fontWeight: FontWeight.bold,
                    color: MyApplication.storeInfoTextColor,
                    decoration: TextDecoration.none,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),

        // The Location Of A Store On Which The Winner Won From.
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Store Location',
                style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    fontWeight: FontWeight.bold,
                    color: MyApplication.storeInfoTextColor,
                    decoration: TextDecoration.none),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  sectionName.toString(),
                  style: TextStyle(
                      fontSize: MyApplication.infoTextFontSize,
                      fontWeight: FontWeight.bold,
                      color: MyApplication.storeInfoTextColor,
                      decoration: TextDecoration.none,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  AspectRatio retrieveStoreImage(BuildContext context) {
    // The Image Of A Store On Which The Winner Won From.
    return AspectRatio(
      aspectRatio: 5 / 2,
      child: Container(
        //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8) ,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(storeImageURL)),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => StoreInfoWidgetState();
}

class StoreInfoWidgetState extends State<StoreInfoWidget> {
  StoreController storeController = StoreController.storeController;
  late List<StoreDraw> storeDraws;

  @override
  void initState() {
    super.initState();
    storeDraws =
        storeController.findStoreDraws(widget.storeId) as List<StoreDraw>;
  }

  int findSpecialDateIndex() {
    DateTime now = DateTime.now();

    for (int i = 0; i < storeDraws.length; i++) {
      if (storeDraws[i].drawDateAndTime.year == now.year &&
          storeDraws[i].drawDateAndTime.month == now.month &&
          storeDraws[i].drawDateAndTime.day == now.day) {
        return i;
      }
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 150, child: widget.retrieveStoreImage(context)),
        SizedBox(
          height: 50,
          child: widget.retrieveStoreDetails(context),
        ),
      ],
    );
  }
}
