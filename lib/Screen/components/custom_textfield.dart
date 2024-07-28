import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final bool isPassword;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  /* final TextInputAction? textInputAction; */
  final Widget? suffixIcon;
  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.isPassword = false,
    required this.controller,
    this.validator,
    this.prefixIcon = Icons.help_outline,
    this.keyboardType = TextInputType.text,
    /* this.textInputAction, */
    this.suffixIcon,
    this.onChanged,
  }) : super(key: key);

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _isObscure : false,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        /* textInputAction: widget.textInputAction, */
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          prefixIcon: Icon(widget.prefixIcon),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : widget.suffixIcon,
        ),
      ),
    );
  }
}
