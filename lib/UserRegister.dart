import 'package:campus_app/Login_Page.dart';
import 'package:campus_app/function/Registerdb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserRegister extends StatefulWidget {
  UserRegister({required this.user});
  final User user;

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  String dropdownvalue = 'Male';
  String dropdownbalues = 'Student';
  var items = [
    'Male',
    'Female',
  ];
  var position = ['Student', 'Visitor', 'Parent'];
  final _formKey = GlobalKey<FormState>();
  late bool isPasswordTextField = true;
  bool showPassword = true;
  final fullnames = TextEditingController();
  final phoneNumber = TextEditingController();
  final emailaddress = TextEditingController();
  final passwordcontroller = TextEditingController();
  final genderController = TextEditingController();
  final positionController = TextEditingController();
  // get textInputDecoration => null;
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    // var textInputDecoration;
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        leading: Column(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.backspace),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: CupertinoPageScaffold(
          backgroundColor: CupertinoColors.systemPurple,
          //CupertinoColors.secondarySystemFill,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/imagesp.png'),
                    radius: 60,
                  ),
                ),

                // SizedBox(
                //   height: 20,
                // ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            controller: fullnames,
                            decoration: InputDecoration(
                              labelText: 'FullName',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            // onChanged: (val) {
                            //   setState(() {
                            //     email = val;
                            //   });
                            // },
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return null;
                              } else {
                                return 'Required Fullname';
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        DropdownButton(
                            isExpanded: true,
                            hint: Text('Select type '),
                            value: dropdownvalue,
                            icon: Icon(Icons.keyboard_arrow_down),
                            style: TextStyle(
                                color: Colors.black26,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                                genderController.text = newValue;
                              });
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        DropdownButton(
                            isExpanded: true,
                            hint: Text('Select type '),
                            value: dropdownbalues,
                            icon: Icon(Icons.keyboard_arrow_down),
                            style: TextStyle(
                                color: Colors.black26,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            items: position.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownbalues = newValue!;
                                positionController.text = newValue;
                              });
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            controller: phoneNumber,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            // onChanged: (val) {
                            //   setState(() {
                            //     email = val;
                            //   });
                            // },
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return null;
                              } else {
                                return 'Required phone Number';
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailaddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            // onChanged: (val) {
                            //   setState(() {
                            //     email = val;
                            //   });
                            // },
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return null;
                              } else {
                                return 'Required email';
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: passwordcontroller,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).primaryColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              icon: Icon(Icons.remove_red_eye),
                            ),
                          ),
                          // onChanged: (val) {
                          //   setState(() {
                          //     password = val;
                          //   });
                          // },
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            }
                            return "password required";
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoButton(
                        color: Colors.deepPurple,
                        child: const FittedBox(
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState != null) {
                              if (_formKey.currentState!.validate()) {
                                SaveUserData();
                              }
                            }
                          });
                        })),
                SizedBox(
                  height: 10,
                ),
                // Center(
                //   child: Text.rich(
                //     TextSpan(
                //       text: 'Already have an account?',
                //       style: TextStyle(color: Colors.white70, fontSize: 14),
                //       children: <TextSpan>[
                //         TextSpan(
                //             text: "Login here",
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 decoration: TextDecoration.underline),
                //             recognizer: TapGestureRecognizer()
                //               ..onTap = () {
                //                 Navigator.pushReplacement(
                //                     context,
                //                     MaterialPageRoute(
                //                         builder: (context) => LoginScreen(
                //                               user: widget.user,
                //                             )));
                //               }),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future SaveUserData() async {
    try {
      final UserData = UserReg(
        uid: widget.user.uid,
        fullname: fullnames.text.toUpperCase(),
        gender: genderController.text.toUpperCase(),
        phoneNo: phoneNumber.text,
        position: positionController.text.toUpperCase(),
        email: emailaddress.text.toLowerCase(),
        password: passwordcontroller.text,
      );
      await firestore
          .collection('UserAccount')
          .doc(UserData.uid)
          .set(UserData.toJson());
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Savig Data'),
                content: Text('Account was created successfully'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok')),
                ],
              ));
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                  //user: widget.user,
                  )));
    } on FirebaseAuthException catch (e) {
      setState(() {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(''),
                  content: Text('Registration not Successfull'),
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
}
