import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

setDateTimeFull(String date, int utc) => DateFormat("dd.MM.yyyy, HH:mm:ss")
    .format(DateTime.parse(date).add(Duration(hours: utc)));

setDateTimeYear(String date) => DateFormat("yyyy").format(DateTime.parse(date));

launchURL(String url) async {
  if (await canLaunch(url))
    await launch(url);
  else
    throw 'Could not launch $url';
}

var fToast = FToast();

showToast(context, String msg, Color color, IconData icon) {
  fToast.init(context);
  fToast.showToast(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            msg,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 2),
  );
}
