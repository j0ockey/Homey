import 'package:flutter/material.dart';

class CustomTextForm extends StatefulWidget {
  final String hinttext;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;

  const CustomTextForm({
    super.key,
    required this.hinttext,
    required this.mycontroller,
    required this.validator,
  });

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.mycontroller,
      decoration: InputDecoration(
        hintText: widget.hinttext,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 184, 184, 184))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.grey)),
      ),
    );
  }
}
