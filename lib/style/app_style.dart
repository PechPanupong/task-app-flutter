import 'package:flutter/material.dart';

import '../models/task.dart';

class AppStyle {
  static const Color ligthSuccess = Color.fromRGBO(192, 248, 217, 1);
  static const Color success = Color(0xff00DD64);
  static const Color error = Color(0xffFF4D4D);
  static const Color warning = Color(0xffFFD607);
  static const Color blue = Color(0xff003CFF);
  static const Color blue2 = Color(0xff003CFF);
  static const Color solidBlue = Color(0xff0026DC);
  static const Color yankeesBlue = Color(0xff1b2338);
  static const Color seaGreen = Color(0xff00FDBC);
  static const Color lightRed = Color(0xffF28AAD);
  static const Color grey = Color(0xff979797);
  static const Color lightGrey = Color(0xffD8D8D8);
  static const Color white = Color(0xffFFFFFF);
  static const Color darkPurple = Color(0xff00004B);
  static const Color darkPurple2 = Color(0xff33336F);
  static const Color background = Color(0xff141927);
  static const Color silver = Color(0xffC8C8C8);
  static const Color lightSilver = Color(0xffdfe0e5);
  static const Color darkSilver = Color(0xFF807c82);
  static const Color pink = Color(0xffB429F5);
  static const Color pastelBlue = Color(0xff686de0);
  static const Color ligthPastelPink = Color.fromARGB(255, 241, 190, 252);
  static const Color lightPastelPurple = Color.fromARGB(255, 201, 172, 255);
  static const Color darkPastelPurple = Color(0xff9475CD);
  static const Color lightPastelBlue = Color.fromARGB(255, 212, 216, 236);

  static Color colorByTask(String status, bool isBackground) {
    if (status == 'TODO') {
      return isBackground ? AppStyle.lightPastelBlue : AppStyle.pastelBlue;
    } else if (status == 'DOING') {
      return isBackground ? AppStyle.ligthPastelPink : AppStyle.pink;
    } else if (status == 'DONE') {
      return isBackground ? AppStyle.ligthSuccess : AppStyle.success;
    } else {
      return isBackground ? AppStyle.darkSilver : AppStyle.yankeesBlue;
    }
  }
}
