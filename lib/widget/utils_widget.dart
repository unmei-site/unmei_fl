import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';

import '../data.dart';

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