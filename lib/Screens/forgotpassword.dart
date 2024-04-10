import 'package:flutter/material.dart';

class ForgotPass extends StatelessWidget {
  const ForgotPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Forgot Password",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Please enter your Mobile Number . You will receive a OTP to create a new password .",
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
              decoration: BoxDecoration(
                  color: const Color(0xFFedf0f8),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Mobile Number",
                    hintStyle:
                        TextStyle(color: Color(0xFFb2b7bf), fontSize: 18.0)),
                obscureText: true,
              ),
            ),
          ),
             GestureDetector(
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (cxt)=> VerifyNumber() ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(80,40,80,40),
                          child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              decoration: BoxDecoration(
                                  color:const Color.fromARGB(255, 235, 33, 140),
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Center(
                                  child: Text(
                                "Send",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w500),
                              ))),
                        ),
                      ),
        ],
      ),
    );
  }
}
