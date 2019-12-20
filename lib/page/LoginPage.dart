import 'package:flutter/material.dart';
import 'package:moshi_live/apis/UserApiProvider.dart';
import 'package:moshi_live/bloc/UserBloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle( fontSize: 20.0);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  void startLogin(email, password) {
    userBloc.login(email, password).then((response) {
      print("resultCode: ${response.resultCode}");
      print("token: ${response.token}");
      print("user: ${response.user.toString()}");
      Navigator.pop(context, response);
    }, onError: (error){
      print(error);
    });
  }
  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      controller: emailController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)
          )
      ),
    );
    final passwordField = TextField(
        controller: passwordController,
        obscureText: true,
        style: style,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)
            )
        )
    );
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01a0c7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if(true == emailController.text?.isNotEmpty && true == passwordController.text?.isNotEmpty) {
            startLogin(emailController.text, passwordController.text);
          } else {
            print("Not input");
          }
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 155.0,child: Image.asset("assets/logo.png", fit: BoxFit.contain,),),
              SizedBox(height: 45.0,),
              emailField,
              SizedBox(height: 25.0,),
              passwordField,
              SizedBox(height: 35.0),
              loginButton,
              SizedBox(height: 15.0,)
            ],
          ),
        ),
      ),
    );
  }
}
