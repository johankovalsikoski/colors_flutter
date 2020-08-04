import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(ColorsHome());
}

class ColorsHome extends StatefulWidget {
  @override
  _ColorsHomeState createState() => _ColorsHomeState();
}

class _ColorsHomeState extends State<ColorsHome> {
  int _redSliderValue = 0;
  int _greenSliderValue = 0;
  int _blueSliderValue = 0;

  Color _calcColor() {
    return Color.fromARGB(
        255, _redSliderValue, _greenSliderValue, _blueSliderValue);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          shadowColor: _calcColor(),
          title: Text(
            "Colors with Flutter",
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text("Red: $_redSliderValue"),
              SliderTheme(
                data: SliderThemeData(trackShape: CustomTrackShape()),
                child: Slider(
                    max: 255,
                    min: 0,
                    value: _redSliderValue.toDouble(),
                    activeColor: Colors.red,
                    inactiveColor: Colors.redAccent,
                    onChanged: (redValue) {
                      setState(() {
                        _redSliderValue = redValue.toInt();
                      });
                    }),
              ),
              Text("Green: $_greenSliderValue"),
              SliderTheme(
                data: SliderThemeData(trackShape: CustomTrackShape()),
                child: Slider(
                    max: 255,
                    min: 0,
                    value: _greenSliderValue.toDouble(),
                    activeColor: Colors.green,
                    inactiveColor: Colors.greenAccent,
                    onChanged: (greenValue) {
                      setState(() {
                        _greenSliderValue = greenValue.toInt();
                      });
                    }),
              ),
              Text("Blue: $_blueSliderValue"),
              SliderTheme(
                data: SliderThemeData(trackShape: CustomTrackShape()),
                child: Slider(
                    max: 255,
                    min: 0,
                    value: _blueSliderValue.toDouble(),
                    activeColor: Colors.blue,
                    inactiveColor: Colors.lightBlueAccent,
                    onChanged: (blueValue) {
                      setState(() {
                        _blueSliderValue = blueValue.toInt();
                      });
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _calcColor()),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlineButton(
                  borderSide: BorderSide(color: _calcColor()),
                  onPressed: () => {
                    setState(() {
                      Random _random = Random();
                      _redSliderValue = _random.nextInt(255);
                      _blueSliderValue = _random.nextInt(255);
                      _greenSliderValue = _random.nextInt(255);

                      _calcColor();
                    }),
                  },
                  child: Text(
                    "RANDOM",
                    style: TextStyle(color: _calcColor()),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Since Slider has extra space on start and end for the thumb, we need to create a custom TrackShape ignoring the offset.
class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx; // horizontal axis
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
