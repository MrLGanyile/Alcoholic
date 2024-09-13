import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/prototype/old_won_price.dart';
import 'store_info_widget.dart';

class WinnerWidget extends StatefulWidget {
  final WonPrice wonPrice;
  final bool showStoreInfoFirst;
  final Duration duration;

  const WinnerWidget({
    super.key,
    required this.wonPrice,
    this.showStoreInfoFirst = false,
    required this.duration,
  });

  @override
  WinnerWidgetState createState() => WinnerWidgetState();
}

class WinnerWidgetState extends State<WinnerWidget> {
  bool isKnown = false;
  String groupValue = '1';

  void onKnownChanged(value) {
    setState(() {
      if (value == 'Yes') {
        isKnown = true;
      } else {
        isKnown = false;
      }
    });
  }

  // Ask If The Current User Knows The Winner.
  Widget ask() => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            Text(
              'Do You Know ${widget.wonPrice.competition.winner!.isMale ? 'Him?' : 'Her?'}',
              style: TextStyle(
                fontSize: MyApplication.infoTextFontSize,
                color: MyApplication.storesTextColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
            Row(
              children: [
                Radio(
                    value: '1',
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value.toString();
                      });
                    }),
                Text(
                  'No',
                  style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    color: MyApplication.storesTextColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                Radio(
                    value: '2',
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value.toString();
                      });
                    }),
                Text(
                  'Yes',
                  style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    color: MyApplication.storesTextColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  // The Image Of A Winner.
  Center winnerImage() => Center(
        child: CircleAvatar(
          radius: MediaQuery.of(context).size.width / 4,
          backgroundColor: Colors.orange,
          backgroundImage: AssetImage(
            widget.wonPrice.competition.winner!.findImageLocation(),
          ),
          /*backgroundImage: NetworkImage(
        widget.wonPrice.competition.winner!.findImageLocation(),
      ),*/
        ),
      );

  // Information About The Price Won.
  Column priceInfo(BuildContext context) {
    String wonPriceDescription = widget.wonPrice.grandPrice.description;

    double screenWidth = MediaQuery.of(context).size.width;
    int singleLineMaxNoOfCharacters = screenWidth ~/ 9;

    double containerHeight;

    if (wonPriceDescription.length > singleLineMaxNoOfCharacters) {
      containerHeight =
          18 * (wonPriceDescription.length / singleLineMaxNoOfCharacters);
    } else {
      containerHeight = 18;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The Details Of What Is Won.
        Center(
          child: SizedBox(
            height: containerHeight,
            child: Text(
              'Won Price [${widget.wonPrice.grandPrice.description}]',
              style: TextStyle(
                color: MyApplication.storesSpecialTextColor,
                fontSize: MyApplication.infoTextFontSize,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,

                //overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        // Winner's Information
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Winner Username',
              style: TextStyle(
                fontSize: MyApplication.infoTextFontSize,
                color: MyApplication.storesTextColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
            Text(
              widget.wonPrice.competition.winner!.username,
              style: TextStyle(
                fontSize: MyApplication.infoTextFontSize,
                color: MyApplication.storesTextColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),

        // The Winning Date.
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Winning Date',
              style: TextStyle(
                fontSize: MyApplication.infoTextFontSize,
                color: MyApplication.storesTextColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
            Text(
              widget.wonPrice.competition.dateTime.toString().substring(0, 10),
              style: TextStyle(
                fontSize: MyApplication.infoTextFontSize,
                color: MyApplication.storesTextColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          children: [
            // Information About The Hosting Store.
            StoreInfoWidget(
              store: widget.wonPrice.store,
              duration: widget.duration,
            ),
            ask(),
            winnerImage(),
            priceInfo(context),
          ],
        ),
      );

  onTap(BuildContext context) {}
}
