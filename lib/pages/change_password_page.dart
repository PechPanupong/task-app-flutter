import 'dart:async';

import 'package:app/store/app_storage.dart';
import 'package:app/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:provider/provider.dart';

import '../components/confirm_dialog.dart';
import '../style/app_style.dart';

class ChangePassWord extends StatelessWidget {
  const ChangePassWord({super.key, this.restartTimer});

  final Function? restartTimer;

  @override
  Widget build(BuildContext context) {
    final StreamController<bool> verificationNotifierChangePassword =
        StreamController<bool>.broadcast();

    final CommonUtil common = CommonUtil();

    _onPasscodeEntered(String enteredPasscode) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialog(
            content: 'Are you sure to change password?',
            confirm: () {
              context.read<AppStorage>().password = enteredPasscode;
              restartTimer!();
              Navigator.pop(context);
              common.showSnackBar(context, 'Password changed !!!');
            },
          );
        },
      );
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        restartTimer!();
        return true;
      },
      child: PasscodeScreen(
          backgroundColor: AppStyle.lightPastelBlue,
          title: Container(
            padding: REdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              'Enter new passcode',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppStyle.darkSilver,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
          ),
          circleUIConfig: const CircleUIConfig(
            fillColor: AppStyle.darkSilver,
            borderWidth: 2,
            borderColor: AppStyle.darkSilver,
          ),
          keyboardUIConfig: KeyboardUIConfig(
              digitBorderWidth: 2,
              primaryColor: AppStyle.darkSilver,
              digitTextStyle:
                  TextStyle(fontSize: 42.sp, color: AppStyle.darkSilver)),
          passwordEnteredCallback: _onPasscodeEntered,
          cancelCallback: () {
            Navigator.pop(context);
            restartTimer!();
          },
          cancelButton: Text(
            'Cancel',
            style: TextStyle(
                fontSize: 24.sp,
                color: AppStyle.darkSilver,
                fontWeight: FontWeight.bold),
            semanticsLabel: 'Cancel',
          ),
          deleteButton: Text(
            'Delete',
            style: TextStyle(
                fontSize: 24.sp,
                color: AppStyle.darkSilver,
                fontWeight: FontWeight.bold),
            semanticsLabel: 'Delete',
          ),
          shouldTriggerVerification: verificationNotifierChangePassword.stream),
    );
  }
}
