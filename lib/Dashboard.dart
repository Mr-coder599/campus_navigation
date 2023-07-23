import 'package:campus_app/LocationList.dart';
import 'package:campus_app/Login_Page.dart';
import 'package:campus_app/getLocation.dart';
import 'package:campus_app/showlocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .3,
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage('assets/images/HeaderBackground.png'),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 64,
                    margin: EdgeInsets.only(bottom: 80),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: AssetImage('assets/images/logo.jpg'),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: <Widget>[
                        //     Text(
                        //       'Fullname:',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //     Text(
                        //       'Position:',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      primary: false,
                      children: <Widget>[
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Image.asset(
                              //   'assets/images/education-graduate-cap-design_676308-33.webp',
                              //   height: 128,
                              // ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ShowLocations(
                                              user: widget.user)));
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/education-graduate-cap-design_676308-33.webp',
                                      height: 90,
                                    ),
                                    Text(
                                      'Show All location',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepPurple),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Image.asset(
                              //   'assets/images/location.png',
                              //   height: 128,
                              // ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LocationPage(
                                                  user: widget.user,
                                                )));
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/images/location.png',
                                        height: 90,
                                      ),
                                      Text(
                                        'Location',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                            side: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Image.asset(
                              //   'assets/images/User.png',
                              //   height: 90,
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.green,
                                              title: Text(
                                                'About Developer',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              content: SingleChildScrollView(
                                                child: Container(
                                                  child: Card(
                                                    child: Container(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(16),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Center(
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        'assets/images/sainab.jpg'),
                                                                radius: 60,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Text(
                                                              'Fullname:    '
                                                              '   ALABI '
                                                              'ZAINAB',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Text(
                                                              'Matric Number'
                                                              ' FUO/19/0076  '
                                                              '',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Text(
                                                              'Supervisor:    '
                                                              '   Mr R.A '
                                                              'AZEEZ',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Text(
                                                              'Co-Supervisor'
                                                              ' Mr Bello '
                                                              'Jemilu',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Text(
                                                              'Co-Supervisor'
                                                              ' Mr A.O Akinlolu',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                              'Thank You',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/User.png',
                                        height: 90,
                                      ),
                                      Text(
                                        'About Developer',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Image.asset(
                              //   'assets/images/save_location.png',
                              //   height: 128,
                              // ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LocationList(
                                                  user: widget.user,
                                                )));
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/images/save_location.png',
                                        height: 90,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Save Location',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            // FloatingActionButton(
                            //   onPressed: () {
                            //     setState(() {
                            //       // openWhatsApp();
                            //     });
                            //   },
                            //   tooltip: 'Contact Us',
                            //   child: CircleAvatar(
                            //     backgroundImage:
                            //         AssetImage('assets/images/whatsapp.webp'),
                            //     radius: 40,
                            //     // child: Text(
                            //     //   'Chat Us',
                            //     //   style: TextStyle(color: Colors.red),
                            //     // ),
                            //     // child: GestureDetector(
                            //     //   onTap: openWhatsApp,
                            //     //   // child: Text(
                            //     //   //   widget.Landsales["agentPhone"],
                            //     //   // ),
                            //     // ),
                            //   ),
                            // ),
                          ],
                        ),
                        TextButton(
                          onPressed: () async {
                            //setState(() async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                            //  });
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                      crossAxisCount: 2,
                    ),
                  ),

                  //another view
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void openWhatsApp() async {
  //   final String phoneNumber = '+2348144509192';
  //   '1234567890'; // Replace with your desired phone number
  //   String whatsappUrl = 'https://wa.me/$phoneNumber';
  //   if (await canLaunch(whatsappUrl)) {
  //     await launch(whatsappUrl);
  //   } else {
  //     throw 'Could not launch $whatsappUrl';
  //   }
  // }
}
// floatingActionButton: FloatingActionButton(
// onPressed: (){},
// tooltip: 'Increment',
// child: const Icon(Icons.add),
// ), // This trailing comm
// //       return Center(
//         child: CircularProgressIndicator(),
//       );
//     },
//   ),
// );
//   }
// }
