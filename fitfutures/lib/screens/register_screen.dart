import 'package:fitfutures/consts/app_colors.dart';
import 'package:fitfutures/model/user_data_notifier.dart';
import 'package:fitfutures/model/regsiter_data.dart';
import 'package:fitfutures/model/user_info.dart';
import 'package:fitfutures/service/auth/auth_service.dart';
import 'package:fitfutures/widgets/button.dart';
import 'package:fitfutures/widgets/input_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  UserService service = UserService();

  Future<UserInfo> register() async {
    RegisterData data = RegisterData(
      name: nameController.text,
      age: int.parse(ageController.text),
      height: int.parse(heightController.text),
      weight: int.parse(weightController.text),
    );
    UserInfo jwt = await service.register(registerData: data);
    return jwt;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary1,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Let's get started",
              style: TextStyle(
                  color: AppColors.secondary1,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 16)),
            const Text(
              "Create an account to increase your activity and join the fun treasure hunt",
              style: TextStyle(fontSize: 14, color: AppColors.secondary2),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 24)),
            InputField(label: "Name", controller: nameController),
            InputField(label: "Age", controller: ageController),
            InputField(label: "Height", controller: heightController),
            InputField(label: "Weight", controller: weightController),
            Button(
                color: AppColors.secondary1,
                label: "Register",
                onPressed: () async {
                  Provider.of<UserDataNotifier>(context, listen: false)
                      .addJWT(await register());
                  Navigator.pushReplacementNamed(context, "/main");
                })
          ],
        ),
      ),
    );
  }
}
