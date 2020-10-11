import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

setDateTimeFull(String date, int utc) =>
    DateFormat("dd.MM.yyyy, HH:mm:ss").format(DateTime.parse(date).add(Duration(hours: utc)));

setDateTimeYear(String date) =>
    DateFormat("yyyy").format(DateTime.parse(date));

launchURL(String url) async {
  if (await canLaunch(url)) await launch(url);
  else throw 'Could not launch $url';
}
