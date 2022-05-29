import 'package:bugsweeper/src/widgets/grid_2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeWidget extends StatelessWidget {
  const FakeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

void main() {
  testWidgets('description', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Grid2D(
              cellSize: 40,
              height: 10,
              width: 10,
              gridChildBuilder: (context, index) {
                return const FakeWidget();
              },
            ),
          ),
        ),
      ),
    );

    final finder = find.byType(FakeWidget);
    expect(finder, findsNWidgets(100));
  });
}
