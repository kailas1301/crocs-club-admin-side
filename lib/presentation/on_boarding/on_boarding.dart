import 'package:action_slider/action_slider.dart';
import 'package:concentric_transition/page_view.dart';
import 'package:crocsclub_admin/presentation/authentication_selecting/llogin_scrn.dart';
import 'package:crocsclub_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final List<AssetImage> pages = [
    const AssetImage("assets/images/pngegg.png"),
    const AssetImage("assets/images/Green-Crocs-Transparent-Image.png"),
    const AssetImage("assets/images/crocs_PNG12.png"),
  ];
  final List<String> text = [
    'first page',
    'second page',
    'third page',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        radius: 10,
        verticalPosition: 0.85,
        colors: const [
          Color.fromARGB(255, 163, 237, 237),
          Color.fromARGB(255, 230, 245, 174),
          Color.fromARGB(255, 156, 143, 207)
        ],
        itemBuilder: (index) {
          int pageIndex = index % pages.length;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: pages[pageIndex], // Use AssetImage directly
                width: 350,
                height: 350,
              ),
              Text(text[pageIndex]),
              kSizedBoxH20,
              if (index == pages.length - 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ActionSlider.standard(
                    toggleColor: Colors.green,
                    backgroundBorderRadius: BorderRadius.circular(35),
                    child: const Text('Slide to confirm'),
                    action: (controller) async {
                      controller.loading(); //starts loading animation
                      await Future.delayed(const Duration(seconds: 3));
                      controller.success();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    // ... other parameters for ActionSlider
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
