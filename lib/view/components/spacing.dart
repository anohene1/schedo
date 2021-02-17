import 'package:flutter/material.dart';

class HorizontalSpacing extends StatelessWidget {

  HorizontalSpacing(this.size);

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
    );
  }
}

class VerticalSpacing extends StatelessWidget {
  VerticalSpacing(this.size);

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
    );
  }
}
