import 'dart:developer' as debug;

import 'package:alcoholic/controllers/production/store_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

import '../../models/production/stores/store_name_info.dart';

import 'store_name_info_widget.dart';

class StoresWidget extends StatefulWidget {
  StoreController storeController = StoreController.storeController;

  StoresWidget({
    super.key,
  });

  @override
  StoresWidgetState createState() => StoresWidgetState();
}

// Firstly start by reading the documents of StoreNameInfo Collection.
class StoresWidgetState extends State<StoresWidget> {
  late Stream<List<StoreNameInfo>> storeNamesInfoStream;
  late List<StoreNameInfo> storeNamesInfo;

  int? indexOfOpenedStore;

  void keepAtMostOneStoreOpened(int indexOfOpenedStore) {
    setState(() {
      this.indexOfOpenedStore = indexOfOpenedStore;
      for (int infoIndex = 0; infoIndex < storeNamesInfo.length; infoIndex++) {
        if (storeNamesInfo[infoIndex].isOpened &&
            infoIndex != indexOfOpenedStore) {
          storeNamesInfo[infoIndex].isOpened = false;
        } else if (infoIndex == indexOfOpenedStore) {
          storeNamesInfo[infoIndex].isOpened = true;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    storeNamesInfoStream =
        StoreController.storeController.readAllStoreNameInfo();
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: MyApplication.scaffoldBodyColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: MyApplication.storeDataPadding,
          child: StreamBuilder<List<StoreNameInfo>>(
            stream: storeNamesInfoStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                storeNamesInfo = snapshot.data!;
                storeNamesInfo.sort();

                return ListView.builder(
                    itemCount: storeNamesInfo.length,
                    itemBuilder: ((context, index) {
                      return StoreNameInfoWidget(
                        storeNameInfo: storeNamesInfo[index],
                        infoIndex: index,
                        onOpenChanged: keepAtMostOneStoreOpened,
                      );
                    }));
              } else if (snapshot.hasError) {
                Get.snackbar("Error Fetching Data", "${snapshot.error}");
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      );
}
