import 'dart:async';

import 'package:app/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:provider/provider.dart';

import '../store/app_storage.dart';

class PassLockScreen extends StatefulWidget {
  const PassLockScreen({super.key, this.isPage = true, this.startTimer});
  final bool isPage;
  final Function? startTimer;

  @override
  State<PassLockScreen> createState() => _PassLockScreenState();
}

class _PassLockScreenState extends State<PassLockScreen> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();
  bool showHint = false;

  _onPasscodeEntered(String enteredPasscode) {
    String password = context.read<AppStorage>().password;
    bool isValid = enteredPasscode == password;
    _verificationNotifier.add(isValid);
    if (isValid) {
      context.read<AppStorage>().isLogin = true;
      context.read<AppStorage>().closeDate = DateTime.now().toString();

      if (widget.isPage) {
        GoRouter.of(context).go('/');
      } else {
        Navigator.pop(context);
        widget.startTimer!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String password = context.read<AppStorage>().password;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: PasscodeScreen(
        backgroundColor: AppStyle.lightPastelBlue,
        title: Container(
          padding: REdgeInsets.symmetric(horizontal: 20),
          child: const Text(
            'Please enter passcode',
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
        cancelButton: const SizedBox.shrink(),
        deleteButton: Text(
          'Delete',
          style: TextStyle(
              fontSize: 24.sp,
              color: AppStyle.darkSilver,
              fontWeight: FontWeight.bold),
          semanticsLabel: 'Delete',
        ),
        shouldTriggerVerification: _verificationNotifier.stream,
        bottomWidget: Container(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    showHint = !showHint;
                  });
                },
                child: Text(
                  'Hint?',
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                ),
              ),
              showHint
                  ? Text(
                      password,
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppStyle.darkSilver),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
