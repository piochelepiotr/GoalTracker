import 'package:flutter/material.dart';

const String defaultPickerUnit = "Hours";
List<String> units = ["Hours", "Minutes", "Months", "\$"];

typedef void UnitChange(String unit);

class UnitPicker extends StatefulWidget {
  final UnitChange onUnitChange;

  UnitPicker({this.onUnitChange});

  @override
  _UnitPicker createState() => _UnitPicker();
}

class _UnitPicker extends State<UnitPicker> {
  String selectedUnit = defaultPickerUnit;
  String acceptedUnit = defaultPickerUnit;

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
                    children: units
                        .map((item) => Container(
                              padding: const EdgeInsets.all(2.0),
                              child: ChoiceChip(
                                label: Text(item),
                                selected: item == selectedUnit,
                                onSelected: (selected) {
                                  setState(() {
                                    selectedUnit = item;
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
                        acceptedUnit = selectedUnit;
                      });
                      Navigator.of(context).pop();
                      widget.onUnitChange(acceptedUnit);
                    },
                  ),
                ],
              );
            });
          },
        );
      },
      child: Text(selectedUnit, style: TextStyle(fontSize: 18)),
    );
  }
}
