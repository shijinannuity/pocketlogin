import 'package:flutter/material.dart';

import 'dart:async';

import 'package:loggin_screen/Screens/passwordsuccessfull.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController pass1 = new TextEditingController();
  TextEditingController pass2 = new TextEditingController();

  late Timer _timer;
  int _start = 120;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  String timerText() {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return 'Resend(${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')})';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Verify your number",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          key: _formKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                  top: 30.0, left: 8.0, right: 8.0, bottom: 4.0),
              child: Text(
                "Enter OTP",
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your OTP';
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
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 300),
                child: Text(
                  timerText(),
                  style: const TextStyle(color: Color.fromARGB(255, 235, 33, 140)),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  top: 30.0, left: 8.0, right: 8.0, bottom: 4.0),
              child: Text(
                "New Password",
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
                  controller: pass1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your password';
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
            const Padding(
              padding: EdgeInsets.only(
                  top: 40.0, left: 8.0, right: 8.0, bottom: 4.0),
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
                  controller: pass2,
                  validator: (value) {
                    if (value == null || value.isEmpty || value != pass1.text) {
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
            const SizedBox(
              height: 30,
            ),
            Container(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "\* Password should be of atleast 8 characters , must contain one uppercase ,one lowercase & one numeric ",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                ),
              ),
            ),
             GestureDetector(
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (cxt) => passWordChangedSuccess()),
                 );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(80, 40, 80, 40),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 235, 33, 140),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "Verify",
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
          ],
        ),
      ),
    );
  }
}
