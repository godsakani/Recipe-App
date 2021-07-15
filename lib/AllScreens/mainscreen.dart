import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/AllScreens/loginScreen.dart';

class MainScreen extends StatefulWidget
{
  static const String idScreen = "MainScreen";
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recipe Home Menu',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: <Widget> [
          Container(
            height: MediaQuery.of(context).size.height/5,
            width: MediaQuery.of(context).size.height,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 Padding(
                   padding: EdgeInsets.only(bottom: 11.0),
                   child: Text(
                     "Welcome To Your Recipe App",
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 20.0,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                 )
              ],
            ),
          ),
          Expanded(
              child:Padding(
                padding: EdgeInsets.all(25.0),
                child: ListView(
                  children:<Widget> [
                    SizedBox(height: 10.0,),
                    Image(
                      image: AssetImage("images/pngaaa.com-206512.png"),
                      width: 100.0,
                      height: 50.0,
                      alignment: Alignment.topLeft,
                    ),
                    ListTile(
                      title: Text(
                          "Salad",
                    style:TextStyle(
                      fontSize: 20.0,
                    )
                       ),
                      trailing: Text("6000 FCFA"),
                    ),
                    SizedBox(height: 10.0,),
                    Image(
                      image: AssetImage("images/pngaaa.com-206513.png"),
                      width: 100.0,
                      height: 50.0,
                      alignment: Alignment.topLeft,
                    ),
                    ListTile(
                      title: Text(
                          "Cocktails",
                          style:TextStyle(
                            fontSize: 20.0,
                          )
                      ),
                      trailing: Text("5000 FCFA"),
                    ),
                    SizedBox(height: 10.0,),
                    Image(
                      image: AssetImage("images/pngaaa.com-206500.png"),
                      width: 100.0,
                      height: 50.0,
                      alignment: Alignment.topLeft,
                    ),
                    ListTile(
                      title: Text(
                          "Chewables",
                          style:TextStyle(
                            fontSize: 20.0,
                          )
                      ),
                      trailing: Text("4000 FCFA"),
                    ),
                    GestureDetector(
                      onTap: ()
                      {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                      },
                     child: ListTile(
                      title: Text(
                          "Logout",
                            style:TextStyle(
                            fontSize: 20.0,
                          )
                      ),
                    ),
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );

  }
}
