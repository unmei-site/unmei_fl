import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data.dart';

setDateTimeFull(String date, int utc) =>
    DateFormat("dd.MM.yyyy, HH:mm:ss").format(DateTime.parse(date).add(Duration(hours: utc)));

setDateTimeYear(String date) =>
    DateFormat("yyyy").format(DateTime.parse(date));

launchURL(String url) async {
  if (await canLaunch(url)) await launch(url);
  else throw 'Could not launch $url';
}

pageHeader(String text, Color color) => Container(
  margin: const EdgeInsets.only(top: 20),
  child: Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: color,
      fontWeight: FontWeight.w500,
      fontSize: 42,
    ),
  ),
);

onThemeON(BuildContext context, Color dark, Color light) =>
    context.watch<DataApp>().changeThemeData ? dark : light;

onShim(double height, double width, EdgeInsets margin) => Shimmer.fromColors(
  baseColor: Colors.grey,
  highlightColor: Colors.grey[200],
  child: Container(
    margin: margin,
    height: height,
    width: width,
    color: Colors.white,
  ),
);
