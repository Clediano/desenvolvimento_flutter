import 'package:flutter/material.dart';

class ImageCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String checkDescription;
  final Function onSelectedSymptom;

  ImageCheckBox(
      {Key key,
      @required this.onSelectedSymptom,
      @required this.value,
      @required this.onChanged,
      @required this.checkDescription})
      : super(key: key);

  @override
  _ImageCheckBoxState createState() => _ImageCheckBoxState();
}

class _ImageCheckBoxState extends State<ImageCheckBox> {
  bool checkedIcon;

  @override
  void initState() {
    setState(() {
      checkedIcon = widget.value;
    });
  }

  Widget getIcon() {
    if (!checkedIcon) return Icon(Icons.check_box_outline_blank);
    return Icon(
      Icons.check_box,
      color: Theme.of(context).accentColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: getIcon(),
          onPressed: () {
            setState(() {
              checkedIcon = !checkedIcon;
            });
            widget.onSelectedSymptom(widget.checkDescription, checkedIcon);
          },
        ),
        SizedBox(width: 5),
        Text("${widget.checkDescription}")
      ],
    );
  }
}
