import 'package:flutter/material.dart';

import 'login_page/login_pages.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: Container(
        child: LoginPages(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
