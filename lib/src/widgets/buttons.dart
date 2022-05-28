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

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  final Icon icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        icon: icon,
        splashRadius: 18,
        onPressed: onPressed,
      ),
    );
  }
}
