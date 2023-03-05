import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AdditionalDetails extends StatelessWidget {
  const AdditionalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF04FBC3),
      child: SafeArea(child: Scaffold()),
    );
  }
}
