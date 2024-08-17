import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/doctor_employment_requests/cubit/doctor_employment_requests_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/doctor_employment_requests/data_source/models/doctor_employment_request_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/doctor_employment_requests/view/widgets/doctor_employment_request_card.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/custom_refress_indicator.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/no_element_in_page.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/loadin_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class DoctorEmploymentRequestsPage extends StatefulWidget {
  const DoctorEmploymentRequestsPage({super.key});

  @override
  State<DoctorEmploymentRequestsPage> createState() =>
      _DoctorEmploymentRequestsPageState();
}

class _DoctorEmploymentRequestsPageState
    extends State<DoctorEmploymentRequestsPage> {
  @override
  Widget build(BuildContext context) {
    DoctorEmploymentRequestsCubit doctorEmploymentRequestsCubit =
        context.read<DoctorEmploymentRequestsCubit>();
    doctorEmploymentRequestsCubit.getAllDoctorEmploymentRequests();
    return Scaffold(
      backgroundColor: customColors.primaryBackGround,
      appBar: appBarPushingScreens(
        'Employment requests',
        isFromScaffold: true,
      ),
      body: BlocConsumer<DoctorEmploymentRequestsCubit,
          DoctorEmploymentRequestsState>(
        listener: (context, state) {
          if (state is DoctorEmploymentRequestsErrorState) {
            print('the state is: $state');
            customSnackBar(state.errorMessage, context);
          } else if (state is DoctorEmploymentApproveRequestsState) {
            customSnackBar(
                'The employment request has been approved successfully',
                context);
          }
        },
        builder: (context, state) {
          if (state is DoctorEmploymentRequestsLoadingState) {
            return mediumSizeCardShimmer();
          } else if (state is AllRequestLoadedSuccessfullyState) {
            return allTherapistListBody(context);
          }
          return allTherapistListBody(context);
        },
      ),
    );
  }

  Widget allTherapistListBody(
    BuildContext context,
  ) {
    DoctorEmploymentRequestsCubit doctorEmploymentRequestsCubit =
        context.read<DoctorEmploymentRequestsCubit>();
    List<DoctorEmploymentRequestModel> doctorEmploymentRequestsList =
        doctorEmploymentRequestsCubit.doctorEmploymentRequests ?? [];

    return customRefreshIndicator(
      () async {
        doctorEmploymentRequestsCubit.getAllDoctorEmploymentRequests(
            fromRefreshIndicator: true);
      },
      Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: doctorEmploymentRequestsList.isEmpty
                  ? noEmploymentRequests()
                  : Column(children: [
                      ...List.generate(
                          doctorEmploymentRequestsList.length,
                          (index) => doctorEmploymentCard(
                              context, doctorEmploymentRequestsList[index])),
                      const SizedBox(
                        height: 50,
                      ),
                    ]),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox noEmploymentRequests() {
    return SizedBox(
      height: responsiveUtil.screenHeight * .7,
      child: Center(
        child: buildNoElementInPage(
          'No Requests Right Now. Please Check Back Later!',
          Icons.hourglass_empty_rounded,
        ),
      ),
    );
  }
}
