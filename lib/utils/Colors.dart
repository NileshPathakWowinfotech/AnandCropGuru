

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

 Color fromHex(String hexString) {
final buffer = StringBuffer();
if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
buffer.write(hexString.replaceFirst('#', ''));
return Color(int.parse(buffer.toString(), radix: 16));
}

 const kWhite = Colors.white;
 Color newHomeColor = fromHex('#22A45D');

Color kblack = Colors.black;
Color kblue = Colors.blueAccent;
Color kgrey = Colors.grey;
HexColor kprimarygreen = HexColor("#2A5102");
HexColor indigo = HexColor("#3B5FA3");
HexColor ksearchBackground = HexColor("#5A810E");
HexColor lblack = HexColor("#7F7F7F");
HexColor klgreen = HexColor("#416908");
HexColor klgreen3 = HexColor("#C2E7CF");
HexColor klorange = HexColor("#FF9800");
HexColor kpareatgreen = HexColor("#9CC455");
HexColor klgreen2 = HexColor("#6fB634");
HexColor lgreen2 = HexColor("#C7E4D1");
HexColor kgreen = HexColor("#9CC455");
HexColor klblue = HexColor("#03334F");
HexColor ksoilColor = HexColor("#E9E7E7");
HexColor kpink = HexColor("#FFCDD2");
HexColor pgrey = HexColor("#F8F7F7");
HexColor lgreen = HexColor("#6FB634");
HexColor pgreen = HexColor("#47964A");
HexColor lblue = HexColor("#0376C6");
HexColor kdarkblue = HexColor("#053BC1");
HexColor dblue = HexColor("#0D4B6f");
HexColor gridio = HexColor("#053BC1");
HexColor kdarkred = HexColor("#A21616");
HexColor kgreyy = HexColor("#9E9E9E");
HexColor kbordergrey = HexColor("#EEEEEE");
HexColor GreenA100 = HexColor("#D1F4B6");
HexColor lightgreen = HexColor("#D1F4B6");
HexColor lgery = HexColor("#C2E7CF");
HexColor sgreen = HexColor("#E8F2E8");
HexColor mblue = HexColor("#053BC1");
HexColor kpagebackgroundcolor = HexColor("#F4F2F2");
HexColor kwBorder = HexColor("#83ACCC");
HexColor lgrey = HexColor("#909290");

//Colors added by Saurabh Rao

Color update_profile_textfield_border = Colors.grey;
Color hint_text_color = Colors.grey;
Color green100 = fromHex('#C2E7CF');
Color green700 = fromHex('#43845A');
Color greenTextColor = fromHex('#47964A');
Color lightGreenTextColor = fromHex('#6FB634');
Color lightGrey = fromHex('#F6F4F4');
Color lightGreenButton = fromHex('#E8F2E8');
Color tealTextColor = fromHex('#2291A0');
Color textFieldColor = fromHex('#EDE9E9');
Color blueTextColor = fromHex('#053BC1');
