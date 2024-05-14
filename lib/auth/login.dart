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

  bool isLoading = false; // Add this variable to track loading state
  bool obscurePassword = true;

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
                  hinttext: "Enter Your Email",
                  mycontroller: email,
                  // ignore: missing_return
                  validator: (val) {
                    if (val == "") {
                      return "* Required";
                    }
                    if (!val!.contains('@')) {
                      return "Invalid Email";
                    }
                    return null;
                  },
                ),
                Container(height: 10),
                const Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 10),
                Stack(alignment: Alignment.centerRight, children: [
                  CustomTextForm(
                    hinttext: "Enter Your Password",
                    mycontroller: password,
                    obscureText: obscurePassword,
                    // ignore: missing_return
                    validator: (val) {
                      if (val == "") {
                        return "* Required";
                      }
                      return null;
                    },
                  ),
                  Positioned(
                    top: 1,
                    bottom: 25,
                    child: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                ]),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 20, left: 10),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "The Default Password is : 123456",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomButtonAuth(
                  title: "Login",
                  onPressed: () async {
                    if (formstate.currentState!.validate()) {
                      setState(() {
                        isLoading = true; // Show loading indicator
                      });

                      if (password.text == '123456') {
                        setState(() {
                          isLoading = false; // Hide loading indicator
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Reset();
                        }));
                        email.text = '';
                        password.text = '';
                      } else {
                        try {
                          // ignore: unused_local_variable
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email.text, password: password.text);
                          Navigator.of(context)
                              .pushReplacementNamed("homepage");
                        } on FirebaseAuthException catch (e) {
                          print(e.code);
                          if (e.code == 'invalid-credential') {
                            showToast(message: 'Invalid Credentials');
                          } else {
                            showToast(message: 'An error occurred');
                          }
                        } finally {
                          setState(() {
                            isLoading = false; // Hide loading indicator
                          });
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
                email.text = '';
                password.text = '';
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_open), // Add lock icon
                  SizedBox(width: 5),
                  Text("Reset Password"),
                ],
              )),
          // Container(height: 20),
        ]),
      ),
    );
  }
}
