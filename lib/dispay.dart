import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Display extends StatefulWidget {
  var displayform;
  Display({super.key, this.displayform});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [],
      ),
    );
  }

  displayData(value) {
    var data = jsonDecode(value);
    var accountName = data["accountName"];
    var accountNumber = data["accountNumber"];
    var bankCode = data["bankCode"];
  }
}
