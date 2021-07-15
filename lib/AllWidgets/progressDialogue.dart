
import 'package:flutter/material.dart';

class ProgressDialogue extends StatelessWidget
{
  String message;
  ProgressDialogue({required this.message});
  @override
  Widget build(BuildContext context)
  {
    return Dialog(
      backgroundColor: Colors.blue,
      child: Container(
        margin: EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
               SizedBox(width:8.0,),
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
              SizedBox(width:25.0,),
              Text(
              message,
              style: TextStyle(color: Colors.black,fontSize: 10.0,),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
