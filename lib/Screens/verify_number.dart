import 'package:flutter/material.dart';
import 'package:loggin_screen/Screens/login.dart';
import 'package:loggin_screen/Services/pocketbase.dart';
import 'package:loggin_screen/component/snackbars.dart';

class VerifyNumber extends StatefulWidget {
  final String email, name, password, confirmpassword;
  final String otpid;
  VerifyNumber(
      {super.key,
      required this.email,
      required this.name,
      required this.password,
      required this.confirmpassword,
      required this.otpid});

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Verify Phone Number",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(children: [
        const SizedBox(
          height: 30,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Enter your OTP code here.",
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            5,
            (index) => SizedBox(
              width: 50.0,
              child: TextField(
                controller: controllers[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
                maxLength: 1,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  counter: Offstage(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 235, 33, 140)),
                  ),
                ),
                onChanged: (value) {
                  if (value.length == 1) {
                    if (index < controllers.length - 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  } else if (value.isEmpty) {
                    if (index > 0) {
                      FocusScope.of(context).previousFocus();
                    }
                  }
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Didn\'t receive the OTP? ",
              style: TextStyle(color: Colors.white70, fontSize: 20),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                "Resend",
                style: TextStyle(
                    color: Color.fromARGB(255, 235, 33, 140), fontSize: 20),
              ),
            )
          ],
        ),
        GestureDetector(
          onTap: () async {
            String otp =
                controllers.map((controller) => controller.text).join();
            final res =
                await PocketBaseAuthClass().verifymailotp(widget.otpid, otp);
            if (res) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(successSnackbar("OTP Verification Success"));
              final signup = await PocketBaseAuthClass().signup(
                  widget.name,
                  widget.password,
                  widget.confirmpassword,
                  widget.email,
                  context);
              if (signup) {
                ScaffoldMessenger.of(context).showSnackBar(
                    successSnackbar("Registration Success\nPlease Login"));
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(errorSnackbar(
                    "Registration Failed\nPlease try again later"));
              }
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(errorSnackbar("OTP Verification failed"));
            }
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (cxt) => ChangePassword()));
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(80, 40, 80, 40),
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 235, 33, 140),
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(
                    child: Text(
                  "Verify",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500),
                ))),
          ),
        ),
      ]),
    );
  }
}
