import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/cubit/medical_description_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/data_source/models/all_medical_records_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/view/widgets/medical_description_card.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/custom_refress_indicator.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/no_element_in_page.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/loadin_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class MedicalDescriptionsList extends StatefulWidget {
  const MedicalDescriptionsList({super.key});

  @override
  State<MedicalDescriptionsList> createState() =>
      _MedicalDescriptionsListState();
}

class _MedicalDescriptionsListState extends State<MedicalDescriptionsList> {
  late MedicalDescriptionCubit medicalDescriptionCubit;
  late int patientID;
  @override
  void initState() {
    super.initState();
    medicalDescriptionCubit = context.read<MedicalDescriptionCubit>();
  }

  bool firstTimeDidChange = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstTimeDidChange) {
      firstTimeDidChange = false;
      final int argument =
          ModalRoute.of(context)!.settings.arguments as int? ?? 1;
      patientID = argument;
      medicalDescriptionCubit.getAllMedicalDescription(patientID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Visibility(
          visible: isDoctor,
          child: FloatingActionButton.extended(
              backgroundColor: customColors.primary,
              onPressed: () {
                navigationService.navigateTo(medicalDescriptionPage);
              },
              label: Text(
                'Add'.tr(),
                style: customTextStyle.bodyMedium,
              )),
        ),
        backgroundColor: customColors.primaryBackGround,
        appBar:
            appBarPushingScreens('Medical descriptions', isFromScaffold: true),
        body: BlocConsumer<MedicalDescriptionCubit, MedicalDescriptionState>(
          listener: (context, state) {
            if (state is GetAllMedicalDescriptionsErrorState) {
              customSnackBar(state.errorMessage, context);
            }
          },
          builder: (context, state) {
            if (state is GetAllMedicalDescriptionsSuccessState) {
              return listOfMedicalRecords(state.allMedicalDescriptions);
            }
            return mediumSizeCardShimmer();
          },
        ));
  }

  Widget listOfMedicalRecords(
      List<AllMedicalRecordsModel> allMedicalDescriptions) {
    return customRefreshIndicator(
      () async {
        medicalDescriptionCubit.getAllMedicalDescription(patientID);
      },
      Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: allMedicalDescriptions.isEmpty
                  ? SizedBox(
                      height: responsiveUtil.screenHeight * .7,
                      child: Center(
                        child: buildNoElementInPage(
                            'No medical description available for this patient yet.',
                            Icons.hourglass_empty_rounded),
                      ),
                    )
                  : Column(
                      children: List.generate(
                          allMedicalDescriptions.length,
                          (index) => medicalDescriptionCard(
                              allMedicalDescriptions[index], patientID)),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
