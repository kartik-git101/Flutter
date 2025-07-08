import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          title: Text("Contact"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/daylight-environment-forest-459225.jpg'),
                radius: 50,
              ),
              Text('Ethan Carter', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              Text('Software Engineer', style: TextStyle(fontSize: 15),),
              ListTile(leading: Icon(Icons.call), title: Text('1234567890'),),
              ListTile(leading:Icon(Icons.mail_outline_sharp) ,title: Text('ethancarter@example.com'),)
            ],
          ),
        ),
      ),
    );
  }
}
