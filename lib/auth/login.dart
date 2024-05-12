import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homey/auth/reset.dart';
import '../components/custombuttonauth.dart';
import '../components/customlogoauth.dart';
import '../components/textformfield.dart';
import '../components/toast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Objects for controlling the text inputs
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Form(
            key: formstate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 50),
                const CustomLogoAuth(),
                Container(height: 30),
                const Text("Login",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Container(height: 10),
                const Text("Login To Continue Using The App",
                    style: TextStyle(color: Colors.grey)),
                Container(height: 20),
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 10),
                CustomTextForm(
                  hinttext: "ُEnter Your Email",
                  mycontroller: email,
                  // ignore: body_might_complete_normally_nullable
                  validator: (val) {
                    if (val == "") {
                      return "* Required";
                    }
                  },
                ),
                Container(height: 10),
                const Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 10),
                CustomTextForm(
                  hinttext: "ُEnter Your Password",
                  mycontroller: password,
                  // ignore: body_might_complete_normally_nullable
                  validator: (val) {
                    if (val == "") {
                      return "* Required";
                    }
                  },
                ),
                Container(height: 10),
                InkWell(
                  onTap: () async {
                    if (email.text == '') {
                      return showToast(message: 'You Have To Enter Your Email');
                    }
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email.text);
                      showToast(message: 'An Email has been sent if verified');
                      // ignore: unused_catch_clause
                    } on FirebaseAuthException catch (e) {
                      showToast(message: 'User Not Found');
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    alignment: Alignment.topRight,
                    child: const Text(
                      "Forgot Password ?",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomButtonAuth(
              title: "Login",
              onPressed: () async {
                if (formstate.currentState!.validate()) {
                  try {
                    // ignore: unused_local_variable
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email.text, password: password.text);
                    Navigator.of(context).pushReplacementNamed("homepage");
                  } on FirebaseAuthException catch (e) {
                    print(e.code);
                    if (e.code == 'invalid-credential') {
                      showToast(message: 'Invalid Credentials');
                    } else if (e.code == 'invalid-email') {
                      showToast(message: 'Enter a valid email');
                    } else if (e.code == 'too-many-requests') {
                      print(e.code);
                      showToast(message: 'Too Many Attempts');
                    }
                  }
                } else {
                  print("Can't Validate");
                }
              }),
          Container(height: 15),
          MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.orange[700],
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Reset();
                }));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Reset Password"),
                ],
              )),
          // Container(height: 20),
        ]),
      ),
    );
  }
}
