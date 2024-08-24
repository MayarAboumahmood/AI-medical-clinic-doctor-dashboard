import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class GetMyTherapistPage extends StatefulWidget {
  const GetMyTherapistPage({super.key});

  @override
  State<GetMyTherapistPage> createState() => _GetMyTherapistPageState();
}

class _GetMyTherapistPageState extends State<GetMyTherapistPage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GetAllTherapistCubit getAllTherapistCubit =
        context.read<GetAllTherapistCubit>();
    getAllTherapistCubit.getMyTherapist(-10);
    return Scaffold(
      backgroundColor: customColors.primaryBackGround,
      appBar: appBarPushingScreensForSearch(
        'My Therapists',
        isFromScaffold: true,
        isSearching: _isSearching,
        searchController: _searchController,
        onSearchIconPressed: () {
          setState(() {
            _isSearching = true;
          });
        },
        onSearchChange: (searchWord) {
          getAllTherapistCubit.searchOnMyTherapist(searchWord);
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
          if (state is MyTherapistErrorState) {
            print('the state is: $state');
            customSnackBar(state.errorMessage, context, isFloating: true);
          } else if (state is TherapistRemovedSuccessfullyState) {
            customSnackBar(
                'The Therapist has been removed Successfully', context,
                isFloating: true);
          }
        },
        builder: (context, state) {
          if (state is MyTherapistLoadingState) {
            return mediumSizeCardShimmer();
          } else if (state is MyTherapistLoadedState) {
            return myTherapistListBody(context);
          } else if (state is SearchOnMyTherapistState) {
            return myTherapistListBody(context);
          } else if (state is TherapistRemovedSuccessfullyState) {
            return myTherapistListBody(context);
          }
          return myTherapistListBody(context);
        },
      ),
    );
  }

  Widget myTherapistListBody(
    BuildContext context,
  ) {
    GetAllTherapistCubit getMyTherapistCubit =
        context.read<GetAllTherapistCubit>();
    List<GetTherapistModel> getTherapistModels =
        _isSearching && getMyTherapistCubit.state is SearchOnMyTherapistState
            ? getMyTherapistCubit.searchedMyTherapistModels
            : getMyTherapistCubit.getMyTherapistModels ?? [];

    return customRefreshIndicator(
      () async {
        //here i send -10 becase I don't need a quary argument with the request because here I want all the therapist I have/ and when I send the patient id than I want my therapist that I can assign this patient to them.
        getMyTherapistCubit.getMyTherapist(-10, fromRefreshIndicator: true);
      },
      SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            getTherapistModels.isEmpty
                ? SizedBox(
                    height: responsiveUtil.screenHeight * .7,
                    child: Center(
                      child: buildNoElementInPage(
                        _isSearching
                            ? "No result!"
                            : "You don't have any therapist yet.",
                        Icons.hourglass_empty_rounded,
                      ),
                    ),
                  )
                : Column(children: [
                    ...List.generate(
                        getTherapistModels.length,
                        (index) => allTherapistCard(
                            context, getTherapistModels[index], false)),
                    const SizedBox(
                      height: 50,
                    ),
                  ]),
          ],
        ),
      ),
    );
  }
}
