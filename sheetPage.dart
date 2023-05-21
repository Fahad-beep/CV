// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_signin/screens/createNewSheet.dart';
import 'package:firebase_signin/screens/read_SMS.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_advanced/sms_advanced.dart';

SmsQuery query = new SmsQuery();
int? ass;
var concatenate = StringBuffer();
var currentUserID = FirebaseAuth.instance.currentUser?.uid ?? "";
final TextEditingController _intController = TextEditingController();
final TextEditingController _stringController = TextEditingController();
int? bss;
String? sdd;
String? ssd;
String? swd;
String? add;
String? checkName;
var alpha = [];
var beta = [];
var bankCurrency;
var bankName;
List messages = [];
List<dynamic>? fList;
List<dynamic>? friendsList;
double creditCheck = 0;
double debitCheck = 0;
double totalCheck = 0;

String val = "null";
// ignore: prefer_typing_uninitialized_variables
var lenghtOfList = 0;

// ignore: camel_case_types, use_key_in_widget_constructors
class newSheet extends StatefulWidget {
  @override
  State<newSheet> createState() => _newSheetState();
  // : implement createState
}

CollectionReference _users = FirebaseFirestore.instance.collection('users');

var doc = _users.doc().get().then((doc) {});
CollectionReference users = FirebaseFirestore.instance.collection('users');

// ignore: camel_case_types
class _newSheetState extends State<newSheet> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var currentUserID = FirebaseAuth.instance.currentUser?.uid ?? "";
  SmsQuery query = new SmsQuery();
  int? ass;
  var concatenate = StringBuffer();

  int? bss;
  String? sdd;
  String? add;
  String? checkName;
  var alpha = [];
  var beta = [];
  var bankCurrency;
  var bankName;
  List messages = [];
  List<dynamic>? friendsList;
  List<dynamic>? fList;
  List bankNameList = [
    'None',
    'Bank-1',
    'Bank-2',
    'Bank-3',
    'Bank-4',
    'Bank-5',
    'Bank-6'
  ];
  void changeeB(String value) {
    bankValue = value;
  }

  void changeeC(String value) {
    currencyValue = value;
  }

  List currencyList = ['None', 'SAD', 'PKR', 'USD', 'Euroo', 'IR', 'YEN'];
  var bank = "Select A Bank";

  var currency = "Select Currency";
  String bankValue = 'None';
  String currencyValue = 'None';
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() {
    getFriendsList();
  }

  String? cr;
  void getFriendsList() {
    requestSMSPermission();
    processSMS();
    creditCheck = 0;
    debitCheck = 0;
    totalCheck = 0;
    if (bankValue == "Bank-1" ||
        bankValue == "Bank-2" ||
        bankValue == "Bank-3" ||
        bankValue == "Bank-4" ||
        bankValue == "Bank-5" ||
        bankValue == "Bank-6") {
      FirebaseFirestore.instance
          .collection("User")
          .doc(currentUserID)
          .get()
          .then((doc) {
        var id = doc.data().toString().contains(bankValue + "_" + currencyValue)
            ? doc[bankValue + "_" + currencyValue].length
            : 0;
        lenghtOfList = id;
        if (id > 0) {
          friendsList = doc.data()![bankValue + "_" + currencyValue];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double heights = MediaQuery.of(context).size.height;
    int i = 0;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(103, 181, 245, 1),
          Color.fromARGB(255, 0, 111, 201),
          Color.fromARGB(255, 0, 77, 140),
          // Color.fromRGBO(81, 177, 255, 1),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ButtonTheme(
                // alignedDropdown: true,
                child: Theme(
                  data: Theme.of(context).copyWith(
                      // canvasColor: Colors.blue,
                      ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.2,
                              right: MediaQuery.of(context).size.width * 0.2,
                              top: 10,
                              bottom: 10),
                          child: DropdownButtonFormField(
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Select Bank',
                              labelStyle: const TextStyle(color: Colors.white),
                              prefixIcon: const Icon(
                                Icons.credit_card_outlined,
                                color: Colors.white,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            value: bankValue,
                            items: bankNameList
                                .map(
                                  (e) => DropdownMenuItem(
                                    // ignore: sort_child_properties_last
                                    child: Text(e),
                                    value: e,
                                  ),
                                )
                                .toList(),
                            onChanged: (newValue) {
                              bankValue = newValue as String;
                              getFriendsList();
                              // changeeB(newValue as String);
                              // changeeC(newValue as String);
                              setState(() {
                                changeeB(newValue as String);
                                // changeeC(newValue as String);
                                // bankValue = newValue as String;
                                getFriendsList();
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.2,
                          right: MediaQuery.of(context).size.width * 0.2,
                          top: 10,
                          bottom: 10),
                      child: DropdownButtonFormField(
                        icon: const Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Select Currency',
                          labelStyle: const TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          prefixIcon: const Icon(
                            Icons.credit_card_outlined,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        value: currencyValue,
                        items: currencyList
                            .map(
                              (e) => DropdownMenuItem(
                                // ignore: sort_child_properties_last
                                child: Text(e),
                                value: e,
                              ),
                            )
                            .toList(),
                        onTap: getFriendsList,
                        onChanged: (newValue) {
                          currencyValue = newValue as String;
                          getFriendsList;
                          // changeeB(newValue);
                          // changeeC(newValue);
                          setState(() {
                            // changeeB(newValue as String);
                            changeeC(newValue as String);
                            // currencyValue = newValue as String;
                            getFriendsList;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: <Widget>[
                  if (currencyValue != null &&
                      bankValue != null &&
                      lenghtOfList >= 1) ...[
                    SingleChildScrollView(
                      child: Expanded(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // SizedBox(
                              //   width: 200,
                              // ),
                              SizedBox(
                                // width: 150,
                                width: MediaQuery.of(context).size.width * 0.12,
                                height: 50,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      left: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      right: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      bottom: BorderSide(
                                        color: Colors.transparent,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  child: const Center(
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        'Credit',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                // width: 150,
                                width: MediaQuery.of(context).size.width * 0.12,
                                height: 50,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      left: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      right: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      bottom: BorderSide(
                                        color: Colors.transparent,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  child: const Center(
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        'Deposit',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                // width: 280,
                                width: MediaQuery.of(context).size.width * 0.21,
                                height: 50,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      left: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      right: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      bottom: BorderSide(
                                        color: Colors.transparent,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  child: const Center(
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        'TimeStamp',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SizedBox(
                                  // width: 250,
                                  width:
                                      MediaQuery.of(context).size.width * 0.21,

                                  height: 50,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                        left: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                        right: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.transparent,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    child: const Center(
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          'Notes',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    for (int i = 0; i < lenghtOfList; i++) ...[
                      //  SizedBox(
                      //   height: 30,
                      // ),
                      if (i.isEven) ...[
                        SingleChildScrollView(
                          child: Expanded(
                            child: Container(
                              color: Color.fromARGB(48, 255, 255, 255),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.12,
                                    height: 50,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          left: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          right: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: ListView.builder(
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              creditCheck +=
                                                  friendsList![i]["credit"];
                                              debitCheck +=
                                                  friendsList![i]["debit"];
                                              totalCheck +=
                                                  debitCheck - creditCheck;

                                              return Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 14.0),
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                        // friendsList![i]["credit"]
                                                        friendsList![i]
                                                                ["credit"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.12,
                                    height: 50,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          left: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          right: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: ListView.builder(
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 14.0),
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                        friendsList![i]["debit"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    height: 50,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: const Border(
                                          top: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          left: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          right: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: ListView.builder(
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 14.0),
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                        friendsList![i]["time"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    height: 50,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          left: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          right: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: ListView.builder(
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 14.0),
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                        friendsList![i]["note"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ] else if (i.isOdd) ...[
                        SingleChildScrollView(
                          child: Expanded(
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.12,
                                    height: 50,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          left: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          right: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: ListView.builder(
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              creditCheck +=
                                                  friendsList![i]["credit"];
                                              debitCheck +=
                                                  friendsList![i]["debit"];

                                              return Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 14.0),
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                        // friendsList![i]["credit"]
                                                        friendsList![i]
                                                                ["credit"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.12,
                                    height: 50,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          left: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          right: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: ListView.builder(
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 14.0),
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                        friendsList![i]["debit"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    height: 50,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: const Border(
                                          top: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          left: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          right: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: ListView.builder(
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 14.0),
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                        friendsList![i]["time"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    height: 50,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          left: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          right: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: ListView.builder(
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Center(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 14.0),
                                                    child: FittedBox(
                                                      fit: BoxFit.fitWidth,
                                                      child: Text(
                                                          friendsList![i]
                                                                  ["note"]
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                    )),
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],

                      if (i == lenghtOfList - 1 && i.isOdd) ...[
                        SingleChildScrollView(
                          child: Expanded(
                            child: Container(
                              color: Color.fromARGB(48, 255, 255, 255),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.1),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.12,
                                      height: 50,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            left: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            right: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.transparent,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        child: ListView.builder(
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return const Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 14.0),
                                                    child: FittedBox(
                                                      fit: BoxFit.fitWidth,
                                                      child: Text(
                                                          "Total Amount Left: ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18)),
                                                    )),
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    height: 50,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    height: 50,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          left: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          right: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      child: ListView.builder(
                                          itemCount: 1,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            totalCheck =
                                                debitCheck - creditCheck;
                                            creditCheck = 0;
                                            debitCheck = 0;
                                            return Center(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 14.0),
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text("$totalCheck",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  )),
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ] else if (i == lenghtOfList - 1 && i.isEven) ...[
                        SingleChildScrollView(
                          child: Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.1),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.12,
                                      height: 50,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            left: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            right: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.transparent,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                          child: ListView.builder(
                                              itemCount: 1,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return const Center(
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 14.0),
                                                      child: FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Text(
                                                            "Total Amount Left: ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18)),
                                                      )),
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    height: 50,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    height: 50,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          left: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          right: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: ListView.builder(
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              totalCheck =
                                                  debitCheck - creditCheck;
                                              creditCheck = 0;
                                              debitCheck = 0;
                                              return Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 14.0),
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text("$totalCheck",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]
                    ],
                    Divider(
                      color: Colors.white,
                      thickness: 0.6,
                    ),
                  ] else ...[
                    const SizedBox(width: 230, height: 100),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        'Data Not Found',
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                    )),
                  ],
                ],
              ),
              SizedBox(
                height: heights * 0.3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => createNewSheet()));
                    },
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: const Text(
                        'Create New Sheet',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyInbox()));
                    },
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: const Text(
                        'Add A New Reference',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void requestSMSPermission() async {
  PermissionStatus status = await Permission.sms.request();
  if (status.isGranted) {
    // Permission granted, you can now read SMS
    processSMS();
  } else {
    // Permission denied
    if (status.isPermanentlyDenied) {
      // Permission permanently denied, navigate to app settings
      openAppSettings();
    } else {
      // Permission denied, show an error message
      // You can handle the denial case as per your app's requirements
    }
  }
}

void processSMS() async {
  SmsQuery query = SmsQuery();
  List<SmsMessage> messages = await query.querySms();

  // Filter messages
  List<String> sender = [];
  List<String> reference_string_AT = [];
  List<int> reference_array_AT = [];
  List<String> bank_Currency = [];
  List<double> amount_Value_array = [];
  List<String> reference_string_TO = [];
  List<int> reference_array_TO = [];
  List<String> credit = [];
  List<String> debit = [];
  int j = 0;
  int k = 0;
  int kk = 0;
  int l = 0;
  int lkk = 0;

  // Specify the sender name to filter

  // Iterate through each SMS message
  for (SmsMessage message in messages) {
    List<dynamic> ffListss = [];

    int i = 0;

    String? senderName = message.address;

    if (!sender.contains(senderName)) {
      sender.add(senderName!);
    }
    FirebaseFirestore.instance
        .collection("User")
        .doc('Igehh8UN7sbCf2J7fP0g')
        .get()
        .then((doc) {
      var id = doc.data().toString().contains('bankNames') ? 1 : 0;
      if (id > 0) {
        ffListss = doc.data()!['bankNames'];
      }
      while (i < ffListss.length) {
        if (ffListss[i][senderName].toString() != null) {
          // bankName = ffListss![i][senderName].toString();
          // checkName = bankName;
          List<String>? lines = message.body?.split('\n');

          // Iterate through each line in the SMS message body
          for (String line in lines!) {
            if (line.contains('At:')) {
              String value = line.split('At:').last.trim();
              if (value.contains(' ')) {
                continue;
              } else if (int.tryParse(value) != null) {
                reference_array_AT.add(int.parse(value));
                if (reference_string_TO.isNotEmpty) {
                  kk++;
                }
                l++;
              } else {
                if (reference_string_TO.isNotEmpty) {
                  kk++;
                }
                reference_string_AT.add(value);
                lkk++;
              }
            } else if (line.contains('Amount:')) {
              String value = line.split('Amount:').last.trim();
              if (value.startsWith(' ') || value.length < 3) {
                continue;
              } else {
                String currency = line.substring(
                    line.indexOf('Amount:') + 7, line.indexOf('Amount:') + 10);
                bank_Currency.add(currency);
                String amount = value.split(' ')[0];
                amount_Value_array.add(double.parse(amount));
              }
            } else if (line.contains('To:')) {
              String value = line.split('To:').last.trim();
              if (value.contains(' ')) {
                continue;
              } else if (int.tryParse(value) != null) {
                reference_array_TO.add(int.parse(value));
              } else {
                if (reference_string_AT[lkk].isNotEmpty) {
                  lkk++;
                }
                if (reference_array_AT[l].toString().isNotEmpty) {
                  l++;
                }
                kk++;
                reference_string_TO.add(value);
              }
            }
          }

          if (reference_string_TO[kk].isNotEmpty &&
              (reference_string_AT[lkk].isEmpty &&
                  reference_array_AT[l].toString().isEmpty)) {
            debit.add('To');
            FirebaseFirestore.instance
                .collection('User')
                .doc(currentUserID)
                .update({
              bankName + bank_Currency[j]: FieldValue.arrayUnion([
                {
                  'debit': amount_Value_array[j],
                  'time': message.date,
                  'note': reference_string_TO[kk],
                }
              ])
            });
          } else if (reference_string_AT[lkk].isNotEmpty) {
            credit.add('At');
            FirebaseFirestore.instance
                .collection('User')
                .doc(currentUserID)
                .update({
              bankName + bank_Currency[j]: FieldValue.arrayUnion([
                {
                  'credit': amount_Value_array[j],
                  'time': message.date,
                  'note': reference_string_AT[lkk].toString(),
                }
              ])
            });
          } else if (reference_array_AT[l].toString().isNotEmpty) {
            credit.add('At');
            FirebaseFirestore.instance
                .collection("User")
                .doc('Igehh8UN7sbCf2J7fP0g')
                .get()
                .then((doc) {
              var id = doc.data().toString().contains('reference') ? 1 : 0;
              if (id > 0) {
                fList = doc.data()!['reference'];
              }
              if (fList![j][reference_array_AT[l]].toString() != null) {
                FirebaseFirestore.instance
                    .collection('User')
                    .doc(currentUserID)
                    .update({
                  bankName + bank_Currency[j]: FieldValue.arrayUnion([
                    {
                      'credit': amount_Value_array[j],
                      'time': message.date,
                      'note': fList![j][reference_array_AT[l]].toString(),
                    }
                  ])
                });
              } else if (fList![j][reference_array_AT[l]].toString() != null) {
                FirebaseFirestore.instance
                    .collection('User')
                    .doc(currentUserID)
                    .update({
                  bankName + bank_Currency[j]: FieldValue.arrayUnion([
                    {
                      'credit': amount_Value_array[j],
                      'time': message.date,
                    }
                  ])
                });
              }
            });
          }
          i = ffListss.length;
          j++;
        } else {
          i++;
        }
      }
    });
  }
}

//     // if (checkName != senderName) {
//     //   continue ;
//     // }

//     List<String>? lines = message.body?.split('\n');

//     // Iterate through each line in the SMS message body
//     for (String line in lines!) {
//       if (line.contains('At:')) {
//         String value = line.split('At:').last.trim();
//         if (value.contains(' ')) {
//           continue;
//         } else if (int.tryParse(value) != null) {
//           reference_array_AT.add(int.parse(value));
//         } else {
//           reference_string_AT.add(value);
//         }
//       } else if (line.contains('Amount:')) {
//         String value = line.split('Amount:').last.trim();
//         if (value.startsWith(' ') || value.length < 3) {
//           continue;
//         } else {
//           String currency = line.substring(
//               line.indexOf('Amount:') + 7, line.indexOf('Amount:') + 10);
//           bank_Currency.add(currency);
//           String amount = value.split(' ')[0];
//           amount_Value_array.add(double.parse(amount));
//         }
//       } else if (line.contains('To:')) {
//         String value = line.split('To:').last.trim();
//         if (value.contains(' ')) {
//           continue;
//         } else if (int.tryParse(value) != null) {
//           reference_array_TO.add(int.parse(value));
//         } else {
//           reference_string_TO.add(value);
//         }
//       }
//     }

//     if (reference_string_TO.isNotEmpty &&
//         (reference_string_AT[i].isEmpty && reference_array_AT.isEmpty)) {
//       debit.add('To');
//       FirebaseFirestore.instance.collection('User').doc(currentUserID).update({
//         bankName + bank_Currency[i]: FieldValue.arrayUnion([
//           {
//             'debit': amount_Value_array[i],
//             'time': message.date,
//             'note': reference_string_TO,
//           }
//         ])
//       });
//     } else if (reference_string_AT[i].isNotEmpty) {
//       credit.add('At');
//       FirebaseFirestore.instance.collection('User').doc(currentUserID).update({
//         bankName + bank_Currency[i]: FieldValue.arrayUnion([
//           {
//             'credit': amount_Value_array[i],
//             'time': message.date,
//             'note': reference_string_AT[i].toString(),
//           }
//         ])
//       });
//     } else if (reference_array_AT[i].toString().isNotEmpty) {
//       credit.add('At');
//       FirebaseFirestore.instance
//           .collection("User")
//           .doc('Igehh8UN7sbCf2J7fP0g')
//           .get()
//           .then((doc) {
//         var id = doc.data().toString().contains('reference') ? 1 : 0;
//         if (id > 0) {
//           fList = doc.data()!['reference'];
//         }
//         if (fList![i][reference_array_AT[i]].toString() != null) {
//           FirebaseFirestore.instance
//               .collection('User')
//               .doc(currentUserID)
//               .update({
//             bankName + bank_Currency[i]: FieldValue.arrayUnion([
//               {
//                 'credit': amount_Value_array[i],
//                 'time': message.date,
//                 'note': fList![i][reference_array_AT[i]].toString(),
//               }
//             ])
//           });
//         } else if (fList![i][reference_array_AT[i]].toString() != null) {
//           FirebaseFirestore.instance
//               .collection('User')
//               .doc(currentUserID)
//               .update({
//             bankName + bank_Currency[i]: FieldValue.arrayUnion([
//               {
//                 'credit': amount_Value_array[i],
//                 'time': message.date,
//               }
//             ])
//           });
//         }
//       });
//     }
//   }

//   // Print the filtered results
//   print('Sender: $sender');
//   print('reference_string_AT: $reference_string_AT');
//   print('reference_array_AT: $reference_array_AT');
//   print('bank_Currency: $bank_Currency');
//   print('amount_Value_array: $amount_Value_array');
//   print('reference_string_TO: $reference_string_TO');
//   print('reference_array_TO: $reference_array_TO');
//   print('credit: $credit');
//   print('debit: $debit');
// }

// ----------------------------------

// void processSMS() async {
//   // Read SMS messages  PermissionStatus status = await Permission.sms.request();
//   PermissionStatus status = await Permission.sms.request();
//   if (status.isGranted) {
//     // Permission granted, you can now read SMS
//     processSMS();
//   } else {
//     // Permission denied
//     if (status.isPermanentlyDenied) {
//       // Permission permanently denied, navigate to app settings
//       openAppSettings();
//     } else {
//       // Permission denied, show an error message
//       // You can handle the denial case as per your app's requirements
//     }
//   }
//   SmsQuery query = SmsQuery();
//   List<SmsMessage> messages = await query.getAllSms;

//   // Filter messages
//   List<String> sender = [];
//   List<String> reference_string_AT = [];
//   List<int> reference_array_AT = [];
//   List<String> bank_Currency = [];
//   List<double> amount_Value_array = [];
//   List<String> reference_string_TO = [];
//   List<int> reference_array_TO = [];
//   List<String> credit = [];
//   List<String> debit = [];
//   int i = 0;
//   // Iterate through each SMS message
//   for (SmsMessage message in messages) {
//     String senderName = message.sender;
//     if (!sender.contains(senderName)) {
//       sender.add(senderName);
//     }
//     FirebaseFirestore.instance
//         .collection("User")
//         .doc('Igehh8UN7sbCf2J7fP0g')
//         .get()
//         .then((doc) {
//       var id = doc.data().toString().contains('bankNames') ? 1 : 0;
//       if (id > 0) {
//         ffListss = doc.data()!['bankNames'];
//       }
//       if (ffListss![i][senderName].toString() != null) {
//         bankName = ffListss![i][senderName].toString();
//         checkName = bankName;
//       }
//     });
//     if (checkName != senderName) {
//       continue;
//     }

//     List<String> lines = message.body.split('\n');

//     // Iterate through each line in the SMS message body
//     for (String line in lines) {
//       if (line.contains('At:')) {
//         String value = line.split('At:').last.trim();
//         if (value.contains(' ')) {
//           continue;
//         } else if (int.tryParse(value) != null) {
//           reference_array_AT.add(int.parse(value));
//         } else {
//           reference_string_AT.add(value);
//         }
//       } else if (line.contains('Amount:')) {
//         String value = line.split('Amount:').last.trim();
//         if (value.startsWith(' ') || value.length < 3) {
//           continue;
//         } else {
//           String currency = line.substring(
//               line.indexOf('Amount:') + 7, line.indexOf('Amount:') + 10);
//           bank_Currency.add(currency);
//           String amount = value.split(' ')[0];
//           amount_Value_array.add(double.parse(amount));
//         }
//       } else if (line.contains('To:')) {
//         String value = line.split('To:').last.trim();
//         if (value.contains(' ')) {
//           continue;
//         } else if (int.tryParse(value) != null) {
//           reference_array_TO.add(int.parse(value));
//         } else {
//           reference_string_TO.add(value);
//         }
//       }
//     }

//     if (reference_string_TO.isNotEmpty &&
//         (reference_string_AT[i].isEmpty && reference_array_AT.isEmpty)) {
//       debit.add('To');
//       FirebaseFirestore.instance.collection('User').doc(currentUserID).update({
//         bankName + bank_Currency[i]: FieldValue.arrayUnion([
//           {
//             'debit': amount_Value_array[i],
//             'time': message.date,
//             'note': reference_string_TO,
//           }
//         ])
//       });
//     } else if (reference_string_AT[i].isNotEmpty) {
//       credit.add('At');
//       FirebaseFirestore.instance.collection('User').doc(currentUserID).update({
//         bankName + bank_Currency[i]: FieldValue.arrayUnion([
//           {
//             'credit': amount_Value_array[i],
//             'time': message.date,
//             'note': reference_string_AT[i].toString(),
//           }
//         ])
//       });
//     } else if (reference_array_AT[i].toString().isNotEmpty) {
//       credit.add('At');
//       FirebaseFirestore.instance
//           .collection("User")
//           .doc('Igehh8UN7sbCf2J7fP0g')
//           .get()
//           .then((doc) {
//         var id = doc.data().toString().contains('reference') ? 1 : 0;
//         if (id > 0) {
//           fList = doc.data()!['reference'];
//         }
//         if (fList![i][reference_array_AT[i]].toString() != null) {
//           FirebaseFirestore.instance
//               .collection('User')
//               .doc(currentUserID)
//               .update({
//             bankName + bank_Currency[i]: FieldValue.arrayUnion([
//               {
//                 'credit': amount_Value_array[i],
//                 'time': message.date,
//                 'note': fList![i][reference_array_AT[i]].toString(),
//               }
//             ])
//           });
//         } else if (fList![i][reference_array_AT[i]].toString() != null) {
//           FirebaseFirestore.instance
//               .collection('User')
//               .doc(currentUserID)
//               .update({
//             bankName + bank_Currency[i]: FieldValue.arrayUnion([
//               {
//                 'credit': amount_Value_array[i],
//                 'time': message.date,
//               }
//             ])
//           });
//         }
//       });
//     }
//     print('Sender: $sender');
//     print('Reference String AT: $reference_string_AT');
//     print('Reference Array AT: $reference_array_AT');
//     print('Bank Currency: $bank_Currency');
//     print('Amount Value Array: $amount_Value_array');
//     print('Reference String TO: $reference_string_TO');
//     print('Reference Array TO: $reference_array_TO');
//     print('Credit: $credit');
//     print('Debit: $debit');
//   }
// }
