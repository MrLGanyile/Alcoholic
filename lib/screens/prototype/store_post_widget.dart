import 'package:flutter/material.dart';

import '../../main.dart';

abstract class StorePostWidget extends StatefulWidget {
  int numberOfLikes = 0;
  int numberOfComments = 0;
  int numberOfShares = 0;

  double userImageRadius = 20;

  late Row postHeading;

  StorePostWidget();

  void createStorePostHeading(BuildContext context, String creatorImageLocation,
      String creatorUsername) {
    postHeading = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Currently Logged In User Image.
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              radius: userImageRadius,
              backgroundColor: Colors.orange,
              backgroundImage: AssetImage(
                creatorImageLocation,
              ),
              /*backgroundImage: NetworkImage(
                        widget.wonPrice.competition.winner!.findImageLocation(),
                    ),*/
            ),
          ),
        ),
        // Currently Logged In User Username, Passed Time Since Post Published,
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Currently Logged In User Username
                  Text(creatorUsername,
                      style: TextStyle(
                        fontSize: MyApplication.infoTextFontSize + 5,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      )),
                  // How Long Since The Post Is Published
                  const Text('1 week',
                      style: TextStyle(fontSize: 12, color: Colors.grey))
                ],
              ),
            ),
          ),
        ),
        // More Actions On A Post Icon
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.more_horiz),
            iconSize: 30,
            color: Colors.grey,
            onPressed: (() {}),
          ),
        ),
      ],
    );
  }

  void incrementNumberOfLikes() {
    numberOfLikes++;
  }

  void incrememntNumberOfComments() {
    numberOfComments++;
  }

  void incrementNumberOfShares() {
    numberOfShares++;
  }
}
