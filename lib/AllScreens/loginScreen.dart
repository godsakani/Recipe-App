import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/AllScreens/mainscreen.dart';
import 'package:recipe_app/AllScreens/registrationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/AllWidgets/progressDialogue.dart';

import '../main.dart';

class LoginScreen extends StatelessWidget
{
  static const String idScreen = "login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 85.0,),
              Image(
                image: AssetImage("images/pngaaa.com-206500.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              
              
              SizedBox(height: 1.0,),
              Text(
                  "Customer Login",
                   style: TextStyle(
                     fontSize: 24.0,
                     fontFamily: "Brand Bold",
                   ),
                   textAlign: TextAlign.center,
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),

                    SizedBox(height: 1.0,),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      child: Container(
                        height: 30,
                        width: 400,
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Brand Bold",
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: () {
                        if(!emailTextEditingController.text.contains("@"))
                        {
                          displayToastMessage("email must contain @ character", context);
                        }
                        else if(passwordTextEditingController.text.isEmpty)
                        {
                          displayToastMessage("password required", context);
                        }
                        else
                          {
                            loginUser(context);
                          }
                      },
                    ),
                  ],
                ),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Do not have and Account? Register Here",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginUser(BuildContext context) async
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)
      {
       return ProgressDialogue(message: "Authenticating Please wait.....",);
      }
    );

    final  firebaseUser = (await _firebaseAuth
        .signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text)
        .catchError((errMsg){
          Navigator.pop(context);
           displayToastMessage("Error: " + errMsg.toString() , context);
    })).user;

    if(firebaseUser != null)//user created
        {
      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap){
        if(snap.value !=null){
          Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
          displayToastMessage("Login Successful", context);

        }
        else
          {
            Navigator.pop(context);
            _firebaseAuth.signOut();
            displayToastMessage("Account Does Not Exist. Please create new Account", context);
          }
      });

    }
    else
    {
      Navigator.pop(context);
      displayToastMessage("Error occured, can not signin", context);
    }
  }
}
