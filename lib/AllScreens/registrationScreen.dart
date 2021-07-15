import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe_app/AllScreens/loginScreen.dart';
import 'package:recipe_app/AllScreens/mainscreen.dart';
import 'package:recipe_app/AllWidgets/progressDialogue.dart';
import 'package:recipe_app/main.dart';

class RegistrationScreen extends StatelessWidget
{
  static const String idScreen = "register";
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
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
              SizedBox(height: 65.0,),
              Image(
                image: AssetImage("images/pngaaa.com-206500.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),


              SizedBox(height: 1.0,),
              Text(
                "Customer Registration",
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
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 16.0,
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
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone",
                        labelStyle: TextStyle(
                          fontSize: 16.0,
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
                          fontSize: 16.0,
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
                          "Create Account",
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
                        if(nameTextEditingController.text.length < 5){
                            displayToastMessage("name must be 5 characters", context);
                        }
                        else if(!emailTextEditingController.text.contains("@"))
                          {
                            displayToastMessage("email must contain @ character", context);
                          }
                        else if(phoneTextEditingController.text.isEmpty)
                        {
                          displayToastMessage("phone Number is required", context);
                        }
                        else if(passwordTextEditingController.text.length < 7)
                        {
                          displayToastMessage("password must be atleast 7 characters", context);
                        }
                        else
                          {
                            registerNewUser(context);
                          }
                      },
                    ),
                  ],
                ),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Already have and Account? Login",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialogue(message: "Registering Please wait.....",);
        }
    );

    final  firebaseUser = (await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text)
        .catchError((errMsg){
           Navigator.pop(context);
          displayToastMessage("Error: " + errMsg.toString() , context);
    })).user;
    if(firebaseUser != null)//user created
      {
        //save info to database

      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "password": passwordTextEditingController.text.trim(),
      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage("Account Created Successful", context);
      Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
      }
    else
      {
        Navigator.pop(context);
        displayToastMessage("New user Account has not yet been Created", context);
      }
  }
}

displayToastMessage(String message, BuildContext context)
{
  Fluttertoast.showToast(msg: message );
}
