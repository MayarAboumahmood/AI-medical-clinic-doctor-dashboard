import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/cubit/patient_requests_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/data_source/models/user_request_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/view/widgets/user_request_card.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/get_status_request_from_status_code.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_fields/loadin_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

late PatientRequestsCubit patientRequestsCubit;

class PaeientRequestsPage extends StatelessWidget {
  const PaeientRequestsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientRequestsCubit, PatientRequestsState>(
      listener: (context, state) {
        if (state is PatientRequestErrorState) {
          String errorMessage = getMessageFromStatus(state.statusRequest);
          customSnackBar(errorMessage, context);
        }
      },
      child: patientRequestsPage(context),
    );
  }

  Scaffold patientRequestsPage(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: customColors.primaryBackGround,
      appBar: appBarPushingScreens('Patient Requests', isFromScaffold: true),
      body: BlocBuilder<PatientRequestsCubit, PatientRequestsState>(
        builder: (context, state) {
          if (state is PatientRequestsInitial) {
            patientRequestsCubit = context.read<PatientRequestsCubit>();
            patientRequestsCubit.getPatientRequests();
          } else if (state is PatientRequestLoadingState) {
            return achivementShimmer();
          } else if (state is PatientRequestDataLoadedState) {
            return patientRequestsListBody(context, state.patientRequestModels);
          }
          return achivementShimmer();
        },
      ),
    );
  }

  SingleChildScrollView patientRequestsListBody(
      BuildContext context, List<PatientRequestModel> patientRequestModels) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(patientRequestModels.length,
            (index) => userRequestCard(context, patientRequestModels[index])),
      ),
    );
  }
}
