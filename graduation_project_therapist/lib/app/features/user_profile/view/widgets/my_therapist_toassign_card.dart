import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/data_source/models/get_therapists_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/cubit/user_profile_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/image_widgets/network_image.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget myTherapistToAssignCard(
    BuildContext context, GetTherapistModel getTherapistModel) {
  return Card(
    color: customColors.secondaryBackGround,
    child: ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: getImageNetwork(
          forProfileImage: true,
          url: getTherapistModel.specialistProfile.photo,
          width: 50,
          height: 50,
        ),
      ),
      trailing: getTherapistModel.status
          ? Text(
              'Already assign'.tr(),
              style: customTextStyle.bodyMedium,
            )
          : assignButton(context, getTherapistModel.id),
      title: Text(
        getTherapistModel.specialistProfile.fullName,
        style: customTextStyle.bodyLarge,
      ),
      subtitle: Text(
        getTherapistModel.specialistProfile.specInfo,
        style: customTextStyle.bodyMedium,
      ),
    ),
  );
}

Widget assignButton(BuildContext context, int therapistID) {
  return GestureDetector(
    onTap: () {
      context.read<UserProfileCubit>().assignPatientToTherapist(therapistID);
      navigationService.goBack();
    },
    child: Container(
      decoration: BoxDecoration(
          color: customColors.primary, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Text('Assign'.tr(), style: customTextStyle.bodySmall),
      ),
    ),
  );
}
