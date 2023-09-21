import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/material.dart';
import 'package:volunteer_app/commons/colorselect.dart';
import 'package:volunteer_app/screens/scanner_screen.dart';
import 'package:volunteer_app/screens/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? cameraScanResult;
  final GlobalKey<ScaffoldState> key = GlobalKey();
  String? name;
  String? email;

  @override
  void initState() {
    sharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: key,
      drawer: drawer(),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.3),
        title: SizedBox(
          height: height * 0.3,
          width: width * 0.3,
          child: Image.asset(
            "assets/images/logo.png",
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu Icon',
          onPressed: () {
            key.currentState!.openDrawer();
          },
        ),
      ),
      body: SafeArea(
          child: SizedBox(
        height: height,
        width: width,
        //color: Colors.amber,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8)),
                  //color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        Card(
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              splashColor: Colors.green,
                              title: const Text(
                                "Scan for checkIn",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              leading: const Icon(
                                Icons.check_circle,
                                color: Color.fromARGB(199, 96, 79, 100),
                              ),
                              onTap: () async{
                                await _scanQR();

                                // Navigator.of(context).pop();
                              },
                              visualDensity: const VisualDensity(vertical: -3),
                            ),
                          ),
                        ),
                        // Card(
                        //   elevation: 1,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: ListTile(
                        //       title: Text(
                        //         "Event List",
                        //         style: TextStyle(
                        //             fontSize: 16, color: Colors.black),
                        //       ),
                        //       trailing: Icon(Icons.keyboard_arrow_right),
                        //       leading: Icon(
                        //         Icons.list,
                        //         color: Color.fromARGB(199, 96, 79, 100),
                        //       ),
                        //       onTap: () {
                        //         Navigator.of(context).pop();
                        //       },
                        //       visualDensity: const VisualDensity(vertical: -3),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future _scanQR() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isGranted) {
      setState(() async {
        cameraScanResult = await scanner.scan();
        if (cameraScanResult != null) {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ScannerScreen(scandata: cameraScanResult.toString())),
          );
        } else {
          const Text("No Data available");
        }
      });

      //log("Result.." + cameraScanResult.toString());
    } else {
      var isGranted = await Permission.camera.request();

      if (isGranted.isGranted) {
        cameraScanResult = await scanner.scan();
        //log("Result.." + cameraScanResult.toString());
      }
    }
  }

  drawer() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.65,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 100,
            color: Colors.white.withOpacity(0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(
                //   height: 4,
                // ),
                Row(
                  children: [
                    Text(
                      "Volunteer Account",
                      style:
                          GoogleFonts.abel(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      size: 18,
                      color: Colors.black,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: Text(name.toString(),
                      style: GoogleFonts.aboreto(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(email.toString(),
                    style: const TextStyle(fontSize: 13, color: Colors.black)),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          ListTile(
            title: const Text(
              "Logout",
              style: TextStyle(
                  fontSize: 13, color: Color.fromARGB(247, 96, 79, 100)),
            ),
            leading: const Icon(
              Icons.logout,
              color: Color.fromARGB(249, 96, 79, 100),
            ),
            onTap: () {
              logoutDialog();
            },
            visualDensity: const VisualDensity(vertical: -3),
          ),
        ],
      ),
    );
  }

  void logoutDialog() {
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        barrierColor: Colors.white.withOpacity(0.3),
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Logout",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Are you sure, you want to logout?",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 45.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SizedBox(
                            width: 55,
                            height: 30,
                            //color: Colors.amber,
                            child: Center(
                              child: Text(
                                "No",
                                style: TextStyle(
                                    fontSize: 15, color: ColorSelect.secondary),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setString('volunteerId', "");
                            prefs.setString('volunteerName', "");
                            prefs.setString('volunteerEmail', "");

                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SplashPage()),
                                (Route<dynamic> route) => route is HomeScreen);
                          },
                          child: SizedBox(
                            width: 55,
                            height: 30,
                            child: Center(
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    fontSize: 15, color: ColorSelect.secondary),
                              ),
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
        });
  }

  Future<void> sharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("volunteerName");
      email = prefs.getString("volunteerEmail");
    });

    log("value$name");
  }
}
