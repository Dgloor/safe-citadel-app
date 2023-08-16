import 'package:flutter/material.dart';
import 'package:safecitadel/screens/sign_in/sign_in_screen.dart';
import 'package:safecitadel/screens/update_password/update_password_screen.dart';

import '../../../utils/Persistence.dart';
import 'profile_menu.dart';

class Body extends StatelessWidget {
  const Body({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          ProfileMenu(
            text: "Cambiar la contraseña",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.pushNamed(context, UpdatePasswordScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Manual de usuario",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Cerrar Sesión",
            icon: "assets/icons/Log out.svg",
            press: () {
              final apiClient = ApiGlobal.api;
              apiClient.saveUser('', '');
              Navigator.pushNamed(context, SignInScreen.routeName);},
          ),
        ],
      ),
    );
  }
}
