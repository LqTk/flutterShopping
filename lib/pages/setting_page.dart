import 'package:flutter/material.dart';

import 'setting_page/setting_pages.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: SettingPages(),
    );
  }
}
