import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/cubit/get_all_therapist_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/cubit/get_all_therapist_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/view/widgets/my_therapist_toassign_card.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/no_element_in_page.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/loadin_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

void showTherapistsDialog(BuildContext context, int patientID) {
  GetAllTherapistCubit getAllTherapistCubit =
      context.read<GetAllTherapistCubit>();
  getAllTherapistCubit.getMyTherapist(patientID, fromRefreshIndicator: true);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: customColors.secondaryBackGround,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Choose one of your therapists:'.tr(),
                    maxLines: 2,
                    style: customTextStyle.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 5,
                    width: responsiveUtil.screenWidth,
                    color: customColors.primaryBackGround,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: responsiveUtil.screenHeight * .5,
                    child: BlocConsumer<GetAllTherapistCubit,
                        GetAllTherapistState>(
                      listener: (context, state) {
                        if (state is MyTherapistErrorState) {
                          customSnackBar(state.errorMessage, context);
                        }
                      },
                      builder: (context, state) {
                        print('state state state state state :$state');
                        if (state is MyTherapistLoadingState) {
                          return smallSizeCardShimmer();
                        } else if (state is MyTherapistLoadedState) {
                          return (getAllTherapistCubit
                                      .getMyTherapistModels?.isEmpty ??
                                  true)
                              ? Center(
                                  child: buildNoElementInPage(
                                    "You don't have any therapist yet.",
                                    Icons.hourglass_empty_rounded,
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(
                                      getAllTherapistCubit
                                              .getMyTherapistModels?.length ??
                                          0,
                                      (index) => myTherapistToAssignCard(
                                          context,
                                          getAllTherapistCubit
                                              .getMyTherapistModels![index]),
                                    ),
                                  ),
                                );
                        }
                        return smallSizeCardShimmer();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
