import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.errorText,
    this.suffixIcon,
    this.obscureText,
    this.validatorFunction,
    this.keyboardType,
    this.maxLength,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final String? errorText;
  final IconData? suffixIcon;
  final bool? obscureText;
  final Function(String?)? validatorFunction;
  final TextInputType? keyboardType;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 184, 184, 184).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 1,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        maxLength: maxLength,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          fillColor: kGreyColour,
          hintText: hintText,
          errorText: errorText, // Custom error text
          errorBorder: OutlineInputBorder(
            // Remove border when there is an error
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            // Remove border when focused with error
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          border: OutlineInputBorder(
            // Define default border
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            // Define border when field is enabled
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            // Define border when field is focused
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        ),
        validator: validatorFunction != null
            ? (value) => validatorFunction!(value)
            : (value) {
                if (value == null || value.isEmpty) {
                  return errorText;
                }
                return null; // Valid
              },
      ),
    );
  }
}
