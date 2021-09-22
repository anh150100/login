
import 'package:api_login/controller/auth_contrller.dart';
import 'package:api_login/models/response_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
            },
            child: const Text("Log Out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            const SizedBox(height: 30,),
            FutureBuilder<ResponseUserInfo>(
              future:context.read<AuthController>().fetchUserInfoModel(),
              builder: (context,snapshot) {
                if (snapshot.hasData){
                  var user = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const SizedBox(
                  height:9,
                  ),
                  Row(
                    children: [
                      const Text("Full Name: "),
                      Padding(
                        padding: const EdgeInsets.only(right:15.0),
                        child: Text(user!.data!.name!),),
                    ],
                  ),
                    Row(
                      children: [
                        Text("Email: "),
                        Padding(
                          padding: const EdgeInsets.only(right:15.0),
                          child: Text(user.data!.email!),),
                      ],
                    ),
                ],);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}



