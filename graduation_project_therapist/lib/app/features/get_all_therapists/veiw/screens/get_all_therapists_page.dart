import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/cubit/get_all_therapist_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/cubit/get_all_therapist_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/data_source/models/get_therapists_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/veiw/widgets/all_therapist_card.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
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

  @override 
  Widget build(BuildContext context) {
    GetAllTherapistCubit getAllTherapistCubit =
        context.read<GetAllTherapistCubit>();
    getAllTherapistCubit.getAllTherapist();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: customColors.primary,
          onPressed: () {
            navigationService.navigateTo(getMyTherapistPage);
          },
          label: Text(
            'My Therapist',
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
            customSnackBar(state.errorMessage, context);
          } else if (state is AssignTherapistSuccessfullyState) {
            customSnackBar(
                'The Therapist has been assigned Successfully', context);
          }
        },
        builder: (context, state) {
          if (state is AllTherapistLoadingState) {
            return mediumSizeCardShimmer();
          } else if (state is AllTherapistLoadedState) {
            return allTherapistListBody(context);
          } else if (state is SearchOnAllTherapistState) {
            return allTherapistListBody(context);
          }
          return allTherapistListBody(context);
        },
      ),
    );
  }

  SingleChildScrollView allTherapistListBody(
    BuildContext context,
  ) {
    GetAllTherapistCubit getAllTherapistCubit =
        context.read<GetAllTherapistCubit>();
    List<GetTherapistModel> getTherapistModels =
        _isSearching && getAllTherapistCubit.state is SearchOnAllTherapistState
            ? getAllTherapistCubit.searchedTherapistModels
            : getAllTherapistCubit.getTherapistModels;

    return SingleChildScrollView(
      child: Column(children: [
        ...List.generate(
            getTherapistModels.length,
            (index) =>
                allTherapistCard(context, getTherapistModels[index], true)),
        const SizedBox(
          height: 50,
        ),
      ]),
    );
  }
}
