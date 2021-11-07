import 'package:flutter/material.dart';
import 'checkbox.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: MainBody(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainBody extends StatefulWidget {
  MainBody({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  String groupValue = '';
  double duration = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleCheckBox(
                  duration: duration.toInt(),
                  outlineColor: Colors.blue,
                  value: '1',
                  onValueChanged: (val) {
                    setState(() {
                      groupValue = val;
                    });
                  },
                  groupValue: groupValue,
                ),
                SizedBox(
                  width: 20,
                ),
                CircleCheckBox(
                  duration: duration.toInt(),
                  value: '2',
                  groupValue: groupValue,
                  onValueChanged: (val) {
                    setState(() {
                      groupValue = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Animation duration',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Slider(
              min: 200,
              max: 2000,
              value: duration,
              onChanged: (dur) {
                setState(() {
                  duration = dur;
                });
              },
            ),
            Text(
              '${duration.round()} ms',
              style: TextStyle(
                fontSize: 25,
              ),
            )
          ],
        ),
      ),
    );
  }
}
