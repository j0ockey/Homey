import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../util/smart_device_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Padding constants
  final double horizontalPadding = 40;

  bool isSigningOut = false; // Track whether sign-out process is ongoing

  String? userId;

  @override
  void initState() {
    super.initState();
    // Get the current user's ID when the page is initialized
    getUserID();
  }

  void getUserID() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
        print('User ID: $userId'); // Debug print
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
        actions: [
          // Stack : to make the overlap on the icon button with the loading
          Stack(
            children: [
              IconButton(
                onPressed: isSigningOut
                    ? null // Disable the button while sign-out process is ongoing
                    : () async {
                        setState(() {
                          isSigningOut =
                              true; // Set isSigningOut to true when sign-out process starts
                        });
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil("login", (route) => false);
                        setState(() {
                          isSigningOut =
                              false; // Set isSigningOut to false after sign-out process completes
                        });
                      },
                icon: const Icon(Icons.exit_to_app),
                iconSize: 30,
              ),
              if (isSigningOut)
                const Positioned(
                  top: 8,
                  right: 8,
                  child: CircularProgressIndicator(
                    // A colored animation for the indicator that doesn't change its color overtime
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App bar
          const SizedBox(height: 20),

          // Welcome home
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

          // Smart devices grid
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

          Expanded(
            child: StreamBuilder(
              stream: FirebaseDatabase.instance.ref('/').onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Ensure the data is available and properly cast it
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  Map<dynamic, dynamic> devicesMap =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

                  // Debug print of the raw data
                  print('Devices Map: $devicesMap');

                  // Filter devices based on userId
                  List<Map<String, dynamic>> userDevices = [];
                  devicesMap.forEach((deviceId, deviceData) {
                    if (deviceData['users'] != null &&
                        (deviceData['users'] as List<dynamic>)
                            .contains(userId)) {
                      userDevices.add({
                        'deviceId': deviceId,
                        ...Map<String, dynamic>.from(deviceData)
                      });
                    }
                  });

                  // Debug print of filtered devices
                  print('User Devices: $userDevices');

                  return GridView.builder(
                    itemCount: userDevices.length,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.3,
                    ),
                    itemBuilder: (context, index) {
                      return SmartDeviceBox(
                        smartDeviceName: userDevices[index]['name'],
                        iconPath: userDevices[index]['icon'],
                        powerOn: userDevices[index]['value'],
                        onChanged: (value) => powerSwitchChanged(
                            value, index, userDevices[index]['deviceId']),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No devices found'));
                }
              },
            ),
          )
        ],
      ),
    );
  }

  // Power button switched
  void powerSwitchChanged(bool value, int index, String deviceId) {
    DatabaseReference deviceRef = FirebaseDatabase.instance.ref('/$deviceId');
    deviceRef.update({'value': value});
  }
}
