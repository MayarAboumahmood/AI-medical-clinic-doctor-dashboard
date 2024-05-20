import 'package:flutter/material.dart';

Widget buildLogo() {
  return SingleChildScrollView(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Container(
          width: 210,
          height: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset('assets/images/male.png'
                      // AppImages.preview,
                      )
                  .image,
            ),
          ),
        ),
      ),
    ),
  );
}
