import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/prototype/old_store.dart';

class StoreInfoWidget extends StatefulWidget {
  Store store;
  Duration duration;

  StoreInfoWidget({
    Key? key,
    required this.store,
    required this.duration,
  }) : super(key: key);

  int findSpecialDateIndex() {
    DateTime now = DateTime.now();

    for (int i = 0; i < store.competitions.length; i++) {
      if (store.competitions[i].dateTime.year == now.year &&
          store.competitions[i].dateTime.month == now.month &&
          store.competitions[i].dateTime.day == now.day) {
        return i;
      }
    }
    return -1;
  }

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
                    color: MyApplication.storesTextColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  store.storeName,
                  style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    fontWeight: FontWeight.bold,
                    color: MyApplication.storesTextColor,
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
                    color: MyApplication.storesTextColor,
                    decoration: TextDecoration.none),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${store.sectionName}',
                  style: TextStyle(
                      fontSize: MyApplication.infoTextFontSize,
                      fontWeight: FontWeight.bold,
                      color: MyApplication.storesTextColor,
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
            fit: BoxFit.cover,
            image: AssetImage(store.picPath + store.picName),
            //image: NetworkImage(store.picPath + store.picName)
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => StoreInfoWidgetState();
}

class StoreInfoWidgetState extends State<StoreInfoWidget> {
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
