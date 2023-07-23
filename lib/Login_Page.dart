import 'package:campus_app/Dashboard.dart';
import 'package:campus_app/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  // required this.user,;
  //final User user;
  // final User user;
  final _formKey = new GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailaddress = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //  user = fuser;
    // late final User user;

    return Scaffold(
      // appBar: AppBar(
      //     // title: Text('Login'),
      //     // elevation: 0,
      //     backgroundColor: CupertinoColors.systemPurple,
      //     ),
      body: SingleChildScrollView(
        child: CupertinoPageScaffold(
          // backgroundColor: CupertinoColors.systemPurple,
          //CupertinoColors.secondarySystemFill,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120,
                ),
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CupertinoTextFormFieldRow(
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            }
                            return "EmailAddress required";
                          },
                          controller: emailaddress,
                          prefix:
                              const Center(child: Icon(CupertinoIcons.mail)),
                          placeholder: 'Email',
                          placeholderStyle: TextStyle(
                              color: CupertinoColors.darkBackgroundGray
                                  .withOpacity(.7)),
                          keyboardType: TextInputType.emailAddress,
                          keyboardAppearance: Brightness.dark,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: CupertinoColors.separator))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CupertinoTextFormFieldRow(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: CupertinoColors.separator,
                            ),
                          )),
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            }
                            return "password required";
                          },
                          controller: password,
                          prefix:
                              const Center(child: Icon(CupertinoIcons.lock)),
                          obscureText: true,
                          placeholder: 'Password',
                          placeholderStyle: TextStyle(
                              color: CupertinoColors.darkBackgroundGray
                                  .withOpacity(.7)),
                          keyboardType: TextInputType.emailAddress,
                          keyboardAppearance: Brightness.dark,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        forgotPassword(context),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),

                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoButton(
                        color: Colors.green,
                        child: const FittedBox(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.validate()) {
                              try {
                                final UserCredential credential =
                                    await _auth.signInWithEmailAndPassword(
                                  email: emailaddress.text,
                                  password: password.text,
                                );
                                CircularProgressIndicator();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Login Successfully')));
                                final user = credential.user;
                                if (user != null) {
                                  // Navigator.of(context)
                                  //     .push(MaterialPageRoute(
                                  //     builder: (context) =>
                                  //     )));
                                  CircularProgressIndicator();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => UserDashboard(
                                            user: user,
                                          )));
                                }
                              } on FirebaseAuthException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.message ?? '')));
                              }
                            }
                          }
                        })),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Dont have an account?',
                      style: TextStyle(color: Colors.green, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Register here",
                            style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserSignUp(
                                            //  user: user,
                                            // user: user,
                                            )));
                              }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //forgotten password widget for agent
  Widget forgotPassword(BuildContext context) {
    final resetpasswordcontroller = TextEditingController();
    final _formKey = new GlobalKey<FormState>();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text(
          'forgot Password',
          style: TextStyle(
            color: Colors.green,
          ),
          textAlign: TextAlign.right,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text('Forgotten Password'),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // SizedBox(
                          //   height: 15.0,
                          // ),
                          Text('link will be sent to your email'),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              controller: resetpasswordcontroller,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'enter your emailaddress',
                                hoverColor: Colors.green,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              validator: (val) {
                                if (val!.isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Email Required';
                                }
                              }),
                          SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState != null) {
                                if (_formKey.currentState!.validate()) {
                                  // SaveUserData();
                                  _auth
                                      .sendPasswordResetEmail(
                                          email: resetpasswordcontroller.text)
                                      .then((value) =>
                                          Navigator.of(context).pop());
                                }
                              }
                            },
                            child: Text('Reset Password'),
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
                                  MaterialStateProperty.all(Size(320, 50)),
                              side: MaterialStateProperty.all(
                                  BorderSide(color: Colors.orange)),
                            ),
                          ),
                        ],
                      ),
                    ));
              });
        },
      ),
    );
  }
}
