import 'package:alcoholic/phone%20auth%20example/screens/verify_phone_number_screen%20copy.dart';
import 'package:alcoholic/screens/store_registration_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/production/store_controller.dart';
import '/controllers/production/user_controller.dart';
import '/controllers/production/authentication_controller.dart';

import 'firebase_options.dart';
import 'models/production/production_testing.dart';
import 'models/prototype/old_user.dart';
import 'models/prototype/samples_for_testing.dart';
import 'phone auth example/screens/authentication_screen.dart';
import 'screens/start_screen.dart';
import 'models/prototype/old_user.dart' as myuser;

import 'controllers/production/store_controller.dart';
import 'firebase_options.dart';
import 'models/production/production_testing.dart';
import 'models/prototype/samples_for_testing.dart';
import 'screens/alcoholic_registration_widget.dart';
import 'screens/start_screen.dart';

import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(StoreController());
    Get.put(AuthenticationController());
    Get.put(UserController());
  });
  // Ideal time to initialize
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  await FirebaseStorage.instance.useStorageEmulator('127.0.0.1', 9199);
  FirebaseFunctions.instance.useFunctionsEmulator('127.0.0.1', 5001);
  FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8089);
  runApp(MyApplication());
}
/*
void main() {
  Get.put(StoreController());
  Get.put(AuthenticationController());
  Get.put(UserController());
  runApp(MyApplication());
}*/

class MyApplication extends StatefulWidget {
  MyApplication({super.key});

  static String title = 'Alcoholic';
  final SampleForTesting sampleForTesting = SampleForTesting();
  //final ProductionTesting productionTesting = ProductionTesting();
  // Assets are not added into the pubspec.yaml file.

  static EdgeInsets storeDataPadding =
      const EdgeInsets.only(left: 20, right: 20, top: 10);

  //static Color scaffoldColor = const Color.fromARGB(240, 23, 212, 212);
  static Color scaffoldColor = const Color.fromARGB(31, 1, 24, 24);

  static Color scaffoldBodyColor = const Color.fromARGB(255, 173, 235, 229);

  static LinearGradient priceslinearGradient = const LinearGradient(
    colors: [Colors.white, Color.fromARGB(255, 44, 35, 46)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  static Color textColor = const Color.fromARGB(255, 154, 46, 173);
  static double infoTextFontSize = 15;

  static Color storeInfoTextColor = Colors.lightBlue;
  //static Color storeInfoTextColor = const Color.fromARGB(169, 27, 3, 114);

  static Color storesTextColor = const Color.fromARGB(255, 40, 236, 210);
  static Color storesSpecialTextColor = const Color.fromARGB(255, 244, 3, 184);

  //static Color headingColor = const Color.fromARGB(169, 106, 3, 124);
  static Color headingColor = Colors.white;

  static Color logoColor1 = Colors.green;
  static Color logoColor2 = Colors.blue;

  static String userPhoneNumber = '';

  static myuser.User? currentUser;

  static BoxDecoration userThoughtsAreaDecoration = const BoxDecoration(
      color: Color.fromARGB(255, 190, 183, 209),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ));

  static BoxDecoration userThoughtsDecoration = const BoxDecoration(
      color: Color.fromARGB(255, 182, 142, 189),
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(20),
      ));

  static TextStyle usernameStyle = const TextStyle(
    color: Colors.grey,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  static TextStyle userMessageStyle = const TextStyle(
    color: Colors.blueGrey,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static double playCompetitionIconFontSize = 75;
  static double alarmIconFontSize = 60;

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  @override
  void initState() {
    // This method execute only when this state is created for the first time.
    // It get executed befor the build method.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
        child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alcoholic',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(115, 231, 195, 214),
        secondaryHeaderColor: const Color.fromARGB(115, 231, 195, 214),
      ),

      //home: StartScreen(sampleForTesting: widget.sampleForTesting),
      home: AlcoholicRegistrationWidget(),
      //home: StoreRegistrationWidget(),

      //home: StoreInfoWidget(store:SampleForTesting.allRegisteredStores[0]),
      //home: OnPlayWidget(store:SampleForTesting.allRegisteredStores[0]),
      //home: OnWaitWidget(store:SampleForTesting.allRegisteredStores[0], sampleForTesting: widget.l  sampleForTesting,),
      //home: StoresWidget(sampleForTesting: widget.sampleForTesting,),
      //home: Center(child:Text('Lwandile')),
      //home: WinnerWidget(wonPrice: SampleForTesting.allRegisteredWonPrices[0],/*SampleForTesting.allRegisteredStores[0].lastWonPrice!*/)
    ));

    /*
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alcoholic',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(115, 231, 195, 214),
        secondaryHeaderColor: const Color.fromARGB(115, 231, 195, 214),
      ),

      //home: AlcoholicRegistrationWidget(),
      home: StartScreen(sampleForTesting: widget.sampleForTesting),
      //home: StoreInfoWidget(store:SampleForTesting.allRegisteredStores[0]),
      //home: OnPlayWidget(store:SampleForTesting.allRegisteredStores[0]),
      //home: OnWaitWidget(store:SampleForTesting.allRegisteredStores[0], sampleForTesting: widget.l  sampleForTesting,),
      //home: StoresWidget(sampleForTesting: widget.sampleForTesting,),
      //home: Center(child:Text('Lwandile')),
      //home: WinnerWidget(wonPrice: SampleForTesting.allRegisteredWonPrices[0],/*SampleForTesting.allRegisteredStores[0].lastWonPrice!*/)
    );*/
  }
}
