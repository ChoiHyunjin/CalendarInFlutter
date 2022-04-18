import 'package:calendar/src/routes/login/widgets/titled_textInput.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key, required this.onLogin, required this.error})
      : super(key: key);
  final Function(String id, String password) onLogin;
  final bool error;

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  var _id = '';
  var _password = '';

  void _onChangeID(String id) {
    _id = id;
  }

  void _onChangePassword(String password) {
    _password = password;
  }

  void _onPressLogin(TapUpDetails detail) {
    widget.onLogin(_id, _password);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          TitledTitleInput(
            title: "ID",
            onChangeText: _onChangeID,
            hintText: 'ID를 입력하세요',
          ),
          TitledTitleInput(
            title: "비밀번호",
            onChangeText: _onChangePassword,
            obscureText: true,
            hintText: '비밀번호를 입력하세요',
          ),
          if (widget.error)
            Text('ID와 비밀번호를 확인해주세요.',
                style: TextStyle(color: Colors.redAccent)),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: GestureDetector(
              child: Container(
                child: const Text(
                  "로그인",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                width: double.infinity,
              ),
              onTapUp: _onPressLogin,
            ),
          )
        ],
      ),
    );
  }
}
