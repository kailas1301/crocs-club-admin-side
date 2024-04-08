import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/main.dart';
import 'package:flutter/material.dart';

class IconTextButtonWidget extends StatelessWidget {
  const IconTextButtonWidget({
    super.key,
    required this.buttonText,
    required this.icon,
    this.onPressed,
    required this.height,
    required this.width,
    required this.color,
    required this.textwidget,
  });
  final String buttonText;
  final IconData icon;
  final double height;
  final double width;
  final void Function()? onPressed;
  final Widget textwidget;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 203, 202, 202).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          height: screenHeight * height,
          width: screenWidth * width,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                textwidget,
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      icon,
                      color: kwhiteColour,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
