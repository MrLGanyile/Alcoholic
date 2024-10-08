import 'dart:io';
import 'dart:developer' as debug;
import 'dart:math';

import 'package:alcoholic/models/production/stores/won_price_summary.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/production/competitions/competition.dart';
import '../../models/production/competitions/group_competitor_token.dart';
import '../../models/production/competitions/group_competitors_grid.dart';
import '../../models/production/competitions/grand_price_token.dart';
import '../../models/production/competitions/grand_prices_grid.dart';
import '../../models/production/stores/draw_group_competitor.dart';
import '../../models/production/stores/draw_grand_price.dart';
import '../../models/production/stores/store_owner.dart';
import '../../models/section_name.dart';
import '../../models/production/stores/store_draw.dart';
import '../../models/production/stores/store_name_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/production/stores/store.dart';
import '../share_dao_functions.dart';

class StoreController extends GetxController {
  static StoreController storeController = Get.find();

  late Rx<File?> storePickedFile;
  File? get storeImageFile => storePickedFile.value;

  void chooseStoreImageFromGallery() async {
    final storePickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (storePickedImageFile != null) {
      //Get.snackbar('Image Status', 'Image File Successfully Picked.');

    }

    // Share the chosen image file on Getx State Management.
    storePickedFile = Rx<File?>(File(storePickedImageFile!.path));
  }

  void captureStoreImageWithCamera() async {
    final storePickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (storePickedImageFile != null) {
      Get.snackbar('Image Status', 'Image File Successfully Captured.');
    }

    // Share the chosen image file on Getx State Management.
    storePickedFile = Rx<File?>(File(storePickedImageFile!.path));
  }

  /*===========================Stores [Start]============================= */
  // Assets are not added into the pubspec.yaml file.
  void saveStore(
      String storeName,
      SectionName sectionName,
      File storeImage,
      String fullname,
      String surname,
      String phoneNumber,
      File ownerProfileImage,
      File identityDocumentImage) async {
    try {
      /**#############################Store#############################*/
      // 'gs://alcoholic-expressions.appspot.com/store_owners/store_images/+27674533323.jpg'
      // 1. Create download URL & save store image in firebase storage.
      String storeImageURL = await uploadResource(
          storeImage, '/store_owners/$phoneNumber/store_images/$phoneNumber');

      // Convert SectionName Enum To Proper String With Dashes.

      // 2. Create store object for the cloud firestore database.
      Store store = Store(
        storeOwnerPhoneNumber: phoneNumber,
        storeName: storeName,
        storeImageURL: storeImageURL,
        sectionName: sectionName,
      );

      // 3. Save store object
      await FirebaseFirestore.instance
          .collection('stores')
          .doc(phoneNumber)
          .set(store.toJson());

      /**#####################Store Name Info#######################*/
      /* The createStoreNameInfo cloud function will be called 
      behind the scenes each time a new store object is created.*/

      /**#########################Store Owner#########################*/

      // 'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_images/+27674533323.jpg'
      // 1.. Create download URL & save store owner profile image in firebase storage.
      String ownerImageURL = await uploadResource(ownerProfileImage,
          '/store_owners/$phoneNumber/store_owners_images/$phoneNumber');

      // 'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_ids/+27674533323.jpg'
      // 2. Create download URL & save store owner identity image in firebase storage.
      String identityDocumentImageURL = await uploadResource(
          identityDocumentImage,
          '/store_owners/$phoneNumber/store_owners_ids/$phoneNumber');

      // 3. Create user object for the cloud firestore database.
      StoreOwner storeOwner = StoreOwner(
        fullname: fullname,
        surname: surname,
        phoneNumber: phoneNumber,
        profileImageURL: ownerImageURL,
        identityDocumentImageURL: identityDocumentImageURL,
      );

      // 5. Save the user object in the database.
      await FirebaseFirestore.instance
          .collection('store_owners')
          .doc(phoneNumber)
          .set(storeOwner.toJson());
      showProgressBar = false;
    } catch (error) {
      //Get.snackbar("Saving Error", "Store Couldn'\t Be Saved.");
      debug.log(error.toString());
      showProgressBar = false;
    }
  }

  Future<Store?> findStore(String storeId) async {
    DocumentReference reference =
        FirebaseFirestore.instance.collection('stores').doc(storeId);

    DocumentSnapshot snapshot = await reference.get();

    if (snapshot.exists) {
      return Store.fromJson(snapshot.data()!);
    }

    return null;
  }

  // Update - reference.update({'key': 'new value'} or {'param.key': 'new value'})
  // Remove A Field - update({'key': FieldValue.delete())
  void deleteStore(String storeId) {
    DocumentReference reference =
        FirebaseFirestore.instance.collection('stores.').doc(storeId);

    reference.delete();

    // Write a query deleting all necessary sub collections.
  }

/*===========================Stores [End]============================= */

/*======================Store Name Info [Start]======================== */
  Stream<List<StoreNameInfo>> readAllStoreNameInfo() {
    Stream<List<StoreNameInfo>> stream = FirebaseFirestore.instance
        .collection('stores_names_info')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              StoreNameInfo info = StoreNameInfo.fromJson(doc.data());
              debug.log(info.toString());
              return info;
            }).toList());

    return stream;
  }

/*======================Store Name Info [End]======================== */

  void tokensCreationCloudFunction(
      StoreDraw storeDraw, String grandPriceGridId, String competitorsGridId) {
    // To be used when saving both grand price tokens and competitor tokens into the database.
    DocumentReference reference;

    // Query a collection of draw grand prices by getting draw grand prices for this particular StoreDraw.
    Query<Map<String, dynamic>> drawGrandPricesQuery = FirebaseFirestore
        .instance
        .collection(
            'store/${storeDraw.storeFK}/store_draws/${storeDraw.storeDrawId}/draw_grand_prices')
        .where('Store Draw Id', isEqualTo: storeDraw.storeDrawId);

    // Store all the retrieved draw grand prices as a list.
    Stream<List<DrawGrandPrice>> drawGrandPrices =
        drawGrandPricesQuery.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        DrawGrandPrice drawGrandPrice = DrawGrandPrice.fromJson(doc);
        return drawGrandPrice;
      }).toList();
    });

    // Convert each drawGrandPrice into a grandPriceToken and save it.
    drawGrandPrices.forEach((list) async {
      for (var i = 0; i < list.length; i++) {
        DrawGrandPrice drawGrandPrice = list[i];
        reference = FirebaseFirestore.instance
            .collection(
                'competitions/${storeDraw.storeDrawId}grand_prices_grid/$grandPriceGridId/grand_price_tokens')
            .doc(drawGrandPrice.grandPriceId);

        await reference
            .set(GrandPriceToken.fromDrawGrandPrice(drawGrandPrice).toJson());
      }
    });

    // Query a collection of draw competitors by getting draw competitors for this particular StoreDraw.
    Query<Map<String, dynamic>> drawCompetitorsQuery = FirebaseFirestore
        .instance
        .collection(
            'store/${storeDraw.storeFK}/store_draws/${storeDraw.storeDrawId}/draw_competitors')
        .where('Store Draw Id', isEqualTo: storeDraw.storeDrawId);

    // Store all the retrieved draw competitors as a list.
    Stream<List<DrawGroupCompetitor>> drawCompetitors =
        drawCompetitorsQuery.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        DrawGroupCompetitor drawCompetitor = DrawGroupCompetitor.fromJson(doc);
        return drawCompetitor;
      }).toList();
    });

    // Convert each drawCompetitor into a competitorToken and save it.
    drawCompetitors.forEach((list) async {
      for (var i = 0; i < list.length; i++) {
        DrawGroupCompetitor drawGroupCompetitor = list[i];
        reference = FirebaseFirestore.instance
            .collection(
                'competitions/${storeDraw.storeDrawId}/competitors_grids/$competitorsGridId/competitors_tokens')
            .doc(drawGroupCompetitor.groupCompetitorId);

        await reference.set(
            GroupCompetitorToken.fromDrawCompetitor(drawGroupCompetitor)
                .toJson());
      }
    });
  }

  /*=========================Store Draws [Start]========================= */
  void saveStoreDraw(
      String storeFK,
      DateTime drawDateAndTime,
      double joiningFee,
      int numberOfGroupCompetitorsSoFar,
      String storeName,
      String storeImageURL,
      SectionName sectionName,
      List<DrawGrandPrice> drawGrandPrices,
      List<File> drawGrandPricesFiles) async {
    try {
      // Start By Saving The Grand Prices Before Saving The Store Draw.
      // The passed in list of draw grand prices has object with only
      // two attributes namely description and grandPriceIndex. The other
      // fields like drawGrandPriceId, imageURL, and storeDrawFK has to be
      // created within this function/method.
      // The second list contails images of the chosen grand prices.

      // 1. Specifying where the store draw object will be saved in the database.
      DocumentReference reference = FirebaseFirestore.instance
          .collection('store/$storeFK/store_draws')
          .doc();

      // 1. Specifying where the store draw object will be saved in the database.
      reference = FirebaseFirestore.instance
          .collection('store/$storeFK/store_draws')
          .doc();

      // 2. Create store draw object into the cloud firestore database.
      StoreDraw storeDraw = StoreDraw(
        storeDrawId: reference.id,
        storeFK: storeFK,
        drawDateAndTime: drawDateAndTime,
        joiningFee: joiningFee,
        numberOfGrandPrices: drawGrandPrices.length,
        numberOfGroupCompetitorsSoFar: numberOfGroupCompetitorsSoFar,
        storeName: storeName,
        storeImageURL: storeImageURL,
        sectionName: sectionName,
      );

      // 3. Save store draw object
      reference.set(storeDraw.toJson());

      Get.snackbar("Store Draw Saved", "New Store Draw Was Saved Successfully");
      showProgressBar = false;
    } catch (error) {
      Get.snackbar("Saving Error", "Store Draw Couldn'\t Be Saved.");
      showProgressBar = false;
    }
  }

  Stream<List<StoreDraw>> findStoreDraws(String storeFK) => FirebaseFirestore
      .instance
      .collection('stores')
      .doc(storeFK)
      .collection('store_draws')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => StoreDraw.fromJson(doc.data())).toList());

  Future<StoreDraw?> findStoreDraw(String storeFK, String storeDrawId) async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection('stores')
        .doc(storeFK)
        .collection('store_draws')
        .doc(storeDrawId);

    DocumentSnapshot snapshot = await reference.get();

    if (snapshot.exists) {
      return StoreDraw.fromJson(snapshot.data()!);
    }

    return null;
  }

  void incrementNumberOfCompetitorsSoFar(
      String storeFK, String storeDrawId, int numberOfGroupCompetitorsSoFar) {
    StoreDraw storeDraw = findStoreDraw(storeFK, storeDrawId) as StoreDraw;

    FirebaseFirestore.instance
        .collection('stores')
        .doc(storeFK)
        .collection('store_draws')
        .doc(storeDrawId)
        .update({
      'numberOfGroupCompetitorsSoFar':
          storeDraw.numberOfGroupCompetitorsSoFar + 1
    });
  }

  void updateIsOpen(String storeFK, String storeDrawId, bool isOpen) {
    FirebaseFirestore.instance
        .collection('stores')
        .doc(storeFK)
        .collection('store_draws')
        .doc(storeDrawId)
        .update({'Is Open': isOpen});
  }

  void updateJoiningFee(String storeFK, String storeDrawId, double joiningFee) {
    if (joiningFee > 0) {
      FirebaseFirestore.instance
          .collection('stores')
          .doc(storeFK)
          .collection('store_draws')
          .doc(storeDrawId)
          .update({'Is Open': joiningFee});
    }
  }

  void deleteStoreDraw(String storeFK, String storeDrawId) {
    FirebaseFirestore.instance
        .collection('stores')
        .doc(storeFK)
        .collection('store_draws')
        .doc(storeDrawId)
        .delete();
  }

  /*===========================Store Draws [End]====================== */

  /*======================Draw Grand Price[Start]===================== */
  void saveDrawGrandPrice(
      String storeDrawFK, String imageURL, String description) {}

  Stream<List<DrawGrandPrice>> findDrawGrandPrices(
          String storeId, String storeDrawId) =>
      FirebaseFirestore.instance
          .collection('stores')
          .doc(storeId)
          .collection('store_draws')
          .doc(storeDrawId)
          .collection('draw_grand_prices')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => DrawGrandPrice.fromJson(doc.data()))
              .toList());

  Future<DrawGrandPrice?> findDrawGrandPrice(
      String storeFK, String storeDrawId, String drawGrandPriceId) async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection('stores')
        .doc(storeFK)
        .collection('store_draws')
        .doc(storeDrawId)
        .collection('draw_grand_prices')
        .doc(drawGrandPriceId);

    DocumentSnapshot snapshot = await reference.get();

    if (snapshot.exists) {
      return DrawGrandPrice.fromJson(snapshot.data()!);
    }

    return null;
  }

  void deleteDrawGrandPrice(
      String storeFK, String storeDrawId, String drawGrandPriceId) {
    FirebaseFirestore.instance
        .collection('stores')
        .doc(storeFK)
        .collection('store_draws')
        .doc(storeDrawId)
        .collection('draw_grand_prices')
        .doc(drawGrandPriceId)
        .delete();
  }
  /*======================Draw Grand Price[End]============================ */

  /*==========================Draw Competitor [Start]======================= */
  void saveDrawCompetitor(String userId, String imageURL, String storeDrawFK) {}

  Stream<List<DrawGroupCompetitor>> findDrawCompetitors(
          String storeId, String storeDrawId) =>
      FirebaseFirestore.instance
          .collection('stores')
          .doc(storeId)
          .collection('store_draws')
          .doc(storeDrawId)
          .collection('draw_competitors')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => DrawGroupCompetitor.fromJson(doc.data()))
              .toList());

  Future<DrawGroupCompetitor?> findDrawCompetitor(
      String storeFK, String storeDrawId, String drawCompetitorId) async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection('stores')
        .doc(storeFK)
        .collection('store_draws')
        .doc(storeDrawId)
        .collection('draw_competitors')
        .doc(drawCompetitorId);

    DocumentSnapshot snapshot = await reference.get();

    if (snapshot.exists) {
      return DrawGroupCompetitor.fromJson(snapshot.data()!);
    }

    return null;
  }

  void deleteDrawCompetitor(
      String storeFK, String storeDrawId, String drawCompetitorId) {
    FirebaseFirestore.instance
        .collection('stores')
        .doc(storeFK)
        .collection('store_draws')
        .doc(storeDrawId)
        .collection('draw_competitors')
        .doc(drawCompetitorId)
        .delete();
  }
  /*=========================Draw Competitor [End]======================= */

  /*=======================Won Price Summary [Start]===================== */
  Future<WonPriceSummary?> findWonPriceSummary(String storeFK) async {
    Future<QuerySnapshot> querySnapshot = FirebaseFirestore.instance
        .collection('won_prices_summaries')
        .where(storeFK, isEqualTo: storeFK)
        .get();

    querySnapshot.then((value) => value.docs.map((doc) {
          return WonPriceSummary.fromJson(doc.data());
        }));

    return null;
  }

  /*=======================Won Price Summary [End]===================== */

  /*=======================Competition [Start]===================== */

  Future<Competition?> findCompetition(String competitionId) async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection('competitions')
        .doc(competitionId);

    DocumentSnapshot snapshot = await reference.get();

    if (snapshot.exists) {
      return Competition.fromJson(snapshot.data()!);
    }

    return null;
  }
  /*=======================Competition [End]===================== */

  /*=======================Grand Price Grid [Start]===================== */

  Future<GrandPricesGrid?> findGrandPricesGrid(
      String competitionFK, String grandPricesGridId) async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection('competitions')
        .doc(competitionFK)
        .collection('grand_prices_grids')
        .doc(grandPricesGridId);

    DocumentSnapshot snapshot = await reference.get();

    if (snapshot.exists) {
      return GrandPricesGrid.fromJson(snapshot.data()!);
    }

    return null;
  }
  /*=======================Grand Price Grid [End]===================== */

  /*===================Grand Price Grid Token [Start]================= */

  Stream<List<GrandPriceToken>> readCompetitionGrandPricesTokens(
          String competitionFK, String grandPricesGridId) =>
      FirebaseFirestore.instance
          .collection('competitions')
          .doc(competitionFK)
          .collection('grand_prices_grids')
          .doc(grandPricesGridId)
          .collection('grand_prices_tokens')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => GrandPriceToken.fromJson(doc.data()))
              .toList());

  /*===================Grand Price Grid Token [End]================= */

  /*===================Competitors Grid [Start]================= */

  Future<GroupCompetitorsGrid?> findCompetitorsGrid(
      String competitionFK, String competitorGridId) async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection('competitions')
        .doc(competitionFK)
        .collection('competitors_grids')
        .doc(competitorGridId);

    DocumentSnapshot snapshot = await reference.get();

    if (snapshot.exists) {
      return GroupCompetitorsGrid.fromJson(snapshot.data()!);
    }

    return null;
  }
  /*===================Competitors Grid [End]================= */

  /*===================Competitors Grid Token[Start]================= */

  Stream<List<GroupCompetitorToken>> readCompetitionCompetitorsTokens(
          String competitionFK, String competitorsGridId) =>
      FirebaseFirestore.instance
          .collection('competitions')
          .doc(competitionFK)
          .collection('grand_prices_grids')
          .doc(competitorsGridId)
          .collection('grand_prices_tokens')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => GroupCompetitorToken.fromJson(doc.data()))
              .toList());
  /*===================Competitors Grid Token[End]================= */
}
