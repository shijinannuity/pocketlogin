import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loggin_screen/Services/pocketbase.dart';

import 'forgotpassword.dart';
import 'checkbox.dart';
import 'register.dart';
import 'loginSuccess.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final textFieldFocusNode = FocusNode();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _passwordObscured = true;
  bool _checkBox1 = false;
  bool _checkBox2 = false;

  void _togglePasswordVisibility() {
    setState(() {
      _passwordObscured = !_passwordObscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, don't unfocus
      }
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          key: _formkey,
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                "Welcome Back !",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFedf0f8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your Email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email",
                    hintStyle:
                        TextStyle(color: Color(0xFFb2b7bf), fontSize: 18.0),
                  ),
                  obscureText: false,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFedf0f8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _password,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _passwordObscured, // Use separate state variable
                  focusNode: textFieldFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                    hintStyle: const TextStyle(
                        color: Color(0xFFb2b7bf), fontSize: 18.0),
                    suffixIcon: GestureDetector(
                      onTap:
                          _togglePasswordVisibility, // Toggle password visibility
                      child: Icon(
                        _passwordObscured
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (cxt) => ForgotPass()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 1.0, left: 250),
                child: Align(
                  child: Stack(
                    children: [
                      const Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 235, 33, 140),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          width: 120,
                          height: 1.5,
                          color: Color.fromARGB(255, 235, 33, 140),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .035,
                  ),
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
                const Text(
                  "Remember me",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .03,
                      vertical: 10.0),
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
                Row(
                  children: [
                    const Text(
                      'I\'m agree to the',
                      style: TextStyle(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        ' Terms of Service',
                        style:
                            TextStyle(color: Color.fromARGB(255, 235, 33, 140)),
                      ),
                    ),
                    const Text('  and', style: TextStyle(color: Colors.grey)),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        '  Privacy Policy',
                        style:
                            TextStyle(color: Color.fromARGB(255, 235, 33, 140)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                final pb = PocketBaseAuthClass();
                final bool isloggedin =
                    await pb.login(_name.text, _password.text, context);
                if (isloggedin) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (cxt) => LoginSuccess()),
                  );
                }
                //
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(80, 40, 80, 40),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 235, 33, 140),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign Up",
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
            const Text(
              "OR",
              style: TextStyle(color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (cxt) => RegisterScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(80, 40, 80, 40),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 235, 33, 140),
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
          ],
        ),
      ),
    );
  }
}
