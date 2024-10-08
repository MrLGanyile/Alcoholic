import 'package:flutter/material.dart';

import '../main.dart';

import 'date_picker.dart';
import 'groups_screen.dart';
import 'home_widget.dart';
import 'showoff_screen.dart';

import '../models/prototype/samples_for_testing.dart';

import 'prototype/stores_widget.dart' as prot_stores_widget;
import 'production/stores_widget.dart' as prod_stores_widget;

class StartScreen extends StatefulWidget {
  SampleForTesting sampleForTesting;

  StartScreen({
    super.key,
    required this.sampleForTesting,
  });

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  List<String> titles = ['Recent Wins', 'Groups', 'All Stores', 'Going Ons'];

  void updateCurrentIndex(int index) {
    setState(() => currentIndex = index);
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: MyApplication.scaffoldColor,
        appBar: AppBar(
          backgroundColor: MyApplication.scaffoldColor,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            iconSize: 30,
            color: MyApplication.logoColor1,
            onPressed: (() {}),
          ),
          title: Text(
            titles[currentIndex],
            style: TextStyle(
              fontSize: 20,
              color: MyApplication.logoColor2,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          actions: [
            // Not Needed
            IconButton(
              icon: const Icon(Icons.search),
              iconSize: 30,
              color: MyApplication.logoColor1,
              onPressed: (() {}),
            ),
            IconButton(
              icon: const Icon(Icons.notifications_none),
              iconSize: 30,
              color: MyApplication.logoColor1,
              onPressed: (() {}),
            ),
          ],
          /*flexibleSpace: Container(
          decoration: BoxDecoration(
            color: MyApplication.scaffoldColor,
          ),
        ),*/
          bottom: TabBar(
            onTap: updateCurrentIndex,
            labelColor: MyApplication.logoColor1,
            controller: _tabController,
            indicatorColor: MyApplication.logoColor2,
            indicatorWeight: 5,
            //dividerHeight: 0,
            indicatorPadding: const EdgeInsets.only(bottom: 8),
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home,
                  color: MyApplication.logoColor1,
                ),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.group, color: MyApplication.logoColor1),
                text: 'Groups',
              ),
              Tab(
                icon: Icon(Icons.local_drink, color: MyApplication.logoColor1),
                text: 'Stores',
              ),
              Tab(
                icon: Icon(Icons.video_call, color: MyApplication.logoColor1),
                text: 'Showoffs',
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: MyApplication.scaffoldColor,
          ),
          child: TabBarView(controller: _tabController, children: [
            HomeWidget(),
            //DatePicker(),
            GroupsScreen(),
            /*prot_stores_widget.StoresWidget(
              sampleForTesting: widget.sampleForTesting,
            ), */
            prod_stores_widget.StoresWidget(),
            ShowoffScreen(),
          ]),
        ),
      );
}        

/*
class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({ super.key });
  @override
  State<MyTabbedPage> createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage> with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

 @override
 void dispose() {
   _tabController.dispose();
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          final String label = tab.text!.toLowerCase();
          return Center(
            child: Text(
              'This is the $label tab',
              style: const TextStyle(fontSize: 36),
            ),
          );
        }).toList(),
      ),
    );
  }
}*/