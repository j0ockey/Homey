import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'package:homey/auth/login.dart';
import '../util/smart_device_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // padding constants
  final double horizontalPadding = 40;
  final double verticalPadding = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
            iconSize: 30,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // app bar

          const SizedBox(height: 20),

          // welcome home
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome To,",
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                ),
                Text(
                  'Homey',
                  style:
                      GoogleFonts.bebasNeue(fontSize: 72, color: Colors.orange),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Divider(
              thickness: 1,
              color: Color.fromARGB(255, 204, 204, 204),
            ),
          ),

          const SizedBox(height: 25),

          // smart devices grid
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              "Smart Devices",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // grid
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('devices').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Convert the snapshot data to a list
                List<Map<String, dynamic>> data =
                    snapshot.data!.docs.map((doc) {
                  return {
                    ...(doc.data() as Map<String, dynamic>),
                    'id': doc.id
                  };
                }).toList();

                return GridView.builder(
                  itemCount: data.length,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.3,
                  ),
                  itemBuilder: (context, index) {
                    return SmartDeviceBox(
                      smartDeviceName: data[index]['name'],
                      iconPath: data[index]['icon'],
                      powerOn: data[index]['value'],
                      onChanged: (value) =>
                          powerSwitchChanged(value, index, data[index]['id']),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // power button switched
  void powerSwitchChanged(bool value, int index, String deviceId) {
    // Update the value in Firestore
    CollectionReference devices =
        FirebaseFirestore.instance.collection('devices');
    devices.doc(deviceId).update({'value': value});
  }
}
