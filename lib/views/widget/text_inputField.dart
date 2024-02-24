import 'package:flutter/material.dart';
import 'package:peo_veo/constants/constant.dart';

class TextInputFieldPro extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final IconData icon;

  const TextInputFieldPro({Key? key,
        required this.labelText,
        required this.controller,
        required this.icon,
        this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle(
          fontSize: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide( color: buttonColor)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide( color: buttonColor)
        ),

      ),
      obscureText: isObscure,
    );
  }
}
