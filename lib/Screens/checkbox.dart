import 'package:flutter/material.dart';

bool _checkBox = false;

class CheckboxCustom extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
   const CheckboxCustom({
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);
  @override
   Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey),
          color: value ? Colors.black : Colors.white, // Initial color and checked color
        ),
        child: value
            ? Icon(
                Icons.check,
                size: 18,
                color: Colors.white, // Color of the check icon
              )
            : null,
      ),
    );
  }
}
