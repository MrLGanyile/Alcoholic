import 'dart:math';

import 'package:alcoholic/main.dart';
import 'package:alcoholic/models/social/won_price_summary_comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as debug;

class SingleCommentWidget extends StatelessWidget {
  WonPriceSummaryComment comment;

  SingleCommentWidget({
    required this.comment,
  });

  Future<String> createProfileImageURL() async {
    return FirebaseStorage.instance
        .refFromURL("gs://alcoholic-expressions.appspot.com/")
        .child(comment.creatorImageURL)
        .getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = comment.dateCreated.difference(DateTime.now());

    String passedTimeRepresentation;
    if (duration.inMinutes <= 1) {
      passedTimeRepresentation = 'now';
    } else if (duration.inMinutes <= 59) {
      passedTimeRepresentation = '${duration.inMinutes}mins';
    } else if (duration.inMinutes < 120) {
      passedTimeRepresentation = '1h';
    } else if (duration.inMinutes < 60 * 24) {
      passedTimeRepresentation = '${duration.inMinutes}h';
    } else if (duration.inMinutes < 60 * 24 * 7) {
      passedTimeRepresentation = '${duration.inMinutes}d';
    } else {
      passedTimeRepresentation = '${duration.inMinutes / (60 * 24 * 7)}w';
    }

    int messageLength = comment.message.length;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: FutureBuilder(
                    future: createProfileImageURL(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.lightBlue,
                          ),
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width / 12,
                            backgroundImage:
                                NetworkImage(snapshot.data as String),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        debug.log(
                            'Error Fetching Commenter\'s Profile Image ${snapshot.error}');
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                Text(
                  comment.creatorUsername,
                  style: TextStyle(
                      fontSize: 12,
                      color: MyApplication.logoColor1,
                      decoration: TextDecoration.none,
                      overflow: TextOverflow.ellipsis),
                ),
                Text(
                  passedTimeRepresentation,
                  style: TextStyle(
                      fontSize: 12,
                      color: MyApplication.logoColor2,
                      decoration: TextDecoration.none,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height:
                  messageLength > 35 ? (comment.message.length / 35) * 40 : 60,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  comment.message,
                  style: TextStyle(
                    color: MyApplication.scaffoldBodyColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
