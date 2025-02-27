import 'package:flutter/material.dart';
import 'package:fooderlich/api/on_board_service.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../screens/home.dart';

Widget buildPages() {
  return PageView(
    controller: controller,
    children: [
      onboardPageView(
        const AssetImage('assets/fooderlich_assets/recommend.png'),
        '''Check out weekly recommended recipes and what your friends are cooking!''',
      ),
      onboardPageView(
        const AssetImage('assets/fooderlich_assets/sheet.png'),
        'Cook with step by step instructions!',
      ),
      onboardPageView(
        const AssetImage('assets/fooderlich_assets/list.png'),
        'Keep track of what you need to buy',
      ),
    ],
  );
}

Widget onboardPageView(
  ImageProvider imageProvider,
  String text,
) {
  return Padding(
    padding: const EdgeInsets.all(40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Image(
            fit: BoxFit.fitWidth,
            image: imageProvider,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          text,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
      ],
    ),
  );
}

Widget buildIndicator() {
  return SmoothPageIndicator(
    controller: controller,
    count: 3,
    effect: WormEffect(
      activeDotColor: rwColor,
    ),
  );
}

Widget buildActionButtons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      MaterialButton(
        child: const Text('Skip'),
        onPressed: () {
         // OnBoardServices().saveIsView();
          Get.offAll(() => const Home());
        },
      ),
    ],
  );
}

final controller = PageController();
final Color rwColor = const Color.fromRGBO(64, 143, 77, 1);
