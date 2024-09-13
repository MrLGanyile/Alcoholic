import 'package:flutter/material.dart';

import '../../main.dart';

enum SearchCategory {
  searchByAlcohol,
  searchByStore,
  searchBySuburb,
}

enum AlcoholSearchedBy {
  nearest,
  price,
  dates,
}

enum WonPricesOrder {
  location,
  price,
}

enum ToPage {
  chatsWidget,
  winnerScreen,
  postsWidget,
}

enum AlcoholType {
  beer,
  cider,
  wine,
  vodka,
}

enum FoundStoreType {
  storeWithCompetitionToCome,
  storeWithNoCompetitionToCome,
  storeWithWinner,
}

enum StoreJoinStatus {
  approved,
  alreadyJoined,
  needToLoginOrRegister,
}

typedef StartScreenIndexManager = Function(int index);

class Global {
  // -----------Below : Action Buttions Style And Decoration.-----------
  static TextStyle actionButtonStyle = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  static BoxDecoration actionButtonDecoration = const BoxDecoration(
    color: Color.fromARGB(255, 44, 35, 46),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );
  // -----------Above : Action Buttions Style And Decoration.-----------
}
