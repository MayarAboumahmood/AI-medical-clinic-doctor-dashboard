import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/doctor_employment_requests/cubit/doctor_employment_requests_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/doctor_employment_requests/data_source/models/doctor_employment_request_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget doctorEmploymentCard(BuildContext context,
    DoctorEmploymentRequestModel doctorEmploymentRequestModel) {
  final DoctorEmploymentRequestsCubit doctorEmploymentRequestsCubit =
      context.read<DoctorEmploymentRequestsCubit>();
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
          buildDoctorRequestName(doctorEmploymentRequestModel),
          const SizedBox(height: 10),
          Text(
              '${'Clinic Name:'.tr()} ${doctorEmploymentRequestModel.clinicName}',
              style: customTextStyle.bodyMedium),
          const SizedBox(height: 10),
          Text('${'Date:'.tr()} ${doctorEmploymentRequestModel.date}',
              style: customTextStyle.bodyMedium),
          const SizedBox(height: 10),
          Row(
            children: [
              BlocBuilder<DoctorEmploymentRequestsCubit,
                  DoctorEmploymentRequestsState>(
                builder: (context, state) {
                  bool isLoading = state is ApproveDoctorRequestsLoadingState &&
                      doctorEmploymentRequestsCubit.requestID ==
                          doctorEmploymentRequestModel.id;
                  return Row(
                    children: [
                      responseButton(
                          doctorEmploymentRequestsCubit,
                          doctorEmploymentRequestModel,
                          true,
                          isLoading &&
                              (doctorEmploymentRequestsCubit.isApproveClicked ??
                                  false)),
                      SizedBox(width: responsiveUtil.screenWidth * .1),
                      responseButton(
                          doctorEmploymentRequestsCubit,
                          doctorEmploymentRequestModel,
                          false,
                          isLoading &&
                              !(doctorEmploymentRequestsCubit
                                      .isApproveClicked ??
                                  false)),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

GeneralButtonOptions responseButton(
    DoctorEmploymentRequestsCubit doctorEmploymentRequestsCubit,
    DoctorEmploymentRequestModel doctorEmploymentRequestModel,
    bool status,
    bool isLoading) {
  return GeneralButtonOptions(
      text: status ? "Approve".tr() : "Decline".tr(),
      onPressed: () {
        if (status) {
          doctorEmploymentRequestsCubit
              .approveDoctorRequest(doctorEmploymentRequestModel.id);
        } else {
          doctorEmploymentRequestsCubit
              .declineDoctorRequest(doctorEmploymentRequestModel.id);
        }
      },
      loading: isLoading,
      options: ButtonOptions(
          color: status ? customColors.primary : customColors.error,
          textStyle: customTextStyle.bodyMedium.copyWith(color: Colors.white)));
}

GestureDetector buildDoctorRequestName(
    DoctorEmploymentRequestModel doctorEmploymentRequestModel) {
  return GestureDetector(
    onTap: () {

    },
    child: Text(
        doctorEmploymentRequestModel.doctorName
            .toString(),
        style: customTextStyle.bodyLarge),
  );
}
