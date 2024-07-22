import 'package:flutter/material.dart';

class GenderRadio extends StatefulWidget {
  final String? selectedGender;
  final Function(String) onChanged;

  const GenderRadio({
    Key? key,
    required this.selectedGender,
    required this.onChanged,
  }) : super(key: key);

  @override
  _GenderRadioState createState() => _GenderRadioState();
}

class _GenderRadioState extends State<GenderRadio> {
  String? _gender;

  @override
  void initState() {
    super.initState();
    _gender = widget.selectedGender;
  }

  void _handleRadioValueChange(String? value) {
    setState(() {
      _gender = value;
      widget.onChanged(value!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Radio<String>(
              value: 'Nam',
              groupValue: _gender,
              onChanged: _handleRadioValueChange,
            ),
            const Text('Nam'),
          ],
        ),
        const SizedBox(width: 20), // Khoảng cách giữa hai nút radio
        Row(
          children: [
            Radio<String>(
              value: 'Nữ',
              groupValue: _gender,
              onChanged: _handleRadioValueChange,
            ),
            const Text('Nữ'),
          ],
        ),
      ],
    );
  }
}
