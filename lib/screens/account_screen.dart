import 'package:flutter/material.dart';
import 'package:mockva/network.dart';
import 'package:mockva/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Network network = Network();

  String? sessionId;
  String? sessionStatus;
  String? sessionRemove;

  Future getPreferences() async {
    final pref = await SharedPreferences.getInstance();
    sessionId = pref.getString('id');
    sessionStatus = pref.getString('sessionStatus');
  }

  Future deleteSession() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.getString('sessionStatus') != null) {
      return pref.remove('sessionStatus');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPreferences(),
      builder: (context, _) => Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Account'),
        ),
        body: SafeArea(
          child: Center(
            child: OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.shade600),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  ),
                ),
                onPressed: () {
                  deleteSession();
                  network.logOut(sessionId);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                )),
          ),
        ),
      ),
    );
  }
}
