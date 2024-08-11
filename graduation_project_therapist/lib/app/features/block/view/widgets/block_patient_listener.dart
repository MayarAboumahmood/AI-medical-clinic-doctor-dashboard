import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block/bloc/block_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';

Widget blockPatientListener(void loadPage(),Widget child,) {
  return BlocListener<BlockBloc, BlockState>(
      listener: (context, state) {
        if (state is BlocFauilerState) {
          customSnackBar(state.errorMessage, context, isFloating: true);
        } else if (state is BlockPatientSuccessState) {
          customSnackBar('The patient has been blocked successfully', context,
              isFloating: true);
              loadPage();
        }
      },
      child: child);
}
