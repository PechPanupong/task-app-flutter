import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../store/app_storage.dart';

class PassLockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height, // Set the height to full screen
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              'Enter Passcode ${context.select((AppStorage value) => value.closeDate)}',
              style: TextStyle(fontSize: 24)),
          ElevatedButton(
            onPressed: () {
              context.read<AppStorage>().isLogin = true;
              GoRouter.of(context).replace('/');
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
