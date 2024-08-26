import 'package:flutter/material.dart';

class ErrorWidgets extends StatelessWidget {
  const ErrorWidgets({super.key, this.errorMessage = "Error ocuured"});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Center(
        child: Column(
          children: [Text(errorMessage)],
        ),
      ),
    );
  }
}
