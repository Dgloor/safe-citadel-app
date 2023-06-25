import 'package:flutter/material.dart';
import 'package:prueba/components/coustom_bottom_nav_bar.dart';
import 'package:prueba/enums.dart';

import '../../size_config.dart';
import 'components/body.dart';
import '/models/User.dart';
import 'package:prueba/utils/Information.dart';
class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  final String text;

  HomeScreen({required this.text});

  @override
  Widget build(BuildContext context) {
     SizeConfig().init(context);
    return Scaffold(
      body: Body(text:text),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
