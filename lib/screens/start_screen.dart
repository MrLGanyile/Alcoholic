import 'package:flutter/material.dart';

import '../main.dart';

import 'date_picker.dart';
import 'alcohol_screen.dart';
import 'home_widget.dart';
import 'showoff_screen.dart';

import '../models/prototype/samples_for_testing.dart';

import 'prototype/stores_widget.dart';

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
  List<String> titles = [
    'Recent Wins',
    'Alcohol Search',
    'All Stores',
    'Videos'
  ];

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
            color: Colors.white,
            onPressed: (() {}),
          ),
          title: Text(
            titles[currentIndex],
            style: TextStyle(
              fontSize: 20,
              color: MyApplication.headingColor,
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
              color: Colors.white,
              onPressed: (() {}),
            ),
            IconButton(
              icon: const Icon(Icons.notifications_none),
              iconSize: 30,
              color: Colors.white,
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
            labelColor: Colors.white,
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            //dividerHeight: 0,
            indicatorPadding: const EdgeInsets.only(bottom: 8),
            tabs: const [
              Tab(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.message, color: Colors.white),
                text: 'Alcohol',
              ),
              Tab(
                icon: Icon(Icons.local_drink, color: Colors.white),
                text: 'Stores',
              ),
              Tab(
                icon: Icon(Icons.video_call, color: Colors.white),
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
            AlcoholScreen(),
            StoresWidget(
              sampleForTesting: widget.sampleForTesting,
            ),
            //production.StoresWidget(),
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