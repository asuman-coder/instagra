import 'package:flutter/material.dart';
import 'package:instagra/shared/header.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(
        context,
        strTitle: 'Notifications',
      ),
    );
  }
}
