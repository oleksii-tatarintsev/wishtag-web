import 'package:flutter/material.dart';

class AppCheckbox extends StatefulWidget {
  final bool? value;
  final bool tristate;
  final ValueChanged<bool?>? onChanged;

  const AppCheckbox({this.value = false, this.tristate = false, this.onChanged, super.key});

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

// TODO: customize the checkbox
class _AppCheckboxState extends State<AppCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(value: widget.value, tristate: widget.tristate, onChanged: widget.onChanged);
  }
}
