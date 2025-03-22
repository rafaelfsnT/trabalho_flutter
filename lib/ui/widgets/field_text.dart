import 'package:flutter/material.dart';

class FieldText extends StatelessWidget {
  final String text;
  final Widget? icon;
  final TextEditingController controller;

  const FieldText(this.controller, this.text, {this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 44),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: text,
          prefixIcon: icon,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
