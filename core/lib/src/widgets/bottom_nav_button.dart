import 'package:flutter/material.dart';

class BottomNavButton extends StatelessWidget {
  const BottomNavButton(this.text, this.onPressed, {Key? key}) : super(key: key);
  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        onPressed: onPressed,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
