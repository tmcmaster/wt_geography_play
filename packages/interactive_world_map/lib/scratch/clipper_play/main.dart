import 'package:flutter/material.dart';

import 'clip_with_path.dart';
import 'test_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
            ),
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SizedBox(
                width: 500,
                height: 500,
                child: Stack(
                  children: [
                    Container(color: Colors.cyan),
                    const Positioned(
                      width: 300,
                      height: 300,
                      left: 50,
                      top: 50,
                      child: AnimatedRotation(
                        duration: Duration(seconds: 4),
                        turns: 3,
                        child: ClipWithPath(
                          offset: Offset(150, 150),
                          size: Size(600, 600),
                          child: TestWidget(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
