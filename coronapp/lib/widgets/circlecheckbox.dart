import 'package:flutter/material.dart';

class CircleCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color checkColor;
  final bool tristate;
  final MaterialTapTargetSize materialTapTargetSize;
  final String checkDescription;

  CircleCheckbox(
      {Key key,
      @required this.value,
      this.tristate = false,
      @required this.onChanged,
      this.activeColor,
      this.checkColor,
      @required this.checkDescription,
      this.materialTapTargetSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ClipOval(
          child: SizedBox(
            width: Checkbox.width,
            height: Checkbox.width,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).accentColor ??
                      Theme.of(context).accentColor,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Checkbox(
                value: value,
                tristate: tristate,
                onChanged: onChanged,
                activeColor: activeColor,
                checkColor: checkColor,
                materialTapTargetSize: materialTapTargetSize,
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        Text("$checkDescription"),
      ],
    );
  }
}
