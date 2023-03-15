import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenPop(context) {
  Navigator.pop(context);
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenRemove(context, page) {
  Navigator.pushAndRemoveUntil(context, page, (route) => false);
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}

void newshowSnackbar(context, title, message, contentType) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: AwesomeSnackbarContent(
          inMaterialBanner: true,
          title: title,
          message: message,
          contentType: contentType)));
}

class FormWiget extends StatelessWidget {
  const FormWiget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TextFormFieldOvalNumberWidget extends StatelessWidget {
  const TextFormFieldOvalNumberWidget({
    Key? key,
    required this.labelText,
    required this.onChange,
    required this.validator,
    required this.icon,
  }) : super(key: key);
  final String labelText;
  final ValueChanged<String>? onChange;
  final String? Function(String?)? validator;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
      ),
      onChanged: onChange,
      validator: validator,
    );
  }
}

class TextFormFieldOvalWidget extends StatelessWidget {
  const TextFormFieldOvalWidget({
    Key? key,
    required this.labelText,
    this.onChange,
    required this.validator,
    required this.icon,
  }) : super(key: key);
  final String labelText;
  final ValueChanged<String>? onChange;
  final String? Function(String?)? validator;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
      ),
      onChanged: onChange,
      validator: validator,
    );
  }
}

class TextFormFieldAreaWidget extends StatelessWidget {
  const TextFormFieldAreaWidget({
    Key? key,
    required this.labelText,
    required this.onChange,
    required this.validator,
    required this.icon,
  }) : super(key: key);
  final String labelText;
  final ValueChanged<String>? onChange;
  final String? Function(String?)? validator;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 20,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChange,
      validator: validator,
    );
  }
}

class TextFormFieldOvalControllerWidget extends StatelessWidget {
  const TextFormFieldOvalControllerWidget({
    Key? key,
    required this.labelText,
    required this.validator,
    required this.icon,
    required this.controller,
  }) : super(key: key);
  final String labelText;
  final String? Function(String?)? validator;
  final IconData icon;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
      ),
      validator: validator,
      controller: controller,
    );
  }
}
