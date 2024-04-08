import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingTextWidget extends StatelessWidget {
  const HeadingTextWidget({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class SubHeadingTextWidget extends StatelessWidget {
  const SubHeadingTextWidget({
    super.key,
    required this.title,
    this.textColor,
  });
  final String title;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }
}

class AppBarTextWidget extends StatelessWidget {
  const AppBarTextWidget({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        fontSize: 20,
        color: kblackColour,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    required this.title,
    this.textColor,
    this.fontsize,
  });
  final String title;
  final Color? textColor;
  final double? fontsize;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: fontsize,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }
}
