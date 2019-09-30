import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'member_page/member_pages.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: MemberPages()
    );
  }

}


