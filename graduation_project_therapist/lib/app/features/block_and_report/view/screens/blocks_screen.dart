import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/bloc/block_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/data_source/models/all_blocked_patient_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/data_source/models/get_patients_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/veiw/widgets/patients_card.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/custom_refress_indicator.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/no_element_in_page.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/loadin_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class BlockedPatientsScreen extends StatefulWidget {
  const BlockedPatientsScreen({super.key});

  @override
  State<BlockedPatientsScreen> createState() => _BlockedPatientsScreenState();
}

class _BlockedPatientsScreenState extends State<BlockedPatientsScreen> {
  late BlockBloc blockBloc;
  @override
  void initState() {
    blockBloc = context.read<BlockBloc>();
    blockBloc.add(GetAllBlocedPatientEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlockBloc, BlockState>(
      listener: (context, state) {
        if (state is BlockInitial) {
          print('Bloc page init state');
        } else if (state is BlockFauilerState) {
          customSnackBar(state.errorMessage, context, isFloating: true);
        } else if (state is UnBlockPatientSuccessState) {
          customSnackBar(
              '${state.blockedPatientName} Unblocked successfully', context,
              isFloating: true);
          blockBloc.add(GetAllBlocedPatientEvent());
        }
      },
      child: Scaffold(
        appBar:
            appBarPushingScreens("Blocked Patient List", isFromScaffold: true),
        backgroundColor: customColors.primaryBackGround,
        body: BlocBuilder<BlockBloc, BlockState>(
          builder: (context, state) {
            if (state is GetAllBlocedPatientState &&
                blockBloc.allBlockedPatientModel != null) {
              return blockedPatientListBody(
                  context, blockBloc.allBlockedPatientModel!);
            } else if (state is BlocedPatientLoadingState) {
              return blockedShimmer();
            }
            if (blockBloc.allBlockedPatientModel != null) {
              return blockedPatientListBody(
                  context, blockBloc.allBlockedPatientModel!);
            } else {
              return blockedShimmer();
            }
          },
        ),
      ),
    );
  }

  Padding blockedShimmer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: smallSizeCardShimmer(),
    );
  }

  RefreshIndicator blockedPatientListBody(
      BuildContext context, AllBlockedPatientModel allBlockedPatientModel) {
    return customRefreshIndicator(
        refreshBlockedList,
        Column(
          children: [
            Expanded(
              // height: responsiveUtil.screenHeight * .7,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: allBlockedPatientModel.data.isEmpty
                    ? SizedBox(
                        height: responsiveUtil.screenHeight * .7,
                        child: Center(
                          child: buildNoElementInPage(
                            "Your blocked list is currently empty. No patients have been blocked yet.",
                            Icons.block,
                          ),
                        ),
                      )
                    : Column(children: [
                        ...List.generate(
                          allBlockedPatientModel.data.length,
                          (index) => patientsCard(
                              date: getRightDateString(
                                  allBlockedPatientModel.data[index].date),
                              isFromBlock: true,
                              context,
                              GetPatientsModel(
                                id: allBlockedPatientModel.data[index].userId,
                                name: allBlockedPatientModel
                                    .data[index].patientName,
                              )),
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

  String getRightDateString(String dateWithBadFormate) {
    DateTime dateTime = DateTime.parse(dateWithBadFormate);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd h:mm a');

    // Format the DateTime object to the desired format
    String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }

  Future<void> refreshBlockedList() async {
    blockBloc.add(GetAllBlocedPatientEvent(fromRefreshIndicator: true));
  }
}
