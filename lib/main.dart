import 'package:flutter/material.dart';
import 'package:mockva/screens/transfer_page/transfer_confirmation.dart';
import 'package:mockva/screens/transfer_page/transfer_inquiry.dart';
import 'package:mockva/screens/transfer_page/transfer_success.dart';
import 'screens/login_screen.dart';
import 'screens/home_menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: 'login_screen',
      routes: {
        'login_screen': (context) => LoginScreen(),
        'menu': (context) => HomeMenu(),
        'transfer_inquiry': (context) => TransferInquiry(),
        'transfer_confirm': (context) => TransferConfirmation(),
        'transfer_success': (context) => TransferSuccess()
      },
    );
  }
}
