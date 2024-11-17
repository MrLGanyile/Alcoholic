import 'package:flutter/material.dart';

import 'competition_widget.dart';
import 'page_navigation.dart';
import 'store_info_widget.dart';
import '../../main.dart';

typedef OnCurrentlyViewedUpdate = Function(bool);

class OnPlayWidget extends StoreInfoWidget {
  OnCurrentlyViewedUpdate onCurrentlyViewedUpdate;

  OnPlayWidget({
    super.key,
    required storeId,
    required storeName,
    required storeImageURL,
    required sectionName,
    required this.onCurrentlyViewedUpdate,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: IconButton(
        onPressed:
            (/*() => Navigator.of(context).push(
              CustomPageRoute(child: const CompetitionWidget()),
            )*/
                () => widget.onCurrentlyViewedUpdate(true)),
        icon: Icon(
          color: Colors.green,
          Icons.play_circle,
          size: MyApplication.playCompetitionIconFontSize,
        ),
      ),
    );
  }
}
