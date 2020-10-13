import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/screens/welcome.dart';
import 'package:techno_vile_blog/services/auth.dart';
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
    return MultiProvider(
      providers: [
        StreamProvider.value(
          value: AuthServices().user,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Techno Ville",
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            color: subColor,
            textTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}
