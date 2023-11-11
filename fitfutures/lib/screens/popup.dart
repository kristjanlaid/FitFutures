import 'package:fitfutures/consts/app_colors.dart';
import 'package:fitfutures/model/complete_treasure.dart';
import 'package:fitfutures/model/token.dart';
import 'package:fitfutures/model/user_data_notifier.dart';
import 'package:fitfutures/screens/claim_toke.dart';
import 'package:fitfutures/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PopupMenu extends StatefulWidget {
  final int? treasureId;

  PopupMenu({required this.treasureId});

  @override
  _PopupMenuState createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  int selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.all(16.0),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Center(
                child: Text('?',
                    style:
                        TextStyle(fontSize: 100, fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Container(
                child: const Text(
                  'There are two fathers and two sons in a car. How many people are in the car?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        activeColor: AppColors.secondary3,
                        value: 1,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value as int;
                          });
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text('Three (3)'),
                      ),
                    ],
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        activeColor: AppColors.secondary3,
                        value: 2,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value as int;
                          });
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text('Four (4)'),
                      ),
                    ],
                  ),
                ],
              ),
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
                  int? userId =
                      Provider.of<UserDataNotifier>(context, listen: false).id;

                  int? treasureId = widget.treasureId as int?;
                  if (userId != null && treasureId != null) {
                    Future<Token> token = pressButton(userId, treasureId);

                    Navigator.of(context).pop();

                    _openClaimPopup(context, token);
                  }
                },
                child: const Text('Submit',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

UserService service = UserService();

Future<Token> pressButton(int userId, int treasureId) async {
  CompleteTreasure completeTreasure =
      CompleteTreasure(userId: userId, treasureId: treasureId);
  Token newToken = await service.completeTreasure(completeTreasure);
  return newToken;
}

void _openClaimPopup(context, Future<Token> token) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ClaimToken(
            token: token,
          )));
}
