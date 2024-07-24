import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block/bloc/block_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class BlockScreen extends StatefulWidget {
  const BlockScreen({super.key});

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  late BlockBloc blockBloc;
  @override
  void initState() {
    blockBloc = context.read<BlockBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlockBloc, BlockState>(
      listener: (context, state) {
        if (state is BlockInitial) {
          print('Bloc page init state');
        } else if (state is BlocFauilerState) {
          customSnackBar(state.errorMessage, context, isFloating: true);
        }
      },
      child: Scaffold(
        backgroundColor: customColors.primaryBackGround,
        body: BlocBuilder<BlockBloc, BlockState>(
          builder: (context, state) {
            return Center(
                child: Text(
              userStatus.name,
              style: customTextStyle.bodyMedium,
            ));
          },
        ),
      ),
    );
  }
}
