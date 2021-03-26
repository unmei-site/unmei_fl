import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

pageHeader(String text, context) => Container(
      margin: const EdgeInsets.only(top: 20),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );

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
