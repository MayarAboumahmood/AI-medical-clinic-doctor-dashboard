import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/data_source/models/get_therapists_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/veiw/widgets/all_therapist_card.dart';
import 'package:graduation_project_therapist_dashboard/app/features/my_therapist/cubit/get_my_therapist_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/my_therapist/cubit/get_my_therapist_state.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
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
    GetMyTherapistCubit getAllTherapistCubit =
        context.read<GetMyTherapistCubit>();
    getAllTherapistCubit.getMyTherapist();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: customColors.primary,
          onPressed: () {},
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
      body: BlocConsumer<GetMyTherapistCubit, GetMyTherapistState>(
        listener: (context, state) {
          if (state is MyTherapistErrorState) {
            print('the state is: $state');
            customSnackBar(state.errorMessage, context);
          } else if (state is TherapistRemovedSuccessfullyState) {
            customSnackBar(
                'The Therapist has been removed Successfully', context);
          }
        },
        builder: (context, state) {
          if (state is MyTherapistLoadingState) {
            return mediumSizeCardShimmer();
          } else if (state is MyTherapistLoadedState) {
            return myTherapistListBody(context);
          } else if (state is SearchOnMyTherapistState) {
            return myTherapistListBody(context);
          }
          return myTherapistListBody(context);
        },
      ),
    );
  }

  SingleChildScrollView myTherapistListBody(
    BuildContext context,
  ) {
    GetMyTherapistCubit getMyTherapistCubit =
        context.read<GetMyTherapistCubit>();
    List<GetTherapistModel> getTherapistModels =
        _isSearching && getMyTherapistCubit.state is SearchOnMyTherapistState
            ? getMyTherapistCubit.searchedTherapistModels
            : getMyTherapistCubit.getTherapistModels;

    return SingleChildScrollView(
      child: Column(children: [
        ...List.generate(
            getTherapistModels.length,
            (index) =>
                allTherapistCard(context, getTherapistModels[index], false)),
        const SizedBox(
          height: 50,
        ),
      ]),
    );
  }
}
