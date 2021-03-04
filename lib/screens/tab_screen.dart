import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/provider/theme_provider.dart';
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
    final checkTheme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: checkTheme.isLight ? darkTabLogo() : lightTabLogo(),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              checkTheme.isLight
                  ? FontAwesomeIcons.moon
                  : FontAwesomeIcons.lightbulb,
            ),
            onPressed: () {
              checkTheme.changeTheme();
            },
          ),
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: checkTheme.isLight ? boxColor : backColor,
        selectedItemColor: checkTheme.isLight ? Colors.black : Colors.white,
        // unselectedItemColor: realColor,
        unselectedIconTheme: IconThemeData(
          color: checkTheme.isLight ? Colors.black : Colors.white,
        ),
        unselectedLabelStyle: TextStyle(
          color: subColor,
        ),
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          )
        ],
      ),
    );
  }
}
