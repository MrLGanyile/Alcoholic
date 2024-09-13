import 'package:flutter/material.dart';

import 'competition_widget.dart';
import '../page_navigation.dart';
import 'store_info_widget.dart';
import '../../main.dart';

class OnPlayWidget extends StoreInfoWidget {
  OnPlayWidget({
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
  State createState() => OnPlayWidgetState();
}

class OnPlayWidgetState extends State<OnPlayWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.42,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: widget.retrieveStoreImage(context),
          ),
          widget.retrieveStoreDetails(context),
          IconButton(
            onPressed: (() => Navigator.of(context).push(
                  CustomPageRoute(child: const CompetitionWidget()),
                )),
            icon: Icon(
              color: Colors.green,
              Icons.play_circle,
              size: MyApplication.playCompetitionIconFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
