
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block/repository/block_repository_imp.dart';
import 'package:meta/meta.dart';

part 'block_event.dart';
part 'block_state.dart';

class BlockBloc extends Bloc<BlockEvent, BlockState> {
  BlockRepositoryImp blockRepositoryImp;
  BlockBloc({required this.blockRepositoryImp}) : super(BlockInitial()) {
    on<BlockEvent>((event, emit) {
      if (state is BlockInitial) {}
    });
    on<BlocPatientEvent>((event, emit) async {
      final getData = await blockRepositoryImp.blockPatient(event.patientId);
      getData.fold((onError) {
        emit(BlocFauilerState(errorMessage: onError));
      }, (data) {
        emit(BlockPatientSuccessState());
      });
    });
  }
}
