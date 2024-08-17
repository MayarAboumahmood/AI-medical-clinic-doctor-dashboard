import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/view/widgets/block_patient_listener.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/cubit/get_patients_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/cubit/get_patients_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/data_source/models/get_patients_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/veiw/widgets/patients_card.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/custom_refress_indicator.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/no_element_in_page.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/loadin_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class GetPatientsPage extends StatefulWidget {
  const GetPatientsPage({super.key});

  @override
  State<GetPatientsPage> createState() => _GetPatientsPageState();
}

class _GetPatientsPageState extends State<GetPatientsPage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GetPatientsCubit getPatientsCubit = context.read<GetPatientsCubit>();
    getPatientsCubit.getPatients();
    return Scaffold(
      backgroundColor: customColors.primaryBackGround,
      appBar: appBarPushingScreensForSearch(
        'My Patients',
        isFromScaffold: true,
        isSearching: _isSearching,
        searchController: _searchController,
        onSearchIconPressed: () {
          setState(() {
            _isSearching = true;
          });
        },
        onSearchChange: (searchWord) {
          getPatientsCubit.searchOnPatients(searchWord);
        },
        onSearchCanceled: () {
          setState(() {
            _isSearching = false;
            _searchController.clear();
          });
        },
      ),
      body: blockPatientListener(
        getPatientsCubit.getPatients,
        BlocConsumer<GetPatientsCubit, GetPatientsState>(
          listener: (context, state) {
            if (state is PatientsErrorState) {
              print('the state is: $state');
              customSnackBar(state.errorMessage, context, isFloating: true);
            }
          },
          builder: (context, state) {
            if (state is PatientsLoadingState) {
              return mediumSizeCardShimmer();
            } else if (state is PatientsLoadedState) {
              return patientsListBody(context);
            } else if (state is SearchOnPatientsState) {
              return patientsListBody(context);
            }
            return patientsListBody(context);
          },
        ),
      ),
    );
  }

  Widget patientsListBody(
    BuildContext context,
  ) {
    GetPatientsCubit getPatientsCubit = context.read<GetPatientsCubit>();
    List<GetPatientsModel> getpatientsModels =
        _isSearching && getPatientsCubit.state is SearchOnPatientsState
            ? getPatientsCubit.searchedPatientsModels
            : getPatientsCubit.getPatientsModels ?? [];

    return customRefreshIndicator(
      () async {
        getPatientsCubit.getPatients(fromRefreshIndicator: true);
      },
      Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: getpatientsModels.isEmpty
                  ? noPatientWidget()
                  : Column(children: [
                      ...List.generate(
                          getpatientsModels.length,
                          (index) =>
                              patientsCard(context, getpatientsModels[index])),
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

  SizedBox noPatientWidget() {
    return SizedBox(
      height: responsiveUtil.screenHeight * .7,
      child: Center(
        child: buildNoElementInPage(
          _isSearching ? "No result!" : "You don't have any patient yet.",
          Icons.hourglass_empty_rounded,
        ),
      ),
    );
  }
}
