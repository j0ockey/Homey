import 'package:flutter/material.dart';

import '../components/customlogoauth.dart';
import '../components/textformfield.dart';

class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 50),
                const CustomLogoAuth(),
                Container(height: 30),
                const Text("Reset Password",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Container(height: 10),
                const Text("Enter your email and new password",
                    style: TextStyle(color: Colors.grey)),
                Container(height: 20),
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 10),
                CustomTextForm(
                  hinttext: "Enter Your Email",
                  mycontroller: email,
                  validator: (val) {
                    if (val == "") {
                      return "* Required";
                    }
                    return null;
                  },
                ),
                Container(height: 20),
                const Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 10),
                CustomTextForm(
                  hinttext: "Enter New Password",
                  mycontroller: password,
                  validator: (val) {
                    if (val == "") {
                      return "* Required";
                    }
                    return null;
                  },
                ),
                Container(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement your password reset logic here
                  },
                  child: const Text('Reset Password'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
