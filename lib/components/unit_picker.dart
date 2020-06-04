import 'package:flutter/material.dart';

typedef void ValueChange(String value);

class ChipPicker extends StatefulWidget {
  final ValueChange onChange;
  final String defaultValue;
  final List<String> values;

  ChipPicker({this.onChange, this.defaultValue, this.values});

  @override
  _ChipPicker createState() => _ChipPicker();
}

class _ChipPicker extends State<ChipPicker> {
  String selectedValue;
  String acceptedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.defaultValue;
    acceptedValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) {
            return StatefulBuilder(builder: (context, setState) {
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
                      setState(() {
                        acceptedValue = selectedValue;
                      });
                      Navigator.of(context).pop();
                      widget.onChange(acceptedValue);
                    },
                  ),
                ],
              );
            });
          },
        );
      },
      child: Text(selectedValue, style: TextStyle(fontSize: 18)),
    );
  }
}
