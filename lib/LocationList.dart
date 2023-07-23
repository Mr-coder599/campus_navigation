import 'package:campus_app/Dashboard.dart';
import 'package:campus_app/function/locationdb.dart';
import 'package:campus_app/showlocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LocationList extends StatefulWidget {
  LocationList({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  String locationname = "";
  String longitude = "";
  String latitude = "";
  //controller
  final lnameController = TextEditingController();
  final longitudeController = TextEditingController();
  final LatitudeController = TextEditingController();
  //end of controller
  final _formKey = new GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Save Location'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UserDashboard(user: widget.user)));
              });
            },
            icon: Icon(
              Icons.backspace_rounded,
              size: 20,
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.green,
        //  centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/location.png'),
                    radius: 70,
                  ),
                ),

                // SizedBox(
                //   height: 20,
                // ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Enter valid Longitude and Latitude value',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Taoma, times New Romans'),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    //colors..white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            // validator: _requiredValidator,
                            controller: lnameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.near_me),
                              border: OutlineInputBorder(),
                              label: Text('Name of location'),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) =>
                                val!.isEmpty ? 'Required location Name' : null,
                            onChanged: (val) {
                              setState(() => locationname = val);
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            // validator: _requiredValidator,
                            controller: longitudeController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_on),
                              border: OutlineInputBorder(),
                              label: Text('Enter longitude value...'),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) =>
                                val!.isEmpty ? 'Required longitude' : null,
                            onChanged: (val) {
                              setState(() => longitude = val);
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            // validator: _requiredValidator,
                            controller: LatitudeController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_city_rounded),
                              border: OutlineInputBorder(),
                              label: Text('Enter latitude value...'),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) =>
                                val!.isEmpty ? 'latitude value Required' : null,
                            onChanged: (val) {
                              setState(() => latitude = val);
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              //  setState(() async {
                              if (_formKey.currentState != null) {
                                if (_formKey.currentState!.validate()) {
                                  SaveLocation();
                                }
                              }
                              //   });
                            },
                            style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 20.0)),
                              elevation: MaterialStateProperty.all<double>(0.0),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                              //   shadowColor: MaterialStateProperty.all<Color>(Colors.amberAccent),
                              minimumSize:
                                  MaterialStateProperty.all(Size(50, 50)),
                              fixedSize:
                                  MaterialStateProperty.all(Size(300, 50)),
                              side: MaterialStateProperty.all(
                                  BorderSide(color: Colors.white)),
                            ),
                            child: Text(
                              'Register'
                              ' Locations',
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Perform an action on FAB click
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(100, 100, 0, 0),
            items: [
              PopupMenuItem(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowLocations(
                                    user: widget.user,
                                  )));
                    });
                  },
                  child: Text(
                    'Show locations',
                  ),
                ),
                value: 'location',
              ),
              PopupMenuItem(
                child: Text('Item 2'),
                value: 'item2',
              ),
            ],
            elevation: 8.0,
          ).then((value) {
            if (value == 'item1') {
              // Handle Item 1 selection
            } else if (value == 'item2') {
              // Handle Item 2 selection
            }
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future SaveLocation() async {
    try {
      final locations = locationData(
          uid: widget.user.uid,
          latitude: LatitudeController.text,
          longitude: longitudeController.text,
          lname: lnameController.text);
      await firestore
          .collection('schoollocation')
          .doc(locations.uid)
          .set(locations.toJson());
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Location'),
                content: Text('Location Saved Successfully..'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok')),
                ],
              ));
      Navigator.of(context).pop();
      cleareBoxes();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => UserDashboard(
                    user: widget.user,
                    //user: widget.user,
                  )));
    } on FirebaseAuthException catch (e) {
      setState(() {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(''),
                  content: Text('Registration not '
                      'Successfull'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok'))
                  ],
                ));
      });
    }
  }

  void cleareBoxes() {
    lnameController.clear();
    longitudeController.clear();
    LatitudeController.clear();
  }
}
