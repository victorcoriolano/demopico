import 'package:demopico/core/app/theme/theme.dart';
import 'package:flutter/material.dart';

class EditableCustomField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool isMultiline;
  final Function(String) onChanged;
  final Function() onEditingComplete;
  final String? Function(String?)? validator;


  const EditableCustomField({
    super.key,
    required this.onEditingComplete,
    required this.label,
    required this.controller,
    required this.icon,
    required this.onChanged,
    this.isMultiline = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: kMediumGrey)),
        const SizedBox(height: 5),
        TextFormField(
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          validator: validator,
          controller: controller,
          maxLines: isMultiline ? null : 1,
          keyboardType: isMultiline ? TextInputType.multiline : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: kRed),
            hintText: 'Digite seu $label',
            filled: true,
            fillColor: kWhite,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 15.0, horizontal: 15.0),
          ),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}