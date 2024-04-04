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
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
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
      style: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
