// import 'package:flutter/material.dart';
// import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';
// import 'package:graduation_project_therapist_dashboard/main.dart';

// import '../../features/show_products/domain/entity/resturant_detailes_entity.dart';

// Widget buildRestaurantCardWithFollowIcon(SuggestionEntity suggestionEntity) {
//   return // Generated code for this Column Widget...
//       Container(
//     width: responsiveUtil.screenWidth * 0.9,
//     // height: responsiveUtil.screenHeight * 0.24,
//     decoration: BoxDecoration(
//       color: customColors.secondaryBackGround,
//       boxShadow: const [
//         BoxShadow(
//           blurRadius: 4,
//           color: Color(0x33000000),
//           offset: Offset(1, 3),
//         )
//       ],
//       borderRadius: BorderRadius.circular(15),
//     ),
//     child: Column(
//       // mainAxisSize: MainAxisSize.max,
//       children: [
//         Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
//               child: InkWell(
//                 splashColor: Colors.transparent,
//                 focusColor: Colors.transparent,
//                 hoverColor: Colors.transparent,
//                 highlightColor: Colors.transparent,
//                 onTap: () async {},
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.network(
//                     ServerConfig.images + suggestionEntity.images[0],
//                     width: double.infinity,
//                     height: 130,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
//               child: Container(
//                 width: responsiveUtil.scaleWidth(344),
//                 // height:responsiveUtil.scaleHeight(130),
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Color(0x9A2E4052), Color(0x0089CFF0)],
//                     stops: [0, 1],
//                     begin: AlignmentDirectional(0, -1),
//                     end: AlignmentDirectional(0, 1),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
//                     child: InkWell(
//                       splashColor: Colors.transparent,
//                       focusColor: Colors.transparent,
//                       hoverColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                       onTap: () async {},
//                       child: Container(
//                         width: 55,
//                         height: 30,
//                         decoration: BoxDecoration(
//                           color: const Color(0x2DD3D4D8),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.star_rounded,
//                               color: customColors.warning,
//                               size: 20,
//                             ),
//                             Text(
//                               suggestionEntity.ratingNumber.toString(),
//                               style: customTextStyle.bodyMedium.copyWith(
//                                 color: customColors.info,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
//                     child: CircleAvatar(
//                       backgroundColor: Colors.transparent,
//                       child: Icon(
//                         Icons.favorite_border,
//                         color: customColors.warning,
//                         size: 25,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
//           child: Container(
//             decoration: BoxDecoration(
//               color: customColors.secondaryBackGround,
//             ),
//             child: buildBody(suggestionEntity),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Column buildBody(SuggestionEntity suggestionEntity) {
//   return Column(
//     mainAxisSize: MainAxisSize.max,
//     children: [
//       Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: responsiveUtil.scaleWidth(200),
//             child: Text(
//               suggestionEntity.name,
//               style: customTextStyle.headlineSmall.copyWith(
//                 fontFamily: 'Outfit',
//                 color: customColors.primaryText,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//               softWrap: true,
//               overflow: TextOverflow.clip,
//             ),
//           ),
//           aviableText(),
//         ],
//       ),
//       _cuisineNameAndLocation(suggestionEntity),
//     ],
//   );
// }

// Padding aviableText() {
//   return Padding(
//     padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
//     child: Row(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Padding(
//           padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
//           child: Icon(
//             Icons.circle_rounded,
//             color: customColors.success,
//             size: 16,
//           ),
//         ),
//         Text(
//           "Available ",
//           style: customTextStyle.bodyMedium.copyWith(
//             color: customColors.primaryText,
//             fontSize: 12,
//             fontWeight: FontWeight.normal,
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Row _cuisineNameAndLocation(SuggestionEntity suggestionEntity) {
//   return Row(
//     mainAxisSize: MainAxisSize.max,
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(
//         suggestionEntity.cuisineName,
//         style: customTextStyle.headlineSmall.copyWith(
//           fontFamily: 'Outfit',
//           color: customColors.secondaryText,
//           fontSize: 12,
//           fontWeight: FontWeight.normal,
//         ),
//       ),
//       _locationText(suggestionEntity),
//     ],
//   );
// }

// Padding _locationText(SuggestionEntity suggestionEntity) {
//   return Padding(
//     padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
//     child: Row(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Padding(
//           padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
//           child: Icon(
//             Icons.my_location,
//             color: customColors.accent3,
//             size: 16,
//           ),
//         ),
//         Text(
//           "${suggestionEntity.distance} KM",
//           style: customTextStyle.bodyMedium.copyWith(
//             color: customColors.primaryText,
//             fontSize: 12,
//             fontWeight: FontWeight.normal,
//           ),
//         ),
//       ],
//     ),
//   );
// }
