import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

const Color defaultPickerColor = Colors.red;

typedef void ColorChange(Color color);

class ColorPicker extends StatefulWidget {
  final ColorChange onColorChange;
  final Color defaultColor;

  ColorPicker({this.onColorChange, this.defaultColor});

  @override
  _ColorPicker createState() => _ColorPicker();
}

class _ColorPicker extends State<ColorPicker> {
  Color selectedColor = defaultPickerColor;
  Color acceptedColor = defaultPickerColor;

  @override
  void initState() {
    if (widget.defaultColor != null) {
      selectedColor = widget.defaultColor;
      acceptedColor = widget.defaultColor;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(6.0),
              title: Text("Pick the color"),
              content: MaterialColorPicker(
                allowShades: false,
                onMainColorChange: (ColorSwatch color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
                selectedColor: selectedColor,
              ),
              actions: [
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: Navigator.of(context).pop,
                ),
                FlatButton(
                  child: Text('Update'),
                  onPressed: () {
                    setState(() {
                      acceptedColor = selectedColor;
                    });
                    Navigator.of(context).pop();
                    widget.onColorChange(acceptedColor);
                  },
                ),
              ],
            );
          },
        );
      },
      child: CircleColor(color: acceptedColor, circleSize: 25),
    );
  }
}
