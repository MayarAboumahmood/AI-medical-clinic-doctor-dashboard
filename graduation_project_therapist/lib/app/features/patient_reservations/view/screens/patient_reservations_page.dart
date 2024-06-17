import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/cubit/patient_reservations_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/data_source/models/patient_reservation_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/view/widgets/patient_reservations_card.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/loadin_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class PatientReservationsPage extends StatefulWidget {
  const PatientReservationsPage({super.key});

  @override
  State<PatientReservationsPage> createState() =>
      _PatientReservationsPageState();
}

class _PatientReservationsPageState extends State<PatientReservationsPage> {
  late PatientReservationsCubit patientReservationsCubit;

  @override
  void initState() {
    super.initState();
    patientReservationsCubit = context.read<PatientReservationsCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      patientReservationsCubit.getPatientReservations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientReservationsCubit, PatientReservationsState>(
      listener: (context, state) {
        if (state is PatientReservationErrorState) {
          customSnackBar(state.errorMessage, context);
        } else if (state is PatientReservationApprovedSuccessfullyState) {
          customSnackBar('session confirmed Successfully', context);
        } else if (state is PatientReservationCanceledSuccessfullyState) {
          customSnackBar('session rejected Successfully', context);
        }
      },
      child: patientReservationssPage(context),
    );
  }

  Scaffold patientReservationssPage(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: customColors.primaryBackGround,
      appBar:
          appBarPushingScreens('Patient Reservations', isFromScaffold: true),
      body: BlocBuilder<PatientReservationsCubit, PatientReservationsState>(
        builder: (context, state) {
          if (state is PatientReservationsLoadingState) {
            return mediumSizeCardShimmer();
          } else if (state is PatientReservationDataLoadedState) {
            return patientReservationssListBody(
                context, state.patientReservationModels);
          } else if (state is PatientReservationApprovedSuccessfullyState ||
              state is PatientReservationCanceledSuccessfullyState) {
            return patientReservationssListBody(
                context, patientReservationsCubit.cachedPatientReservations);
          }
          return mediumSizeCardShimmer();
        },
      ),
    );
  }

  SingleChildScrollView patientReservationssListBody(BuildContext context,
      List<PatientReservationModel> patientReservationsModels) {
    return SingleChildScrollView(
      child: Column(children: [
        ...List.generate(
            patientReservationsModels.length,
            (index) => patientReservationCard(
                context, patientReservationsModels[index])),
        const SizedBox(
          height: 50,
        ),
      ]),
    );
  }
}
