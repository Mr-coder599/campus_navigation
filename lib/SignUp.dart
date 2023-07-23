import 'package:campus_app/Login_Page.dart';
import 'package:campus_app/UserRegister.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({Key? key}) : super(key: key);

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  final emailaddress = TextEditingController();
  final password = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late final User user;
  late bool isPasswordTextField = true;
  bool showPassword = true;
  String emails = '';
  String pass = '';
  GlobalKey _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Authentication',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        //CupertinoColors.secondarySystemFill,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
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
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            // validator: _requiredValidator,
                            controller: emailaddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                              label: Text('EmailAddress'),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) =>
                                val!.isEmpty ? 'Required emailAddress' : null,
                            onChanged: (val) {
                              setState(() => emails = val);
                            }),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                            //  validator: _requiredValidator,
                            obscureText:
                                isPasswordTextField ? showPassword : true,
                            controller: password,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                icon: Icon(Icons.remove_red_eye),
                              ),
                              border: OutlineInputBorder(),
                              label: Text('Password'),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) =>
                                val!.isEmpty ? 'Required password' : null,
                            onChanged: (val) {
                              setState(() => pass = val);
                            }),
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
                            'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState != null) {
                            // if (_formKey.currentState!.validate()) {
                            try {
                              final credential =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: emailaddress.text,
                                      password: password.text);
                              final user = credential.user;
                              if (user != null) {
                                //    CircularProgressIndicator();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => UserRegister(user: user)));
                              }
                            } on FirebaseAuthException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.message ?? '')));
                            }
                          }
                        }
                        //}
                        )),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: Colors.green, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Login here",
                            style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.none),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen(
                                            // user: user,
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
}
