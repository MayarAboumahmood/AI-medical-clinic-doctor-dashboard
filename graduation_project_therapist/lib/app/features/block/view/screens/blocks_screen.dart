import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block/bloc/block_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block/data_source/models/all_blocked_patient_model.dart';
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
        } else if (state is BlocFauilerState) {
          customSnackBar(state.errorMessage, context, isFloating: true);
        }
      },
      child: Scaffold(
        appBar:
            appBarPushingScreens("Blocked Patient List", isFromScaffold: true),
        backgroundColor: customColors.primaryBackGround,
        body: BlocBuilder<BlockBloc, BlockState>(
          builder: (context, state) {
            if (state is GetAllBlocedPatientState) {
              return blockedPatientListBody(
                  context, blockBloc.allBlockedPatientModel);
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: smallSizeCardShimmer(),
            );
          },
        ),
      ),
    );
  }

  RefreshIndicator blockedPatientListBody(
      BuildContext context, AllBlockedPatientModel allBlockedPatientModel) {
    return customRefreshIndicator(
        refreshPatientRequests,
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
                                isFromBlock: true,
                                context,
                                GetPatientsModel(
                                    id: allBlockedPatientModel.data[index].id,
                                    name: allBlockedPatientModel
                                        .data[index].patientName))),
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
    blockBloc.add(GetAllBlocedPatientEvent());
  }
}
