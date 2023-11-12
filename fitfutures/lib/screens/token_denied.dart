import 'package:fitfutures/consts/app_colors.dart';
import 'package:fitfutures/model/complete_treasure.dart';
import 'package:fitfutures/model/token.dart';
import 'package:fitfutures/model/user_data_notifier.dart';
import 'package:fitfutures/screens/claim_toke.dart';
import 'package:fitfutures/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopupMenuDenied extends StatefulWidget {
  @override
  _PopupMenuDeniedState createState() => _PopupMenuDeniedState();
}

class _PopupMenuDeniedState extends State<PopupMenuDenied> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.all(16.0),
      children: [
        const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Center(
                child: Text('You are not close enough to the Treasure.',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            ListTile(
              title: Center(
                child: Text('Keep going!',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        Container(
          width: 110,
          height: 40,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.primary1),
                foregroundColor:
                    MaterialStateProperty.all<Color>(AppColors.secondary1),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ))),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
