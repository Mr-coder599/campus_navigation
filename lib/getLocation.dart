import 'package:campus_app/Dashboard.dart';
import 'package:campus_app/NavigationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  final User user;
  const LocationPage({Key? key, required this.user}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          // centerTitle: true,
          elevation: 0,
          title: Text(
            'Location',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserDashboard(user: widget.user)));
            },
            icon: Icon(
              Icons.backspace_rounded,
              size: 20,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formkey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/location.png'),
                      radius: 60,
                    ),
                    Text(
                      'Enter your location',
                      style: TextStyle(
                          fontSize: 20, fontFamily: 'Times New Roman'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                        controller: latController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'latitude',
                        ),
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Latitude value Required';
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: lngController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'longitute',
                        ),
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Longitude value Required';
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState != null) {
                            if (_formkey.currentState!.validate()) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NavigationScreen(
                                      double.parse(lngController.text),
                                      double.parse(latController.text),
                                      widget.user)));
                            }
                          }
                        },
                        child: Text(
                          'Get Directions',
                          style: TextStyle(
                              fontFamily: 'Tim'
                                  'es New Roman'),
                        ),
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 20.0)),
                          elevation: MaterialStateProperty.all<double>(0.0),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
