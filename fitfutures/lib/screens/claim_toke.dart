import 'package:fitfutures/consts/app_colors.dart';
import 'package:fitfutures/model/complete_treasure.dart';
import 'package:fitfutures/model/token.dart';
import 'package:fitfutures/model/user_data_notifier.dart';
import 'package:fitfutures/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ClaimToken extends StatefulWidget {
  Future<Token> token;

  ClaimToken({required this.token});

  @override
  _ClaimTokenState createState() => _ClaimTokenState();
}

class _ClaimTokenState extends State<ClaimToken> {
  int selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Token>(
      future: widget.token,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            child: Center(
              child: CircularProgressIndicator(),
            ),
            height: 100,
            width: 100,
          ); // or a placeholder widget while loading
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Use the fetched data
          Token token = snapshot.data!;

          return SimpleDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            contentPadding: EdgeInsets.all(16.0),
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: Image.memory(
                      token.pictureBytes,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ListTile(
                    title: Center(
                      child: Text(
                        token.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.primary1),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            AppColors.secondary1),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Claim token',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
