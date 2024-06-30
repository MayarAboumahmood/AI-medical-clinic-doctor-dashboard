import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/cubit/get_all_therapist_cubit.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

void therapistRequestToPatientDialog(BuildContext context, int patientID) {
  GetAllTherapistCubit getAllTherapistCubit =
      context.read<GetAllTherapistCubit>();

  getAllTherapistCubit.getMyTherapist(patientID);
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
                  buildChooseDate(context,),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
