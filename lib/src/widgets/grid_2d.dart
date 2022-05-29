import 'package:bugsweeper/src/api/types.dart';
import 'package:flutter/material.dart';

typedef GridChildBuilder = Widget Function(BuildContext context, int index);

class Grid2D extends StatelessWidget {
  final double cellPadding;

  const Grid2D({
    Key? key,
    required this.width,
    required this.height,
    required this.cellSize,
    required this.gridChildBuilder,
    this.cellCliked,
    this.cellPadding = 6,
  }) : super(key: key);

  final int width;
  final int height;
  final double cellSize;
  final GridChildBuilder gridChildBuilder;
  final Function(Position pos)? cellCliked;

  @override
  Widget build(BuildContext context) {
    final totalItems = width * height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width * cellSize,
          height: height * cellSize,
          child: Wrap(
            children: [
              for (int i = 0; i < totalItems; i++) _buildCell(i),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCell(int index) {
    return Container(
      width: cellSize - cellPadding,
      height: cellSize - cellPadding,
      margin: EdgeInsets.all(cellPadding * 0.5),
      child: Builder(
        builder: (context) => gridChildBuilder(
          context,
          index,
        ),
      ),
    );
  }
}
