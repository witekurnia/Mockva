import 'package:flutter/material.dart';
import 'package:mockva/network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  Network network = Network();
  bool showSpinner = false;
  AnimationController? controller;
  Animation? animation;
  String username = '';
  // USER050907
  String password = '';
  // x3jitly
  String sessionId = '';
  String accountId = '';
  String name = '';
  double balance = 0;
  String sessionStatus = '';

  Future setPreference() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('id', sessionId);
    await pref.setString('accountId', accountId);
    await pref.setString('name', name);
    await pref.setString('username', username);
    await pref.setDouble('balance', balance);
    await pref.setString('sessionStatus', sessionStatus);
    setState(() {});
  }

  Future getPreferences() async {
    final pref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller!);
    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPreferences(),
      builder: (context, _) => Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TypewriterAnimatedTextKit(
                      speed: const Duration(milliseconds: 150),
                      text: const ['Mockva Mobile'],
                      textStyle: const TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    TextField(
                      onChanged: (value) {
                        username = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'username',
                        hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextField(
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'password',
                        hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.grey.shade600),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 15,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () async {
                        try {
                          setState(() {
                            showSpinner = true;
                          });
                          final login =
                              await network.loginAuth(username, password);
                          sessionId = login['id'];
                          accountId = login['accountId'];
                          sessionStatus = login['sessionStatus'];
                          if (login['sessionStatus'] == "ACTIVE") {
                            final accountDetail = await network.accountDetail(
                                sessionId, accountId);
                            name = accountDetail['name'];
                            username = accountDetail['username'];
                            balance = accountDetail['balance'];
                            setPreference();

                            final history = await network.accountHistory(
                                accountId, sessionId);
                            Navigator.pushReplacementNamed(context, 'menu');
                            setState(() {
                              showSpinner = true;
                            });
                          } else {}
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
