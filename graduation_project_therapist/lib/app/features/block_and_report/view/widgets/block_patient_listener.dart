import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/bloc/block_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';

Widget blockPatientListener(
  void loadPage(),
  Widget child,
) {
  return BlocListener<BlockBloc, BlockState>(
      listener: (context, state) {
        // GetPatientsCubit getPatientsCubit = context.read<GetPatientsCubit>();
        // PatientRequestsCubit patientRequestsCubit = context.read<PatientRequestsCubit>();
        // PatientReservationsCubit patientReservationsCubit = context.read<PatientReservationsCubit>();
        // GetAllTherapistCubit getAllTherapistCubit = context.read<GetAllTherapistCubit>();
        // DoctorEmploymentRequestsCubit doctorEmploymentRequestsCubit =
        //     context.read<DoctorEmploymentRequestsCubit>();
        if (state is BlockFauilerState) {
          customSnackBar(state.errorMessage, context, isFloating: true);
        } else if (state is BlockPatientSuccessState) {
          customSnackBar('The patient has been blocked successfully', context,
              isFloating: true);
          loadPage();
        } else if (state is ReportFauilerState) {
          customSnackBar(
              'Error while reporting: ${state.errorMessage}', context,
              isFloating: true);
        } else if (state is ReportPatientSuccessState) {
          customSnackBar(
              'Your report has been successfully submitted to the admin.',
              context,
              isFloating: true);
        } else if (state is ReportMedicalDescriptionSuccessState) {
          customSnackBar(
              'Your report has been successfully submitted to the admin.',
              context,
              isFloating: true);
        }
      },
      child: child);
}
