import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_getx/components/constants.dart';
import 'package:recipe_getx/views/screens/login_screen.dart';
import 'package:recipe_getx/views/widgets/buttons.dart';

import '../../controllers/sign_in_manager.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                child: Image(
                  width: 420,
                  height: 406,
                  fit: BoxFit.contain,
                  image: AssetImage(
                    'assets/loading/Onboarding.png',
                  ),
                ),
              ),
              Text(
                'Start Cooking',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 32,
                  color: kMainTextClr,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Let\'s join our community \nto cook better food!',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                  color: kSecondaryTextClr,
                ),
              ),
              primaryButton(
                buttonClr: kPrimaryClr,
                textClr: Colors.white,
                buttonText: 'Get Started',
                buttonWidth: 327,
                buttonHeight: 56,
                onPressed: () {
                  Get.to(
                    () => const LoginScreen(),
                    binding: BindingsBuilder(
                      () {
                        Get.lazyPut<SingInManager>(() => SingInManager());
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
