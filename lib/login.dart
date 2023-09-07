import 'dart:convert';
import 'package:scholarship/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scholarship/firstpage.dart';
import 'package:scholarship/userpage.dart';
import 'package:shared_preferences/shared_preferences.dart';


//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:convert';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:scholarship/config.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:scholarship/firstpage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class login extends StatefulWidget {
//   login({super.key});

//   @override
//   State<login> createState() => _loginState();
// }

// class _loginState extends State<login> {
//   TextEditingController email = new TextEditingController();
//   TextEditingController password = new TextEditingController();
//   bool _isNotValidate = false;
//   late SharedPreferences prefs;

//   @override
//   void initState() {
//     super.initState();
//     initSharedPref();
//   }

//   void initSharedPref() async {
//     prefs = await SharedPreferences.getInstance();
//   }

//   void login() async {
//     final pathurl = baseUrl + "login";
//     if (email.text.isNotEmpty && password.text.isNotEmpty) {
//       var resp = await http.post(Uri.parse(pathurl),
//           headers: {'Content_Type': 'application/json; charset=UTF-8'},
//           body: {"email": email.text, "password": password.text});
//       var jsonres = jsonDecode(resp.body);
//       if (jsonres['loginStatus'] == true) {
//         var myToken = jsonres['token'];
//         prefs.setString('token', myToken);
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => firstpage(token: myToken)));
//       } else {
//         print('some thing is wrong');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         // Wrap the entire content with SingleChildScrollView
//         child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(begin: Alignment.topCenter, colors: [
//               Color.fromARGB(255, 95, 111, 255),
//               Color.fromARGB(255, 154, 137, 254),
//               Color.fromARGB(255, 215, 193, 250),
//             ]),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               SizedBox(height: 50),
//               Padding(
//                 padding: EdgeInsets.only(left: 20, top: 60, bottom: 30),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Text("Login",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 60,
//                           fontFamily: 'Worksans',
//                           fontWeight: FontWeight.w700,
//                         )),
//                     SizedBox(height: 5),
//                     Text(
//                       "Scholarship System",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontFamily: 'WorkSans',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               //กรอบขาว
//               Container(
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 255, 255, 255),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(50),
//                     topRight: Radius.circular(50),
//                   ),
//                 ),
//                 child: Column(children: <Widget>[
//                   SizedBox(height: 60),
//                   Container(
//                     margin: EdgeInsets.all(30),
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color.fromARGB(255, 158, 168, 255),
//                           blurRadius: 10,
//                           offset: Offset(0, 7),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             border: Border(
//                               bottom: BorderSide(color: Colors.grey),
//                             ),
//                           ),
//                           child: TextField(
//                             keyboardType: TextInputType.emailAddress,
//                             controller: email,
//                             decoration: InputDecoration(
//                               hintText: "Email",
//                               hintStyle: TextStyle(color: Colors.grey),
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             border: Border(
//                               bottom: BorderSide(color: Colors.grey),
//                             ),
//                           ),
//                           child: TextField(
//                             keyboardType: TextInputType.emailAddress,
//                             controller: password,
//                             obscureText: true,
//                             decoration: InputDecoration(
//                               hintText: "Password",
//                               hintStyle: TextStyle(color: Colors.grey),
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       login();
//                     },
//                     child: Container(
//                       height: 60,
//                       width: 250,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(30)),
//                         color: Color.fromARGB(255, 111, 125, 249),
//                       ),
//                       child: Center(
//                         child: Text("Login"),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                     child: Container(
//                       child: Center(
//                         child: Text(
//                           "OR",
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Column(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: [
//                     SizedBox(
//                       height: 50,
//                       width: 250,
//                       child: OutlinedButton.icon(
//                         icon: Image(image: AssetImage("lib/images/google.png"),width: 20),
//                         onPressed: (){}, 
//                         label: Text("Sign in with Google",
//                         style: TextStyle(
//                           color: Colors.black
//                         ),)),
//                     )
//                    ],
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       RichText(
//                         text: TextSpan(
//                           children: [
//                             TextSpan(
//                               text: "Don't have an account?",
//                               style: TextStyle(
//                                 color: const Color.fromARGB(255, 0, 0, 0),
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 16.0,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           // Navigator.push(context, MaterialPageRoute(builder: (context) => register()));
//                         },
//                         child: Text.rich(
//                           TextSpan(
//                             text: "Sign up",
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 15)
//                 ]),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




class login extends StatefulWidget {
  login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool _isNotValidate = false;
  late SharedPreferences prefs;
  
  @override
  void initState(){
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void login() async {
    final pathurl = baseUrl+"login";
    if(email.text.isNotEmpty && password.text.isNotEmpty){
      var resp = await http.post(Uri.parse(pathurl),
        headers: {'Content_Type':'application/json; charset=UTF-8'},
        body: {
          "email": email.text,
          "password" : password.text
        }
      );
      var jsonres = jsonDecode(resp.body);
      if(jsonres['loginStatus'] == true){
        var myToken = jsonres['token'];
        prefs.setString('token', myToken);
        Navigator.push(context, MaterialPageRoute(builder: (context) => firstpage(token: myToken)));
      }else{
        print('some thing is wrong');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 60,),
            Text('Email'),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              decoration: const InputDecoration(
                hintText: "email",
              ),
            ),

            SizedBox(height: 10,),
            Text('passwords'),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: password,
              decoration: const InputDecoration(
                hintText: "password",
              ),
            ),

            SizedBox(height: 40,),
            TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.blueAccent,
                ),
                onPressed: () {
                  login();
                },
                child: Text('Login'),
              )
          ],
        ),
        ),
        
    );
  }
}