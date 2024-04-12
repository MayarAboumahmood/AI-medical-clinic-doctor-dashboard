import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';

class CaroucelOptionFunctions {
  static CarouselOptions discoverOption = CarouselOptions(
    initialPage: 1,
    viewportFraction: 0.9,
    disableCenter: true,
    enlargeCenterPage: true,
    enlargeFactor: 0.2,
    height: 219,
    enableInfiniteScroll: false,
    scrollDirection: Axis.horizontal,
    autoPlay: false,
    onPageChanged: (index, _) {},
  );

  static CarouselOptions featuredOptions = CarouselOptions(
    initialPage: 1,
    viewportFraction: 0.75,
    disableCenter: true,
    height: 306,
    enlargeCenterPage: true,
    enlargeFactor: 0.3,
    enableInfiniteScroll: false,
    scrollDirection: Axis.horizontal,
    autoPlay: false,
    onPageChanged: (index, _) {},
  );
  static CarouselOptions offersOptions = CarouselOptions(
    initialPage: 0,
    viewportFraction: 0.8,
    disableCenter: true,
    enlargeCenterPage: true,
    enlargeFactor: 0.25,
    enableInfiniteScroll: false,
    scrollDirection: Axis.horizontal,
    autoPlay: true,
    autoPlayAnimationDuration: const Duration(milliseconds: 800),
    autoPlayInterval: const Duration(milliseconds: (800 + 4000)),
    autoPlayCurve: Curves.linear,
    pauseAutoPlayInFiniteScroll: true,
    onPageChanged: (index, _) {},
  );

  static CarouselOptions basedOnYourTastOptions = CarouselOptions(
    initialPage: 1,
    viewportFraction: 0.85,
    disableCenter: true,
    enlargeCenterPage: true,
    enlargeFactor: 0.2,
    height: 218,
    enableInfiniteScroll: false,
    scrollDirection: Axis.horizontal,
    autoPlay: false,
    onPageChanged: (index, _) {},
  );
  static CarouselOptions mapCardOptions = CarouselOptions(
    initialPage: 1,
    viewportFraction: 0.85,
    disableCenter: true,
    enlargeCenterPage: true,
    enlargeFactor: 0.2,
    height: 236,
    enableInfiniteScroll: false,
    scrollDirection: Axis.horizontal,
    autoPlay: false,
    onPageChanged: (index, _) {},
  );

  static CarouselOptions searchOptions = CarouselOptions(
    initialPage: 1,
    viewportFraction: 0.85,
    disableCenter: true,
    enlargeCenterPage: true,
    enlargeFactor: 0.2,
    enableInfiniteScroll: false,
    scrollDirection: Axis.vertical,
    autoPlay: false,
    onPageChanged: (index, _) {},
  );
  static CarouselOptions forYouOptions = CarouselOptions(
    initialPage: 1,
    viewportFraction: 0.85,
    disableCenter: true,
    enlargeCenterPage: true,
    height: 256,
    enlargeFactor: 0.2,
    enableInfiniteScroll: false,
    scrollDirection: Axis.horizontal,
    autoPlay: false,
    onPageChanged: (index, _) {},
  );
  static CarouselOptions newOpiningOptions = CarouselOptions(
      initialPage: 0,
      viewportFraction: 1,
      disableCenter: true,
      enlargeCenterPage: true,
      enlargeFactor: 0.25,
      enableInfiniteScroll: false,
      scrollDirection: Axis.vertical,
      autoPlay: true,
      height: 200,
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayInterval: const Duration(milliseconds: (800 + 4000)),
      autoPlayCurve: Curves.linear,
      pauseAutoPlayInFiniteScroll: true,
      onPageChanged: (index, _) {});
  static CarouselOptions imagesOption = CarouselOptions(
    initialPage: 1,
    viewportFraction: 1,
    disableCenter: true,
    enlargeCenterPage: true,
    // enlargeFactor: 0.2,
    enableInfiniteScroll: false,
    scrollDirection: Axis.horizontal,
    autoPlay: false,
    onPageChanged: (index, _) {},
  );
}
