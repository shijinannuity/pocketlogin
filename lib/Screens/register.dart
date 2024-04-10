import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loggin_screen/Screens/verify_number.dart';
import 'package:loggin_screen/Services/pocketbase.dart';
import 'package:loggin_screen/component/snackbars.dart';

import 'checkbox.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController pass1 = TextEditingController();
  TextEditingController pass2 = TextEditingController();
  TextEditingController email = TextEditingController();
  bool _checkBox1 = false;
  bool _checkBox2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          key: _formKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding:
                  EdgeInsets.only(top: 5.0, left: 8.0, right: 8.0, bottom: 4.0),
              child: Text(
                "Enter Full Name",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFedf0f8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: name,
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your full name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  obscureText: false,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.only(
                  top: 10.0, left: 8.0, right: 8.0, bottom: 4.0),
              child: Text(
                "Enter New Password",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFedf0f8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: pass1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your new Password';
                    }
                    // return null;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  obscureText: true,
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.only(
                  top: 10.0, left: 8.0, right: 8.0, bottom: 4.0),
              child: Text(
                "Confirm Password",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFedf0f8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: pass2,
                  validator: (value) {
                    if (value == null || value.isEmpty || pass1.text != value) {
                      return 'Please Enter correct password';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  obscureText: true,
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.only(
                  top: 10.0, left: 8.0, right: 8.0, bottom: 4.0),
              child: Text(
                "Enter email",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFedf0f8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  // obscureText: true,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: CheckboxCustom(
                    value: _checkBox1,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          _checkBox1 = value;
                        });
                      }
                    },
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                      children: [
                        TextSpan(
                          text: 'I\'m agree to the',
                        ),
                        TextSpan(
                          text: '  Terms of Service',
                          style: TextStyle(
                              color: Color.fromARGB(255, 235, 33, 140)),
                        ),
                        TextSpan(
                          text: '  and',
                        ),
                        TextSpan(
                          text: '  Privacy Policy',
                          style: TextStyle(
                              color: Color.fromARGB(255, 235, 33, 140)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CheckboxCustom(
                    value: _checkBox2,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          _checkBox2 = value;
                        });
                      }
                    },
                  ),
                ),
                const Text(
                  "I agree to receive updates via whatsapp .",
                  style: TextStyle(fontSize: 15, color: Colors.white70),
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                if (_checkBox1) {
                  // print("Email exist:CHECKING");
                  bool emailnotexist = await PocketBaseAuthClass()
                      .checkemailnotexist(email.text);
                  if (emailnotexist) {
                    final res =
                        await PocketBaseAuthClass().emailotp(email.text);
                    if (res != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VerifyNumber(
                              email: email.text,
                              password: pass1.text,
                              confirmpassword: pass2.text,
                              name: name.text,
                              otpid: res)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(errorSnackbar(
                          "Error Occured while sending otp.\nPlease try again later"));
                    }
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(errorSnackbar("Email already exist!"));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(errorSnackbar(
                      "Please agree the Terms of Service and Privacy Policies"));
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(80, 40, 80, 40),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 235, 33, 140),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Do you have an account ? ",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    print("tapped");
                  },
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Color.fromARGB(255, 235, 33, 140),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
