import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unmei_fl/presentation/page/account_page.dart';

appBar(BuildContext context, {String label = "PAGE"}) => AppBar(
  leading: Container(
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
      border: Border.all(width: 1),
      borderRadius: BorderRadius.circular(50),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage())),
        child: SvgPicture.asset("assets/icons/user.svg"),
      ),
    ),
  ),
  title: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: TextStyle(fontSize: 32, color: Colors.black)),
      Icon(Icons.logout, size: 28, color: Colors.black),
    ],
  ),
  elevation: 0,
  centerTitle: true,
);