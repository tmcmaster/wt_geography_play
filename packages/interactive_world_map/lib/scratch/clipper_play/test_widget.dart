import 'package:flutter/material.dart';

final colors = [
  Colors.orangeAccent,
  Colors.blueAccent,
  Colors.yellowAccent,
  Colors.purpleAccent,
];

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      children: List.generate(9, (index) {
        return Container(
          color: colors[index % 4],
          child: Center(
            child: Text('${index + 1}'),
          ),
        );
      }),
    );
  }
}
