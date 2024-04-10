import 'package:flutter/material.dart';
import 'package:loggin_screen/Screens/login.dart';
import 'package:loggin_screen/Services/pocketbase.dart';

class LoginSuccess extends StatelessWidget {
  const LoginSuccess({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          // Image.asset('assets/Login_success.png'),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Thank you for completing your profile.As a next step,complete your KYC to start iversting',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {},
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
                    "Start KYC",
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

          GestureDetector(
            onTap: () {
              PocketBaseAuthClass().logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
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
                    "Logout",
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
    );
  }
}
