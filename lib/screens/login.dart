import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:volunteer_app/provider/user.dart';
import 'package:volunteer_app/screens/home.dart';
import '../commons/colorselect.dart';
import '../commons/urls.dart';
import '../widgets/screen_bg.dart';
import '../widgets/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  final key = GlobalKey<FormState>();
  int? volunteerId;
  final emailController = TextEditingController();
  final pswdController = TextEditingController();

  @override
  void initState() {
    // emailController.text = 'avipsa.edevlop@gmail.com';
    // pswdController.text = "avipsa@123";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ScreenBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: key,
          child: SafeArea(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 15, right: 15),
              height: height,
              width: width,
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: height * 0.15,
                        width: width * 0.6,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Login",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 9, 94, 241),
                            fontSize: 28,
                            //fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                          child: Container(
                            width: width,
                            height: height * 0.36,
                            decoration: BoxDecoration(
                              color:   Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const SizedBox(
                                //   height: 10,
                                // ),
                                //.............Email Address field.................//
    
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: SizedBox(
                                    child: TextFormField(
                                      style: const TextStyle(color: Colors.black),
                                      controller: emailController,
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Email is empty';
                                        } else if (!RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(text)) {
                                          return 'Enter valid email';
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: inputFieldDecoration(
                                        labelTextInput: "Email",
                                        icon: const Icon(
                                          Icons.email,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                //...............Password field....................//
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: SizedBox(
                                    child: TextFormField(
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      obscureText: _isObscure,
                                      controller: pswdController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Password is empty';
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.lock,
                                          color: Colors.black,
                                        ),
                                        suffixIconColor: Colors.black,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscure
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isObscure = !_isObscure;
                                            });
                                          },
                                        ),
                                        labelText: "Password",
                                        labelStyle: labelTextStyle(),
                                        contentPadding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 8.0),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color:Colors.blueAccent.withOpacity(0.3),
                                            width: 2,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide:  BorderSide(
                                            color: Color.fromARGB(255, 9, 94, 241),
                                            width: 2
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          gapPadding: 0.0,
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          
                                        ),
                                        hintStyle:  TextStyle(
                                          fontSize: 16, color: Colors.blueAccent.withOpacity(0.2)),
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 15),
                                  child: SizedBox(
                                    height: 50,
                                    width: width * 0.85,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Provider.of<User>(context, listen: false)
                                          .signIn(emailController.text.toString(),
                                          pswdController.text.toString()
                                        );                               
                                        if (key.currentState!.validate()) {
                                          Loader.show(
                                            context,
                                            progressIndicator:CircularProgressIndicator(
                                              backgroundColor: ColorSelect.secondary,
                                            ),
                                          );                                
                                          userLogin();
                                        } else {
                                          Loader.hide();
                                          Fluttertoast.showToast(
                                            msg: "Please fill the details properly",
                                            backgroundColor: Colors.red
                                          );
                                        }                               
                                        //.........write it inside validation..................//
                                
                                        // if (_formKey.currentState!.validate()) {
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const HomeScreen()),
                                    // );
                                    //   Future.delayed(const Duration(seconds: 2),
                                    //       () {
                                    //     Loader.hide();
                                    //   });
                                    // } else {
                                    //   Loader.hide();
                                    //   ScaffoldMessenger.of(context)
                                    //       .showSnackBar(SnackBar(
                                    //     backgroundColor: Colors.red[400],
                                    //     content: Text("Fill details Properly"),
                                    //   ));
                                    // }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 3,
                                        backgroundColor: const Color.fromARGB(255, 9, 94, 241),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                          side: const BorderSide(
                                            color: Color.fromARGB(255, 9, 94, 241),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Log In",
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 40,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //   Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       const SizedBox(
                //         child: Text(
                //           "Create new Account?",
                //           style: TextStyle(color: Colors.black),
                //         ),
                //       ),
                //       const SizedBox(
                //         width: 2,
                //       ),
                //       InkWell(
                //         onTap: () {
                //           Navigator.pushReplacement(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => const SignUpScreen()),
                //           );
                //         },
                //         child: const Padding(
                //           padding: EdgeInsets.all(8.0),
                //           child: Text(
                //             " SignUp",
                //             style: TextStyle(
                //               color: Color(0xff20ABE3),
                //             ),
                //           ),
                //         ),
                //       )
                //     ],
                //   )
                // ]
                  ],
                ),
          ),
        )
        ),
      ),
    )
    );
  }

  Future<void> userLogin() async {
    Map<String, String> header = {
      "Content-type": "application/json",
      "accept": "application/json",
    };

    var encodedBody = json.encode({
      "email": emailController.text,
      "password": pswdController.text,
    });

    http.Response response = await http.post(Uri.parse(Api.loginApi),
      body: encodedBody, headers: header);
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      var jsonResponse = json.decode(response.body);
      // ignore: avoid_print
      print(response.body);
      volunteerId = jsonResponse["volunteer_data"]["id"];
      String name = jsonResponse["volunteer_data"]["name"];
      String email = jsonResponse["volunteer_data"]["email"];
      // ignore: use_build_context_synchronously
      Provider.of<User>(context, listen: false).volunteerId(volunteerId!);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString("volunteerId", volunteerId.toString());
      prefs.setString("volunteerName", name.toString());
      prefs.setString("volunteerEmail", email.toString());

      setState(() {
        Loader.hide();
      });
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      setState(() {
        Loader.hide();
      });
      Fluttertoast.showToast(
          msg: "Please fill the details properly", backgroundColor: Colors.red);
    }
  }
}
