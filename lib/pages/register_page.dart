import 'package:flutter/material.dart';
import 'package:shopping/pages/register_page/register_pages.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
      ),
      body: Container(
        child: RegisterPages(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}