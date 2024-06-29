import 'dart:math';

import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/utils/flutter_flow_util.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/check_if_rtl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../main.dart';

Widget followingPageshimmer(PreferredSize f) {
  return Scaffold(
    backgroundColor: customColors.primaryBackGround,
    appBar: f,
    body: Column(
      children: [
        Expanded(
          child: Shimmer.fromColors(
              baseColor: customColors.secondaryBackGround,
              highlightColor: customColors.primaryBackGround,
              child: ListView.builder(
                  itemCount: 10, // Number of shimmer items
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 12, right: 12, bottom: 15),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        height: 200, // Adjust based on your content
                      ),
                    );
                  })),
        ),
      ],
    ),
  );
}

Widget buildListOfShimmerForProfilePage() {
  return Shimmer.fromColors(
      baseColor: customColors.secondaryBackGround,
      highlightColor: customColors.primaryBackGround,
      child: ListView.builder(
          itemCount: 10, // Number of shimmer items
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 12, right: 12, bottom: 15),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                height: 120, // Adjust based on your content
              ),
            );
          }));
}

Widget buildListOfShimmerForViewAllPage() {
  return Column(
      children:
          List.generate(8, (index) => generalElementForEachCardShimmer()));
}

Widget mediumSizeCardShimmer() {
  return Column(
    children: [
      Expanded(
        child: Shimmer.fromColors(
            baseColor: customColors.secondaryBackGround,
            highlightColor: customColors.primaryBackGround,
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(6, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      height: 160, // Adjust based on your content
                    ),
                  );
                }),
              ),
            )),
      ),
    ],
  );
}

Widget smallSizeCardShimmer() {
  return Column(
    children: [
      Expanded(
        child: Shimmer.fromColors(
            baseColor: customColors.secondaryBackGround,
            highlightColor: customColors.primaryBackGround,
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(6, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    height: 100, // Adjust based on your content
                  );
                }),
              ),
            )),
      ),
    ],
  );
}

Widget imageWithNameShimmer() {
  return SizedBox(
    width: double.infinity,
    height: responsiveUtil.scaleHeight(60),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: responsiveUtil.scaleWidth(10)),
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: customColors.secondaryBackGround,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 150, // Adjust the width as needed
          height: 20,
          color: customColors.secondaryBackGround,
        ),
      ],
    ),
  );
}

Widget messageShimmer(bool isFirstMessage, bool isSender) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Shimmer.fromColors(
      baseColor: customColors.secondaryBackGround,
      highlightColor: customColors.primaryBackGround,
      child: BubbleSpecialOne(
        text: generateRandomEmptyString(),
        textStyle: const TextStyle(color: Colors.transparent), // Hide text
        tail: isFirstMessage,
        color: customColors.secondaryBackGround,

        isSender: isSender,
      ),
    ),
  );
}

String generateRandomEmptyString() {
  Random random = Random();
  int length =
      random.nextInt(10) + 5; // Generate a random length between 1 and 20
  return '         ' * length; // Fill the string with spaces
}

Widget messageListShimmer() {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (context, index) {
      bool isFirstMessage = index == 0 || index == 6;
      bool isSender = index > 5;
      return messageShimmer(isFirstMessage, isSender);
    },
  );
}

Widget generalElementForEachCardShimmer() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Shimmer.fromColors(
      baseColor: customColors.secondaryBackGround,
      highlightColor: customColors.primaryBackGround,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: customColors.secondaryBackGround,
        ),
        width: double.infinity,
        height: responsiveUtil.scaleHeight(150),
      ),
    ),
  );
}

Widget offerAndNewOpiningShimmer() {
  return SizedBox(
    width: double.infinity,
    child: SingleChildScrollView(
      child: Column(
          children: [
        Shimmer.fromColors(
            baseColor: customColors.secondaryBackGround,
            highlightColor: customColors.primaryBackGround,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: responsiveUtil.scaleHeight(350),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                  ),
                ),
                Container(
                  height: responsiveUtil.scaleHeight(60),
                  width: responsiveUtil.screenWidth * .9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: responsiveUtil.scaleHeight(40),
                        width: responsiveUtil.screenWidth * .3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      Container(
                        height: responsiveUtil.scaleHeight(40),
                        width: responsiveUtil.screenWidth * .3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: responsiveUtil.screenHeight * .5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      shrinkWrap:
                          true, // Use shrinkWrap to make the GridView take up only as much space as it needs
                      physics:
                          const NeverScrollableScrollPhysics(), // This makes the GridView unscrollable

                      itemCount: 20,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            )),
      ].divide(const SizedBox(
        height: 20,
      ))),
    ),
  );
}

Widget restaurantDetailsShimmer(BuildContext context) {
  return SizedBox(
    width: responsiveUtil.screenWidth * .9,
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: customColors.secondaryBackGround,
            highlightColor: customColors.primaryBackGround,
            child: Column(
              children: [
                // Shimmer for the TabBar
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: responsiveUtil
                              .scaleHeight(20), // Adjust height as needed
                          width: responsiveUtil.screenWidth * .6,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: responsiveUtil
                              .scaleHeight(20), // Adjust height as needed
                          width: responsiveUtil.screenWidth * .3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: responsiveUtil
                          .scaleHeight(30), // Adjust height as needed
                      width: responsiveUtil.screenWidth * .2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: responsiveUtil
                        .scaleHeight(60), // Adjust height as needed
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: responsiveUtil
                              .scaleHeight(40), // Adjust height as needed
                          width: responsiveUtil.screenWidth * .25,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: isRTL(context)
                                      ? Radius.zero
                                      : const Radius.circular(15),
                                  topLeft: isRTL(context)
                                      ? Radius.zero
                                      : const Radius.circular(15),
                                  bottomRight: isRTL(context)
                                      ? const Radius.circular(15)
                                      : Radius.zero,
                                  topRight: isRTL(context)
                                      ? const Radius.circular(15)
                                      : Radius.zero))),
                      VerticalDivider(color: customColors.secondary, width: 5),
                      Container(
                        height: responsiveUtil
                            .scaleHeight(40), // Adjust height as needed
                        width: responsiveUtil.screenWidth * .25,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                      VerticalDivider(
                          color: customColors.secondary,
                          thickness: 0.1,
                          width: 5),
                      Container(
                        height: responsiveUtil
                            .scaleHeight(40), // Adjust height as needed
                        width: responsiveUtil.screenWidth * .25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomRight: isRTL(context)
                                ? Radius.zero
                                : const Radius.circular(15),
                            topRight: isRTL(context)
                                ? Radius.zero
                                : const Radius.circular(15),
                            bottomLeft: isRTL(context)
                                ? const Radius.circular(15)
                                : Radius.zero,
                            topLeft: isRTL(context)
                                ? const Radius.circular(15)
                                : Radius.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: responsiveUtil.screenWidth *
                      .55, // Adjust height as needed
                  width: responsiveUtil.screenWidth * .9,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Shimmer for Tab Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      for (int i = 0; i < 5; i++) // Repeat for number of tabs
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: Container(
                            height: responsiveUtil
                                .scaleHeight(50), // Adjust height as needed
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Shimmer resturantDetailsShimmerImage() {
  return Shimmer.fromColors(
    baseColor: customColors.secondaryBackGround,
    highlightColor: customColors.primaryBackGround,
    child: Container(
      height: responsiveUtil.screenHeight * .4, // Adjust height as needed
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  );
}
