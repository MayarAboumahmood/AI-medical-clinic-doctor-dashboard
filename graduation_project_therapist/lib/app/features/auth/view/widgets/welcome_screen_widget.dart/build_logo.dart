import 'package:flutter/material.dart';

Widget buildLogo() {
  return SingleChildScrollView(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset('assets/images/SMHC icon.png'
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
