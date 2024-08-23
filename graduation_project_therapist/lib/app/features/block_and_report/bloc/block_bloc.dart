import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/data_source/models/all_blocked_patient_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/repository/block_repository_imp.dart';
import 'package:meta/meta.dart';

part 'block_event.dart';
part 'block_state.dart';

class BlockBloc extends Bloc<BlockEvent, BlockState> {
  BlockRepositoryImp blockRepositoryImp;
  AllBlockedPatientModel? allBlockedPatientModel;
  BlockBloc({required this.blockRepositoryImp}) : super(BlockInitial()) {
    on<BlockEvent>((event, emit) {
      if (state is BlockInitial) {}
    });
    on<BlockPatientEvent>((event, emit) async {
      emit(BlocedPatientLoadingState());
      final getData = await blockRepositoryImp.blockPatient(event.patientId);
      getData.fold((onError) {
        emit(BlockFauilerState(errorMessage: onError));
      }, (data) {
        allBlockedPatientModel = null;
        emit(BlockPatientSuccessState());
      });
    });
    on<UnBlocPatientEvent>((event, emit) async {
      emit(UnBlocedPatientLoadingState());
      final getData = await blockRepositoryImp.unBlockPatient(event.patientId);
      getData.fold((onError) {
        emit(BlockFauilerState(errorMessage: onError));
      }, (data) {
        if (allBlockedPatientModel != null) {
          allBlockedPatientModel!.data
              .removeWhere((patient) => patient.userId == event.patientId);
        }
        emit(UnBlockPatientSuccessState(
            blockedPatientName: event.blockedPatientName));
      });
    });
    on<GetAllBlocedPatientEvent>((event, emit) async {
      if (allBlockedPatientModel == null || event.fromRefreshIndicator) {
        emit(BlocedPatientLoadingState());
        final getData = await blockRepositoryImp.getAllBlocedPatientEvent();
        getData.fold((onError) {
          emit(BlockFauilerState(errorMessage: onError));
        }, (data) {
          allBlockedPatientModel = data;
          emit(GetAllBlocedPatientState());
        });
      } else {
        emit(GetAllBlocedPatientState());
      }
    });
    on<ReportPatientEvent>((event, emit) async {
      // emit(BlocedPatientLoadingState());
      final getData = await blockRepositoryImp.reportPatient(
          event.patientId, event.description);
      getData.fold((onError) {
        emit(ReportFauilerState(errorMessage: onError));
      }, (data) {
        emit(ReportPatientSuccessState());
      });
    });
    on<ReportMedicalDescriptionEvent>((event, emit) async {
      // emit(BlocedPatientLoadingState());
      final getData = await blockRepositoryImp.reportMedicalDescription(
          event.medicalDescriptionId, event.description);
      getData.fold((onError) {
        emit(ReportFauilerState(errorMessage: onError));
      }, (data) {
        emit(ReportMedicalDescriptionSuccessState());
      });
    });
  }
}
