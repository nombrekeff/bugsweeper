// ignore: file_names
import 'package:bugsweeper/src/api/types.dart';
import 'package:flutter/material.dart';

typedef GridChildBuilder = Widget Function(BuildContext context, int index);
const cellPadding = 6.0;

class BugsweeperGrid extends StatefulWidget {
  const BugsweeperGrid({
    Key? key,
    required this.width,
    required this.height,
    required this.cellSize,
    required this.gridChildBuilder,
    this.cellCliked,
  }) : super(key: key);

  final int width;
  final int height;
  final double cellSize;
  final GridChildBuilder gridChildBuilder;
  final Function(Position pos)? cellCliked;

  @override
  State<BugsweeperGrid> createState() => _BugsweeperGridState();
}

class _BugsweeperGridState extends State<BugsweeperGrid> {
  @override
  Widget build(BuildContext context) {
    final count = widget.width * widget.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: widget.width * widget.cellSize + (cellPadding),
          height: widget.height * widget.cellSize + (cellPadding),
          child: Wrap(
            children: [
              for (int i = 0; i < count; i++) _buildCell(i),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCell(int index) {
    final y = (index / widget.width).floor();
    final x = index % widget.height;
    final pos = Position(x, y);

    return Container(
      width: widget.cellSize - cellPadding,
      height: widget.cellSize - cellPadding,
      margin: const EdgeInsets.all(cellPadding * 0.5),
      child: Builder(
        builder: (context) => widget.gridChildBuilder(
          context,
          index,
        ),
      ),
    );
  }
}
