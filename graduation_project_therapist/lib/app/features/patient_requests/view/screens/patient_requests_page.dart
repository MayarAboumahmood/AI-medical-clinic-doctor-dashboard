import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/view/widgets/block_patient_listener.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/cubit/patient_requests_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/data_source/models/user_request_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/view/widgets/patient_request_card.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/custom_refress_indicator.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/no_element_in_page.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/loadin_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

late PatientRequestsCubit patientRequestsCubit;

class PatientRequestsPage extends StatefulWidget {
  const PatientRequestsPage({super.key});

  @override
  State<PatientRequestsPage> createState() => _PatientRequestsPageState();
}

class _PatientRequestsPageState extends State<PatientRequestsPage> {
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
    return blockPatientListener(
      patientRequestsCubit.getPatientRequests,
      BlocListener<PatientRequestsCubit, PatientRequestsState>(
        listener: (context, state) {
          if (state is PatientRequestErrorState) {
            customSnackBar(state.errorMessage, context);
          } else if (state is PatientRequestRejectedSuccessfullyState) {
            customSnackBar('session rejected Successfully', context);
          } else if (state is PatientRequestApprovedSuccessfullyState) {
            customSnackBar('session Approved Successfully', context);
          }
        },
        child: patientRequestsPage(context),
      ),
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
          } else if (state is PatientRequestApprovedSuccessfullyState ||
              state is PatientRequestRejectLoadingState ||
              state is PatientRequestAcceptLoadingState) {
            return patientRequestsListBody(
                context, patientRequestsCubit.cachedUserRequests ?? []);
          } else if (state is PatientRequestRejectedSuccessfullyState) {
            return patientRequestsListBody(
                context, patientRequestsCubit.cachedUserRequests ?? []);
          } else if (state is PatientRequestErrorState) {
            return patientRequestsListBody(
                context, patientRequestsCubit.cachedUserRequests ?? []);
          }
          return mediumSizeCardShimmer();
        },
      ),
    );
  }

  RefreshIndicator patientRequestsListBody(
      BuildContext context, List<PatientRequestModel> patientRequestModels) {
    return customRefreshIndicator(
        refreshPatientRequests,
        Column(
          children: [
            Expanded(
              // height: responsiveUtil.screenHeight * .7,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: patientRequestModels.isEmpty
                    ? SizedBox(
                        height: responsiveUtil.screenHeight * .7,
                        child: Center(
                          child: buildNoElementInPage(
                            'No request yet. Please Check Back Later!',
                            Icons.hourglass_empty_rounded,
                          ),
                        ),
                      )
                    : Column(children: [
                        ...List.generate(
                          patientRequestModels.length,
                          (index) => patientRequestCard(
                              context, patientRequestModels[index]),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ]),
              ),
            ),
          ],
        ));
  }

  Future<void> refreshPatientRequests() async {
    patientRequestsCubit.getPatientRequests(fromRefreshIndicator: true);
  }
}
