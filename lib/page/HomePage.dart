import 'package:flutter/material.dart';
import 'package:moshi_live/bloc/UserBloc.dart';
import 'package:moshi_live/helper/FCMHelper.dart';
import 'package:moshi_live/model/User.dart';
import 'package:moshi_live/model/remote/LoginResponse.dart';
import 'package:moshi_live/page/LoginPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key) {
  }

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserProfile _user;
  FCMHelper fcmHelper = FCMHelper();
  _HomePageState() {
    fcmHelper.init();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(height: 45.0,),
                SizedBox(height: 155.0, child: Image.asset("assets/logo.png", fit: BoxFit.contain,),),
                Text("Hello " + (_user?.firstName ?? "Guest")),
                MaterialButton(
                  elevation: 5.0,
                  color: Color(0xff01a0c7),
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  child: Text('Login'),
                    onPressed: (){
                      _navigateLoginPage(context);
                    },
                  ),
                ]
            )
          )
        )
    );
  }

  void _navigateLoginPage(BuildContext context) async {
    final result = await Navigator.push<LoginResponse>(context, MaterialPageRoute(builder: (context) => LoginPage()));
    if(result.user!=null) {
      setState(() {
        _user = result.user;
      });
    }
    if(result.token!=null) {
      fcmHelper.registerDeviceToken();
    }
  }

}
