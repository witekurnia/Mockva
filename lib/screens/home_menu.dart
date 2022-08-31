import 'package:flutter/material.dart';
import 'package:mockva/network.dart';
import 'package:mockva/screens/account_screen.dart';
import 'package:mockva/screens/history_screen.dart';
import 'package:mockva/screens/home_screen.dart';
import 'package:mockva/screens/transfer_page/transfer_inquiry.dart';
import 'login_screen.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  Network network = Network();
  LoginScreen login = LoginScreen();
  int menuIndex = 0;

  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
    3: GlobalKey<NavigatorState>(),
    4: GlobalKey<NavigatorState>(),
  };
  List<Widget> widgetOption = <Widget>[
    const HomeScreen(),
    const TransferInquiry(),
    const HistoryScreen(),
    AccountScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      menuIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(menuIndex),
      bottomNavigationBar: BottomNavigationBar(
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Transfer',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Account',
          ),
        ],
        currentIndex: menuIndex,
        selectedItemColor: Colors.white,
        onTap: onItemTapped,
        backgroundColor: Colors.grey.shade800,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  buildNavigator() {
    return Navigator(
      key: navigatorKeys[menuIndex],
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) => widgetOption.elementAt(menuIndex),
        );
      },
    );
  }

  Widget _buildContent(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return TransferInquiry();
      case 2:
        return HistoryScreen();
      case 3:
        return AccountScreen();
      default:
        return HomeScreen();
    }
  }
}
