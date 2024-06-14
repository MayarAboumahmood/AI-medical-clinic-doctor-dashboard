import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/cubit/get_all_therapist_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/cubit/get_all_therapist_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/data_source/models/get_therapists_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/my_therapist/cubit/get_my_therapist_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/image_widgets/network_image.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/expanded_description.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget allTherapistCard(BuildContext context,
    GetTherapistModel getTherapistModel, bool isGetAllTherapist) {
  final getAllTherapistCubit = isGetAllTherapist
      ? context.read<GetAllTherapistCubit>()
      : context.read<GetMyTherapistCubit>();
  return Card(
    color: customColors.primaryBackGround,
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTherapistNameAndImage(getTherapistModel),
          const SizedBox(height: 16),
          expandedDescription(
              context, getTherapistModel.specialistProfile.specInfo,
              backGroundColor: Colors.transparent),
          const SizedBox(height: 16),
          Row(
            children: [
              BlocBuilder<GetAllTherapistCubit, GetAllTherapistState>(
                builder: (context, state) {
                  bool isLoading = state is AssignTherapistLoadingState;
                  return GeneralButtonOptions(
                      text: isGetAllTherapist ? "Assign".tr() : 'Remove'.tr(),
                      onPressed: () {
                        if (isGetAllTherapist) {
                          getAllTherapistCubit as GetAllTherapistCubit;
                          getAllTherapistCubit
                              .assignTherapist(getTherapistModel.id);
                        } else {
                          getAllTherapistCubit as GetMyTherapistCubit;
                          getAllTherapistCubit
                              .removeTherapist(getTherapistModel.id);
                        }
                      },
                      loading: isLoading,
                      options: ButtonOptions(
                          color: customColors.primary,
                          textStyle: customTextStyle.bodyMedium
                              .copyWith(color: Colors.white)));
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

GestureDetector buildTherapistNameAndImage(
    GetTherapistModel getTherapistModel) {
  return GestureDetector(
    onTap: () {
      // navigationService.navigateTo(userProfilePage,
      //     arguments: getTherapistModel.id);
    },
    child: Row(
      children: [
        Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: getImageNetwork(
                url: getTherapistModel.specialistProfile.photo,
                width: 65,
                height: 65,
                fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 16),
        Text(getTherapistModel.specialistProfile.fullName,
            style: customTextStyle.bodyLarge),
      ],
    ),
  );
}
