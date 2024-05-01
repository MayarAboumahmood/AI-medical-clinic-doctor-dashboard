import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/cubit/patient_requests_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/data_source/models/user_request_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/view/widgets/patient_request_card.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/get_status_request_from_status_code.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/loadin_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

late PatientRequestsCubit patientRequestsCubit;

class PaeientRequestsPage extends StatefulWidget {
  const PaeientRequestsPage({super.key});

  @override
  State<PaeientRequestsPage> createState() => _PaeientRequestsPageState();
}

class _PaeientRequestsPageState extends State<PaeientRequestsPage> {
  @override
  void initState() {
    super.initState();
    patientRequestsCubit = context.read<PatientRequestsCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      patientRequestsCubit.getPatientRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientRequestsCubit, PatientRequestsState>(
      listener: (context, state) {
        if (state is PatientRequestErrorState) {
          String errorMessage = getMessageFromStatus(state.statusRequest);
          customSnackBar(errorMessage, context);
        } else if (state is PatientRequestApprovedSuccessfullyState) {
          customSnackBar('session confirmed Successfully', context);
        } else if (state is PatientRequestRejectedSuccessfullyState) {
          customSnackBar('session rejected Successfully', context);
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
          if (state is PatientRequestLoadingState) {
            return mediumSizeCardShimmer();
          } else if (state is PatientRequestDataLoadedState) {
            return patientRequestsListBody(context, state.patientRequestModels);
          } else if (state is PatientRequestApprovedSuccessfullyState) {
            return patientRequestsListBody(
                context, patientRequestsCubit.cachedUserRequests);
          } else if (state is PatientRequestRejectedSuccessfullyState) {
            return patientRequestsListBody(
                context, patientRequestsCubit.cachedUserRequests);
          }
          return mediumSizeCardShimmer();
        },
      ),
    );
  }

  SingleChildScrollView patientRequestsListBody(
      BuildContext context, List<PatientRequestModel> patientRequestModels) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
            patientRequestModels.length,
            (index) =>
                patientRequestCard(context, patientRequestModels[index])),
      ),
    );
  }
}
