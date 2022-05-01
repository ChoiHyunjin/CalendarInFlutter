import 'package:calendar/src/routes/login/widgets/login_widget.dart';
import 'package:calendar/src/routes/main/main.dart';
import 'package:calendar/src/utils/preference.dart';
import 'package:flutter/material.dart';

const users = {
  'user1': '1q2w3e4r',
  'user2': '1q2w3e4r',
};

class LoginRoute extends StatefulWidget {
  const LoginRoute({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  var _error = false;

  void _onLogin(String id, String password) {
    if (users.containsKey(id)) {
      if (users[id] == password) {
        Preference.shared.setId(id);
        Route home = MaterialPageRoute(
            builder: (context) => HomeRoute(title: widget.title));
        Navigator.pushReplacement(context, home);
      } else {
        setState(() {
          _error = true;
        });
      }
    } else {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: LoginWidget(onLogin: _onLogin, error: _error),
        // (String id, String password) => _addSchedule(context)
        padding: const EdgeInsets.fromLTRB(10, 26, 10, 60),
        alignment: Alignment.center,
      ),
    );
  }
}
