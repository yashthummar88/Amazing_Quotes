import 'package:amazing_quotes/screens/quotes_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

InkWell getContainer({
  required BuildContext context,
  required String title,
  required String image,
  required String type,
  required String name,
}) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return QuotesScreen(name: name, type: type);
          },
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.135,
      width: MediaQuery.of(context).size.width * 0.42,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(offset: Offset(1, 1), blurRadius: 5),
        ],
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 1),
      ),
    ),
  );
}

ListTile getListTile(
    {required String name,
    required String title,
    required Color color,
    required String type,
    required BuildContext context}) {
  return ListTile(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return QuotesScreen(name: title, type: type);
          },
        ),
      );
    },
    leading: CircleAvatar(
      radius: 30,
      backgroundColor: color,
      child: Text(
        name,
        style: TextStyle(fontSize: 28, color: Colors.white),
      ),
    ),
    title: Text(
      title,
      style: TextStyle(),
    ),
    subtitle: Text(
      "Quotes",
      style: TextStyle(color: Colors.black, fontSize: 16),
    ),
  );
}

Divider getDivider() {
  return Divider(
    color: Colors.black.withOpacity(0.5),
    indent: 90,
    endIndent: 10,
  );
}

Container getShaveShareButton(
    {required String title, required IconData icon, required Color color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: color,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          icon,
          size: 30,
          color: Colors.black,
        ),
        SizedBox(height: 6),
        Text(
          title,
        )
      ],
    ),
  );
}

ScaffoldFeatureController getSnackBar({
  required BuildContext context,
  required String text,
  required double size,
  required double width,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      width: width,
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: size),
      ),
    ),
  );
}
