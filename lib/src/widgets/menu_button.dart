import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const MenuButton({Key? key, this.onTap, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextButton(
        onPressed: onTap,
        child: child,
      ),
    );
  }
}
