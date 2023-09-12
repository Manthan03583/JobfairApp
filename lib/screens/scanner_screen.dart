import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:volunteer_app/commons/colorselect.dart';
import 'package:volunteer_app/screens/home.dart';
import '../commons/urls.dart';
import '../model/checklist.dart';
import '../provider/user.dart';

class ScannerScreen extends StatefulWidget {
  final String scandata;
  const ScannerScreen({super.key, required this.scandata});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String? name;
  String? mobile;
  String? bloodGroup;
  String? gender;
  //List addOn_Events = [];
  var checkArray = [];
  String? eventid;
  String? vid;
  String? datetime;
  String? sts;

  List<AddonEvent> addOnEventData = [];

  @override
  void initState() {
    checkInDetails();
    datetime = DateTime.now().toString();
    //log("Date.." + datetime.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<User>(builder: (context, user, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SafeArea(
                child: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverAppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              expandedHeight: 180,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                      child: Text(
                    "Details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    //height: 250,
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: ColorSelect.grey300,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      child: Image.asset(
                                        "assets/images/eventlogo.png",
                                        fit: BoxFit.fill,
                                        height: 70,
                                        width: 70,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name != null
                                          ? "Name : $name"
                                          : "Name : " " ",
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Mobile : $mobile",
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Blood Group : $bloodGroup",
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Gender : $gender",
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              )),
            ),
            SliverToBoxAdapter(
              child: Container(
                //color: Colors.amber,
                height: height,
                margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Events Participated ",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: addOnEventData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.fromLTRB(2, 0, 10, 8),
                                decoration: BoxDecoration(
                                    //color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black, width: 0.5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          addOnEventData[index]
                                              .activityName
                                              .toString(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: Colors.green,
                                        // value: checkArray.contains(
                                        //     addOnEventData[index].addonEventStatus),
                                        value: addOnEventData[index]
                                                    .addonEventStatus ==
                                                '1'
                                            ? true
                                            : false,

                                        onChanged: (addOnEventData[index]
                                                        .addonEventStatus ==
                                                    '1' &&
                                                !addOnEventData[index]
                                                    .userChecked!)
                                            ? null
                                            : addOnEventData[index].enabled!
                                                ? (value) {
                                                    log(value.toString());
                                                    addOnEventData[index]
                                                            .addonEventStatus =
                                                        value == false
                                                            ? '0'
                                                            : '1';

                                                    for (int i = 0;
                                                        i <=
                                                            addOnEventData
                                                                    .length -
                                                                1;
                                                        i++) {
                                                      log(i.toString());

                                                      if (i == index) {
                                                        addOnEventData[i]
                                                            .enabled = true;
                                                        addOnEventData[index]
                                                            .userChecked = true;
                                                      } else if (value ==
                                                          false) {
                                                        addOnEventData[i]
                                                            .enabled = true;
                                                      } else {
                                                        addOnEventData[i]
                                                            .enabled = false;
                                                      }
                                                    }
                                                    setState(() {
                                                      getCheckboxItems(
                                                          value!,
                                                          addOnEventData[index]
                                                              .addonEventId
                                                              .toString());
                                                      vid = user.userId
                                                          .toString();
                                                    });

                                                    // log("T/F.." + value.toString());
                                                    // setState(() {

                                                    //
                                                    // });
                                                  }
                                                : null,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            Loader.show(
                              context,
                              progressIndicator: CircularProgressIndicator(
                                backgroundColor: ColorSelect.secondary,
                              ),
                            );
                            submitData();
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.green,
                              elevation: 3,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: const BorderSide(color: Colors.white))),
                          child: Text(
                            "Submit",
                            style: GoogleFonts.roboto(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ))),
      );
    });
  }

  Future<void> checkInDetails() async {
    Map<String, String> header = {
      "Content-type": "application/json",
      "accept": "application/json",
    };
    var encodedBody = json.encode({
      "order_id": widget.scandata.toString(),
      //"order_id": "76732",
    });

    log("Result..$encodedBody");

    http.Response response = await http.post(Uri.parse(Api.checkInApi),
        body: encodedBody, headers: header);

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        //Loader.hide();
        name = jsonResponse["student_data"][0]["name"].toString();
        mobile = jsonResponse["student_data"][0]["mobile"].toString();
        bloodGroup = jsonResponse["student_data"][0]["bloodgroup"].toString();
        gender = jsonResponse["student_data"][0]["gender"].toString();
        // addOn_Events = jsonResponse["addon_events"];

        addOnEventData =
            addonEventFromJson(json.encode(jsonResponse["addon_events"]));
      });

      //log("Res.." + addOnEventData.toString());
    } else {
      Fluttertoast.showToast(
          msg: "No information available", backgroundColor: Colors.red);
    }
  }

  getCheckboxItems(bool checked, String eventId) async {
    if (checked == true) {
      setState(() {
        checkArray.add(eventId);
        eventid = eventId;
      });
    } else {
      setState(() {
        checkArray.remove(eventId);
      });
    }
  }

  Future<void> submitData() async {
    Map<String, String> header = {
      "Content-type": "application/json",
      "accept": "application/json",
    };

    var encodedBody = json.encode({
      //"order_id": "76732",
      "order_id": widget.scandata.toString(),
      "addon_event_id": eventid.toString(),
      "volunteer_id": vid.toString(),
      "addon_update_time": datetime.toString(),
    });

    //log("Body " + encodedBody.toString());
    if (checkArray.isNotEmpty) {
      http.Response response = await http.put(Uri.parse(Api.updateAddOnApi),
          body: encodedBody, headers: header);

      //log("STS " + response.statusCode.toString());
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        //var jsonResponse = json.decode(response.body);
        setState(() {
          Loader.hide();
          successPop();
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          });
        });

        //log("Res.." + jsonResponse.toString());
      }
    } else {
      setState(() {
        Loader.hide();
        log("message");
      });
      showToast();
    }
  }

  void successPop() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => true,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Dialog(
                insetPadding: const EdgeInsets.all(18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: SizedBox(
                  height: 140,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/successimg.png",
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "SUCCESS",
                                style: GoogleFonts.aclonica(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  showToast() {
    return Fluttertoast.showToast(
        msg: "Please select an event", backgroundColor: Colors.red);
  }
}
