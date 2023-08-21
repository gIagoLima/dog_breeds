import 'package:dog_breeds/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key, required this.title, required this.constraints});
  final String title;
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth,
      decoration: BoxDecoration(  
          color: ThemeConstants.mainColor,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
