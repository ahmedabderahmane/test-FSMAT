import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'element.dart';

// ignore: must_be_immutable, camel_case_types
class loginScreen extends StatelessWidget {
  loginScreen({super.key});

  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final LoginController loginController = Get.put(LoginController());

  bool saveData = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: -0),
                Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" Email", style: TextStyle(fontSize: 12)),
                    CastumTextFormField(
                      textEditingController: emailTextEditingController,
                      hintText: "Enter your Email",
                      isObscure: false,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Password", style: TextStyle(fontSize: 12)),
                    CastumTextFormField(
                      textEditingController: passwordTextEditingController,
                      hintText: "Enter your Password",
                      isObscure: true,
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Radio(
                      value: true,
                      groupValue: saveData,
                      onChanged: (value) {
                        saveData = value ?? false;
                      },
                    ),
                    Text("Remember Password"),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        print("Forget Password ?");
                      },
                      child: Text("Forget Password ?"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 121,
                ),
                CustomButton(
                    lable: "Sign In",
                    onPressed: () {
                      loginController.login(
                          context,
                          emailTextEditingController.text,
                          passwordTextEditingController.text);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginController extends GetxController {
  final LoginServices _loginServices = LoginServices();
  var isSigningIn = false.obs;

  void setISSigningIn(var newValue) {
    isSigningIn.value = newValue;
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    setISSigningIn(true);
    await _loginServices.login(context, email, password);
    setISSigningIn(false);
  }
}

class LoginServices {
  Future<void> login(
      BuildContext context, String email, String password) async {
    print("--" * 30);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Connexion réussie'),
            content: Text('User ID: ${userCredential.user!.uid}'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.toNamed('/element.dart');
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print('Error: ${e.message}');
      // Handle error, show error message, etc.
    }
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.lable,
    required this.onPressed,
  });
  final String lable;
  final Function onPressed;

  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Background color
          foregroundColor: Colors.white, // Text color
          elevation: 4, // Elevation (shadow)
          padding: const EdgeInsets.symmetric(horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Border radius
          ),
        ),
        onPressed: () {
          onPressed();
        },
        child: Obx(() => loginController.isSigningIn.value
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ))
            : Text(lable)));
  }
}

class CastumTextFormField extends StatelessWidget {
  const CastumTextFormField({
    super.key,
    required this.textEditingController,
    required this.isObscure,
    required this.hintText,
  });

  final TextEditingController textEditingController;
  final bool isObscure;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey[500]!),
          borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        obscureText: isObscure,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none),
        controller: textEditingController,
      ),
    );
  }
}
