import 'dart:developer' as debug;

import 'package:flutter/material.dart';

import '../../main.dart';

import '../../models/production/stores/store_name_info.dart';
import '../../models/prototype/old_store.dart';
import '../../models/prototype/samples_for_testing.dart';
import 'store_name_info_widget.dart';

class StoresWidget extends StatefulWidget {
  SampleForTesting sampleForTesting;

  StoresWidget({
    super.key,
    required this.sampleForTesting,
  });

  @override
  StoresWidgetState createState() => StoresWidgetState();
}

class StoresWidgetState extends State<StoresWidget> {
  List<Store> allAvailableStores = SampleForTesting.allRegisteredStores;

  List<StoreNameInfo> info = [];
  int? indexOfOpenedStore;

  void keepAtMostOneStoreOpened(int indexOfOpenedStore) {
    setState(() {
      this.indexOfOpenedStore = indexOfOpenedStore;
      for (int infoIndex = 0; infoIndex < info.length; infoIndex++) {
        if (info[infoIndex].isOpened && infoIndex != indexOfOpenedStore) {
          info[infoIndex].isOpened = false;
        } else if (infoIndex == indexOfOpenedStore) {
          info[infoIndex].isOpened = true;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    allAvailableStores.sort();
    for (Store store in allAvailableStores) {
      StoreNameInfo storeNameInfo = StoreNameInfo(
          storeNameInfoId: store.storeId!,
          storeName: store.storeName,
          storeImageURL: store.picPath + store.picName,
          sectionName: store.sectionName);
      info.add(storeNameInfo);
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: MyApplication.scaffoldColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: MyApplication.storeDataPadding,
          child: ListView.builder(
              itemCount: info.length,
              itemBuilder: ((context, index) {
                return StoreNameInfoWidget(
                  storeNameInfo: info[index],
                  infoIndex: index,
                  sampleForTesting: widget.sampleForTesting,
                  onOpenChanged: keepAtMostOneStoreOpened,
                );
              })),
        ),
      );
}
