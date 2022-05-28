import 'package:flutter/material.dart';

final fieldClosedDecoration = BoxDecoration(
  color: Colors.amber,
  borderRadius: BorderRadius.circular(6),
);

final fieldOpenDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(6),
  border: Border.all(color: Colors.grey[300] as Color),
);

final fieldBugDecoration = BoxDecoration(
  color: Colors.red.withOpacity(0.1),
  borderRadius: BorderRadius.circular(6),
  border: Border.all(color: Colors.grey[300] as Color),
);

class FieldWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ValueChanged<TapUpDetails>? onTertiaryTapUp;
  final BoxDecoration? decoration;
  final Widget? child;

  const FieldWidget({
    Key? key,
    this.onTap,
    this.onLongPress,
    this.onTertiaryTapUp,
    this.decoration,
    this.child,
  }) : super(key: key);

  get hasEvents => onTap != null || onLongPress != null || onTertiaryTapUp != null;

  @override
  Widget build(BuildContext context) {
    final container = Container(
      decoration: decoration,
      child: child,
    );
    if (!hasEvents) return container;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        onTertiaryTapUp: onTertiaryTapUp,
        child: container,
      ),
    );
  }
}
