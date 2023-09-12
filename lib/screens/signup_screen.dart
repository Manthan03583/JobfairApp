import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volunteer_app/screens/home.dart';
import 'package:volunteer_app/screens/login.dart';
import '../commons/colorselect.dart';
import '../widgets/screen_bg.dart';
import '../widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscure = true;
  final ImagePicker _ppicker = ImagePicker();
  File? displayImage;
  String? file;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context);
        return Future.value(false);
      },
      child: ScreenBackground(
          child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Signup",
                  style: GoogleFonts.adamina(
                    color: Colors.white,
                    fontSize: 30,
                    //fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            //.............Name field.................//
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8),
                              child: SizedBox(
                                child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Z0-9]'),
                                      ),
                                      //LengthLimitingTextInputFormatter(10),
                                    ],
                                    //controller: _nameController,
                                    //style: const TextStyle(fontSize: 16),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Name is empty';
                                      } else if (value.length < 4) {
                                        return 'Name must be 4 character';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: inputFieldDecoration(
                                        labelTextInput: "Name",
                                        icon: const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 20,
                                        ))),
                              ),
                            ),
                            //.............Email Address field.................//
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8),
                              child: SizedBox(
                                child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    //controller: _nameController,

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
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: inputFieldDecoration(
                                        labelTextInput: "Email",
                                        icon: const Icon(
                                          Icons.email,
                                          color: Colors.white,
                                          size: 20,
                                        ))),
                              ),
                            ),
                            //.............Password field..................//
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8),
                              child: SizedBox(
                                child: TextFormField(
                                  obscureText: _isObscure,
                                  style: const TextStyle(color: Colors.white),

                                  // controller: _nameController,

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
                                      color: Colors.white,
                                    ),
                                    suffixIconColor: Colors.white,
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
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.white)),
                                    errorBorder: OutlineInputBorder(
                                      gapPadding: 0.0,
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 0.5,
                                      ),
                                    ),
                                    focusedErrorBorder:
                                        GradientOutlineInputBorder(
                                            gradient: gradclr(),
                                            borderRadius:
                                                BorderRadius.circular(23),
                                            width: 1),
                                    hintStyle: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            //.............Phone Number field.................//
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8),
                              child: SizedBox(
                                child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]'),
                                      ),
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    //controller: _nameController,
                                    //style: const TextStyle(fontSize: 16),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Phone Number is empty';
                                      } else if (value.length < 10) {
                                        return 'Enter Valid Phone Number !';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: inputFieldDecoration(
                                      labelTextInput: "Phone Number",
                                      icon: const Icon(
                                        Icons.call,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    )),
                              ),
                            ),
                            //.............photo field.................//
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  // color: ColorSelect.grey200,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      uploadDialog();
                                      //bottomSheet();
                                    },
                                    child: Container(
                                      height: 48,
                                      //width: 75,
                                      decoration: BoxDecoration(
                                          color: ColorSelect.grey350,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(20))),
                                      child: const Center(
                                          child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 3, right: 3),
                                        child: Text(
                                          " Choose Photo ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      )),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        file != null
                                            ? file.toString()
                                            : "No file choosen",
                                        maxLines: 2,
                                        //overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //.............College field.................//
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8),
                              child: SizedBox(
                                child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Z0-9]'),
                                      ),
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    //controller: _nameController,
                                    //style: const TextStyle(fontSize: 16),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'College is empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: inputFieldDecoration(
                                        labelTextInput: "College",
                                        icon: const Icon(
                                          Icons.school,
                                          color: Colors.white,
                                          size: 20,
                                        ))),
                              ),
                            ),
                            //.............Blood group field.................//
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8),
                              child: SizedBox(
                                child: TextFormField(
                                    style: const TextStyle(color: Colors.white),

                                    //controller: _nameController,
                                    //style: const TextStyle(fontSize: 16),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Field is empty';
                                      } else if (!RegExp(r"(A|B|AB|O)[+-]")
                                          .hasMatch(value)) {
                                        return 'Enter valid email';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: inputFieldDecoration(
                                        labelTextInput: "Blood Group",
                                        icon: const Icon(
                                          Icons.water_drop,
                                          color: Colors.white,
                                          size: 20,
                                        ))),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 40,
                              width: width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: ElevatedButton(
                                  onPressed: () {
                                    //.........write it inside validation..................//
                                    // Loader.show(
                                    //   context,
                                    //   progressIndicator:
                                    //       CircularProgressIndicator(
                                    //     backgroundColor: ColorSelect.secondary,
                                    //   ),
                                    // );
                                    // if (_formKey.currentState!.validate()) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()),
                                    );
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
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          side: const BorderSide(
                                              color: Colors.white))),
                                  child: Text(
                                    "Sign Up",
                                    style:
                                        GoogleFonts.aclonica(color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
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
                  const SizedBox(
                    child: Text(
                      "Have an account ?",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        " Login ",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          )),
        )),
      )),
    );
  }

  void uploadDialog() {
    showDialog(
        context: context,
        barrierDismissible: true, // user must tap button!
        barrierColor: const Color.fromARGB(161, 107, 101, 101),
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Choose File Type",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Divider(
                          color: ColorSelect.blueShade800,
                          thickness: 0.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10),
                          child: InkWell(
                            onTap: () async {
                              final XFile? pickedFile = await _ppicker
                                  .pickImage(source: ImageSource.camera);

                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              log("PIC...$pickedFile");

                              if (pickedFile != null) {
                                setState(() {
                                  displayImage = File(pickedFile.path);
                                  file = displayImage!.path.split('/').last;
                                });
                              }
                              log("PIC...$file");
                            },
                            child: SizedBox(
                              height: 35,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/camera.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  const Text(
                                    "Camera",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10),
                          child: InkWell(
                            onTap: () async {
                              final XFile? pickedFile = await _ppicker
                                  .pickImage(source: ImageSource.gallery);

                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              log("PIC...$pickedFile");
                              if (pickedFile != null) {
                                setState(() {
                                  displayImage = File(pickedFile.path);
                                  file = displayImage!.path.split('/').last;
                                });
                              }
                              log("PIC...$file");
                            },
                            child: SizedBox(
                              height: 35,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/gallery.png",
                                    width: 36,
                                    height: 36,
                                  ),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  const Text(
                                    "Gallery",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 45.0,
                  // ),
                ],
              ),
            ),
          );
        });
  }
}
