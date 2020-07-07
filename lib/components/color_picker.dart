import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

const Color defaultPickerColor = Colors.red;

class ColorPicker extends StatelessWidget {
  final Function(Color) onChange;
  final Color value;

  ColorPicker({@required this.onChange, @required this.value});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(context);
      },
      child: CircleColor(color: value, circleSize: 25),
    );
  }

  void onTap(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    showDialog(
      context: context,
      builder: (_) {
        return ColorPickerDialog(onChange: onChange, value: value);
      },
    );
  }
}

class ColorPickerDialog extends StatefulWidget {
  final Function(Color) onChange;
  final Color value;

  ColorPickerDialog({@required this.onChange, @required this.value});

  @override
  _ColorPickerDialog createState() => _ColorPickerDialog();
}

class _ColorPickerDialog extends State<ColorPickerDialog> {
  Color selectedColor = defaultPickerColor;

  @override
  void initState() {
    if (widget.value != null) {
      selectedColor = widget.value;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(6.0),
      title: Text("Pick the color"),
      content: MaterialColorPicker(
        shrinkWrap: true,
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
            Navigator.of(context).pop();
            widget.onChange(selectedColor);
          },
        ),
      ],
    );
  }
}
