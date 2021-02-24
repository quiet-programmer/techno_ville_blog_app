import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techno_vile_blog/custom_theme.dart';
import 'package:techno_vile_blog/provider/theme_provider.dart';
import 'package:techno_vile_blog/screens/welcome.dart';
import 'package:techno_vile_blog/widgets/messaging_widget.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    MessagingWidget();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MessagingWidget();
  }

  @override
  Widget build(BuildContext context) {
    final checkTheme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Techno Ville",
      theme: checkTheme.isLight ? buildLightTheme() : buildDarkTheme(),
      home: WelcomeScreen(),
    );
  }
}
