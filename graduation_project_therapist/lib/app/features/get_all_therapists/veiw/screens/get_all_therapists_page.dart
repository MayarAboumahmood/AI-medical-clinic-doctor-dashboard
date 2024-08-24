import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/cubit/get_all_therapist_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/cubit/get_all_therapist_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/data_source/models/get_therapists_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/veiw/widgets/all_therapist_card.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/custom_refress_indicator.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/no_element_in_page.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/loadin_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class GetAllTherapistPage extends StatefulWidget {
  const GetAllTherapistPage({super.key});

  @override
  State<GetAllTherapistPage> createState() => _GetAllTherapistPageState();
}

class _GetAllTherapistPageState extends State<GetAllTherapistPage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  late GetAllTherapistCubit getAllTherapistCubit;
  @override
  void initState() {
    super.initState();
    getAllTherapistCubit = context.read<GetAllTherapistCubit>();
    getAllTherapistCubit.getAllTherapist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: customColors.primary,
          onPressed: () {
            navigationService.navigateTo(getMyTherapistPage);
          },
          label: Text(
            'My Therapists'.tr(),
            style: customTextStyle.bodyMedium,
          )),
      backgroundColor: customColors.primaryBackGround,
      appBar: appBarPushingScreensForSearch(
        'All Therapist',
        isFromScaffold: true,
        isSearching: _isSearching,
        searchController: _searchController,
        onSearchIconPressed: () {
          setState(() {
            _isSearching = true;
          });
        },
        onSearchChange: (searchWord) {
          getAllTherapistCubit.searchOnAllTherapist(searchWord);
        },
        onSearchCanceled: () {
          setState(() {
            _isSearching = false;
            _searchController.clear();
          });
        },
      ),
      body: BlocConsumer<GetAllTherapistCubit, GetAllTherapistState>(
        listener: (context, state) {
          if (state is AllTherapistErrorState) {
            print('the state is: $state');
            customSnackBar(state.errorMessage, context, isFloating: true);
          } else if (state is AssignTherapistSuccessfullyState) {
            customSnackBar(
                'The Therapist has been assigned Successfully', context,
                isFloating: true);
          }
        },
        builder: (context, state) {
          print('the state is: $state');
          if (state is AllTherapistLoadingState) {
            return mediumSizeCardShimmer();
          } else if (state is AllTherapistLoadedState ||
              state is AssignTherapistSuccessfullyState) {
            return allTherapistListBody(context);
          } else if (state is SearchOnAllTherapistState) {
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
    GetAllTherapistCubit getAllTherapistCubit =
        context.read<GetAllTherapistCubit>();
    List<GetTherapistModel> getTherapistModels =
        _isSearching && getAllTherapistCubit.state is SearchOnAllTherapistState
            ? getAllTherapistCubit.searchedAllTherapistModels
            : getAllTherapistCubit.getAllTherapistModels ?? [];

    return customRefreshIndicator(
      () async {
        getAllTherapistCubit.getAllTherapist(fromRefreshIndicator: true);
      },
      getTherapistModels.isEmpty
          ? SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: responsiveUtil.screenHeight * .7,
                    child: Center(
                      child: buildNoElementInPage(
                        _isSearching
                            ? "No result!"
                            : 'No Therapist in the platform yet.',
                        Icons.hourglass_empty_rounded,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(children: [
                ...List.generate(
                    getTherapistModels.length,
                    (index) => allTherapistCard(
                        context, getTherapistModels[index], true)),
                const SizedBox(
                  height: 50,
                ),
              ]),
            ),
    );
  }
}
