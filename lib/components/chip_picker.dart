import 'package:flutter/material.dart';

typedef void ValueChange(String value);

class ChipPicker extends StatelessWidget {
  final ValueChange onChange;
  final String value;
  final List<String> values;

  ChipPicker(
      {@required this.onChange, @required this.value, @required this.values});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(context);
      },
      child: Text(value, style: TextStyle(fontSize: 18)),
    );
  }

  void onTap(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    showDialog(
      context: context,
      builder: (_) {
        return ChipPickerDialog(
            onChange: onChange, value: value, values: values);
      },
    );
  }
}

class ChipPickerDialog extends StatefulWidget {
  final ValueChange onChange;
  final String value;
  final List<String> values;

  ChipPickerDialog(
      {@required this.onChange, @required this.value, @required this.values});

  @override
  _ChipPickerDialog createState() => _ChipPickerDialog();
}

class _ChipPickerDialog extends State<ChipPickerDialog> {
  String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(6.0),
      content: Wrap(
          children: widget.values
              .map((item) => Container(
                    padding: const EdgeInsets.all(2.0),
                    child: ChoiceChip(
                      label: Text(item),
                      selected: item == selectedValue,
                      onSelected: (selected) {
                        setState(() {
                          selectedValue = item;
                        });
                      },
                    ),
                  ))
              .toList()),
      actions: [
        FlatButton(
          child: Text('Cancel'),
          onPressed: Navigator.of(context).pop,
        ),
        FlatButton(
          child: Text('Update'),
          onPressed: () {
            Navigator.of(context).pop();
            widget.onChange(selectedValue);
          },
        ),
      ],
    );
  }
}
