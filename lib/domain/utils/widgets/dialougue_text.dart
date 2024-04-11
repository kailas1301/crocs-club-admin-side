import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialougueText extends StatelessWidget {
  const DialougueText({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: 16, fontWeight: FontWeight.w600, color: kDarkGreyColour),
    );
  }
}
