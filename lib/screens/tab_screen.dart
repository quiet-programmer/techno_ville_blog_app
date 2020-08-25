import 'package:flutter/material.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/screens/home.dart';
import 'package:techno_vile_blog/screens/settings.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': Home(),
      'title': 'Categories',
    },
    {
      'page': SettingsScreen(),
      'title': 'Your Favorite',
    },
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/techno_vile.png',
          width: 200.0,
          height: 150.0,
        ),
        centerTitle: true,
        actions: [
          // FlatButton.icon(
          //   onPressed: () async {
          //     await _userAuth.signout();
          //   },
          //   icon: Icon(Icons.person, color: Colors.white),
          //   label: Text(
          //     "Sign out",
          //     style: TextStyle(
          //       color: Colors.white,
          //     ),
          //   ),
          // )
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: subColor,
        selectedItemColor: Colors.white,
        // unselectedItemColor: realColor,
        unselectedIconTheme: IconThemeData(
          color: Colors.white,
        ),
        unselectedLabelStyle: TextStyle(
          color: subColor,
        ),
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Settings"),
          )
        ],
      ),
    );
  }
}
