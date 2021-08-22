import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _snapshotController = ScreenshotController();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Screenshot(
                controller: _snapshotController,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Column(
                      children: [
                        Image.asset('images/abs.jpg'),
                        Text("Abstratc Image"),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(StadiumBorder()),
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: _takeSnapshot,
                  child: Icon(
                    Icons.share,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _takeSnapshot() async {
    final unit8list = await _snapshotController.capture();
    Directory fileset = await getTemporaryDirectory();
    String filePath = fileset.path;
    File file = File('$filePath/image.jpg');
    await file.writeAsBytes(unit8list!);
    Share.shareFiles([file.path]);
  }
}
