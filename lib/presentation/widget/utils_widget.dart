import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

onBoxShim({
  double? height,
  double? width,
  EdgeInsets margin = const EdgeInsets.all(0),
  double radius = 0,
  Color bodyColor = const Color(0xFFB3B3B3),
  Color color = const Color(0xFFDBDBDB),
}) => Shimmer.fromColors(
  baseColor: bodyColor,
  highlightColor: color,
  child: Container(
    margin: margin,
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
    ),
  ),
);
