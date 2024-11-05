import '../controllers/location_controller.dart';
import '../controllers/store_controller.dart';
import 'package:alcoholic/main.dart';
import 'package:alcoholic/screens/alcoholic_registration_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../models/locations/supported_area.dart';
import 'utils/globals.dart';
import 'dart:developer' as debug;

class StoreRegistrationWidget extends StatefulWidget {
  @override
  State createState() => _StoreRegistrationWidgetState();
}

class _StoreRegistrationWidgetState extends State<StoreRegistrationWidget> {
  StoreController storeController = StoreController.storeController;
  LocationController locationController = LocationController.locationController;
  final _formKey = GlobalKey<FormState>();

  late DropdownButton2<String> dropDowButton;

  late Stream<List<SupportedArea>> supportedAreasStream;
  late List<String> items;

  String? selectedValue;
  Color textColor = Colors.green;

  TextEditingController fullnameEditingController = TextEditingController();
  TextEditingController surnameEditingController = TextEditingController();
  TextEditingController phoneNumberEditingController = TextEditingController();
  TextEditingController storeNameEditingController = TextEditingController();
  TextEditingController storeSectionNameEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    supportedAreasStream = locationController.readAllSupportedAreas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          size: 20,
          color: MyApplication.attractiveColor1,
        ),
        title: const Text(
          'Store Registration',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: MyApplication.attractiveColor1,
        elevation: 0,
      ),
      backgroundColor: MyApplication.scaffoldColor,
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 0, right: 50, left: 50),
          child: Column(children: [
            CircleAvatar(
              backgroundImage: const AssetImage('assets/logo.png'),
              radius: MediaQuery.of(context).size.width * 0.15,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Capture Store Owner Face',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: MyApplication.logoColor1,
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    color: Colors.white,
                    iconSize: MediaQuery.of(context).size.width * 0.15,
                    icon:
                        Icon(Icons.camera_alt, color: MyApplication.logoColor2),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // Store Owner Full Name
            TextField(
              style: TextStyle(color: MyApplication.logoColor1),
              cursorColor: MyApplication.logoColor1,
              controller: fullnameEditingController,
              decoration: InputDecoration(
                labelText: 'Store Owner Full Name',
                prefixIcon:
                    Icon(Icons.account_circle, color: MyApplication.logoColor1),
                labelStyle: TextStyle(
                  fontSize: 14,
                  color: MyApplication.logoColor2,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: MyApplication.logoColor2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: MyApplication.logoColor2,
                  ),
                ),
              ),
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            // Store Owner Surname
            TextField(
              style: TextStyle(color: MyApplication.logoColor1),
              cursorColor: MyApplication.logoColor1,
              controller: surnameEditingController,
              decoration: InputDecoration(
                labelText: 'Store Owner Surname',
                prefixIcon:
                    Icon(Icons.account_circle, color: MyApplication.logoColor1),
                labelStyle: TextStyle(
                  fontSize: 14,
                  color: MyApplication.logoColor2,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: MyApplication.logoColor2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: MyApplication.logoColor2,
                  ),
                ),
              ),
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            // Store Owner Phone Number
            EasyContainer(
              elevation: 0,
              height: 70,
              borderRadius: 6,
              color: MyApplication.scaffoldColor,
              showBorder: true,
              borderColor: MyApplication.logoColor2,
              child: IntlPhoneField(
                controller: phoneNumberEditingController,
                cursorColor: MyApplication.logoColor1,
                autofocus: false,
                invalidNumberMessage: 'Invalid Phone Number!',
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(fontSize: 16, color: MyApplication.logoColor1),
                dropdownTextStyle:
                    TextStyle(fontSize: 16, color: MyApplication.logoColor1),
                //onChanged: (phone) =>phoneNumberEditingController.text = phone.completeNumber,

                initialCountryCode: 'ZA',
                flagsButtonPadding: const EdgeInsets.only(right: 10),
                showDropdownIcon: true,
                keyboardType: TextInputType.phone,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Store Owner ID Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  color: Colors.white,
                  iconSize: MediaQuery.of(context).size.width * 0.15,
                  icon: Icon(Icons.camera_alt, color: MyApplication.logoColor2),
                  onPressed: () {
                    storeController.captureStoreImageWithCamera();
                  },
                ),
                IconButton(
                  color: Colors.white,
                  iconSize: MediaQuery.of(context).size.width * 0.15,
                  icon:
                      Icon(Icons.upload_file, color: MyApplication.logoColor2),
                  onPressed: () {
                    storeController.chooseStoreImageFromGallery();
                  },
                ),
              ],
            ),
            // Information Label About ID
            Text(
              'Capture Or Pick Your Identity Document',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: MyApplication.logoColor1,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Store Name
            TextField(
              style: TextStyle(color: MyApplication.logoColor1),
              cursorColor: MyApplication.logoColor1,
              controller: storeNameEditingController,
              decoration: InputDecoration(
                labelText: 'Store Name',
                prefixIcon: Icon(Icons.store, color: MyApplication.logoColor1),
                labelStyle: TextStyle(
                  fontSize: 14,
                  color: MyApplication.logoColor2,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: MyApplication.logoColor2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: MyApplication.logoColor2,
                  ),
                ),
              ),
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),

            // Store Area Name
            StreamBuilder<List<SupportedArea>>(
              stream: supportedAreasStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<String> dbItems = [];
                  for (int areaIndex = 0;
                      areaIndex < snapshot.data!.length;
                      areaIndex++) {
                    dbItems.add(snapshot.data![areaIndex].toString());
                  }
                  items = dbItems;
                  return pickAreaName();
                } else if (snapshot.hasError) {
                  debug.log(
                      "Error Fetching Supported Areas Data - ${snapshot.error}");
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  color: Colors.white,
                  iconSize: MediaQuery.of(context).size.width * 0.15,
                  icon: Icon(Icons.camera_alt, color: MyApplication.logoColor2),
                  onPressed: () {
                    storeController.captureStoreImageWithCamera();
                  },
                ),
                IconButton(
                  color: Colors.white,
                  iconSize: MediaQuery.of(context).size.width * 0.15,
                  icon:
                      Icon(Icons.upload_file, color: MyApplication.logoColor2),
                  onPressed: () {
                    storeController.chooseStoreImageFromGallery();
                  },
                ),
              ],
            ),
            // Information Label About ID
            Text(
              'Capture Or Pick Store Image',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: MyApplication.logoColor1,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            showProgressBar
                ? const SizedBox(
                    child: SimpleCircularProgressBar(
                      animationDuration: 3,
                      backColor: Colors.white,
                      progressColors: [Colors.lightBlue],
                    ),
                  )
                : Column(
                    children: [
                      // Create Store Button
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: MyApplication.logoColor1,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            )),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              showProgressBar = true;
                            });

                            // Create Store Now
                            if (fullnameEditingController.text.isNotEmpty &&
                                surnameEditingController.text.isNotEmpty &&
                                storeNameEditingController.text.isNotEmpty &&
                                dropDowButton.value != null) {
                              /*storeController.saveStore(
                            toreNameEditingController.text,
                            Converter.toSectionName(dropDowButton.value!),
                            storeImage,
                            fullnameEditingController.text,
                            surnameEditingController.text,
                            phoneNumber,
                            ownerProfileImage,
                            identityDocumentImage
                          );*/
                            }
                          },
                          child: const Center(
                            child: Text(
                              'Create Store',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontSize: 14,
                              color: MyApplication.logoColor1,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // Send User To Registration Screen.
                              Get.to(const AlcoholicRegistrationWidget());
                            },
                            child: Text(
                              " Login",
                              style: TextStyle(
                                fontSize: 14,
                                color: MyApplication.logoColor2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
          ]),
        ),
      )),
    );
  }

  Widget pickAreaName() {
    dropDowButton = DropdownButton2<String>(
      isExpanded: true,
      hint: Row(
        children: [
          Icon(
            Icons.location_city,
            size: 22,
            color: MyApplication.logoColor1,
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              'Pick Store\'s Area',
              style: TextStyle(
                fontSize: 14,
                //fontWeight: FontWeight.bold,
                color: MyApplication.logoColor2,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      items: items
          .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: MyApplication.logoColor1,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
      value: selectedValue,
      onChanged: (String? value) {
        setState(() {
          selectedValue = value;
        });
      },
      buttonStyleData: ButtonStyleData(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.90,
        padding: const EdgeInsets.only(left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: MyApplication.logoColor2,
          ),
          color: MyApplication.scaffoldColor,
        ),
        elevation: 0,
      ),
      iconStyleData: IconStyleData(
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: MyApplication.logoColor2,
        iconDisabledColor: Colors.grey,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.black,
        ),
        offset: const Offset(10, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all<double>(6),
          thumbVisibility: MaterialStateProperty.all<bool>(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.only(left: 14, right: 14),
      ),
    );

    return DropdownButtonHideUnderline(child: dropDowButton);
  }
}
