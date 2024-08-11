import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block/data_source/models/all_blocked_patient_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block/repository/block_repository_imp.dart';
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
        emit(BlocFauilerState(errorMessage: onError));
      }, (data) {
        emit(BlockPatientSuccessState());
      });
    });
    on<UnBlocPatientEvent>((event, emit) async {
      emit(UnBlocedPatientLoadingState());
      final getData = await blockRepositoryImp.unBlockPatient(event.patientId);
      getData.fold((onError) {
        emit(BlocFauilerState(errorMessage: onError));
      }, (data) {
        emit(UnBlockPatientSuccessState(
            blockedPatientName: event.blockedPatientName));
      });
    });
    on<GetAllBlocedPatientEvent>((event, emit) async {
      emit(BlocedPatientLoadingState());
      final getData = await blockRepositoryImp.getAllBlocedPatientEvent();
      getData.fold((onError) {
        emit(BlocFauilerState(errorMessage: onError));
      }, (data) {
        allBlockedPatientModel = data;
        emit(GetAllBlocedPatientState());
      });
    });
  }
}
