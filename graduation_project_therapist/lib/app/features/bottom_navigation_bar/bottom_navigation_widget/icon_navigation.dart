import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/bottom_navigation_bar/bloc/bottom_navigation_widget_bloc.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget iconPagesButton({
  required BuildContext context,
  required IconData icon,
  required int index,
  required int currentPage,
}) {
  return GestureDetector(
      onTap: () {
        if (currentPage == index && currentPage == 0) {
          // BlocProvider.of<ShowProductsBloc>(context)
          //     .add(const GetAllDataEvent());
        } else {
          BlocProvider.of<BottomNavigationWidgetBloc>(context)
              .add(ChangeCurrentPage(nextIndex: index));
        }
      },
      child: Container(
        color: Colors.transparent, // Set the color to transparent

        height: 60, width: MediaQuery.of(context).size.width * .1,
        child: Icon(icon,
            color: index == currentPage
                ? customColors.primary
                : customColors.secondaryText,
            size: 24),
      ));
}
