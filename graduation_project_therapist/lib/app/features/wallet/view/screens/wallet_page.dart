import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_string/app_string.dart';
import 'package:graduation_project_therapist_dashboard/app/features/wallet/cubit/wallet_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late WalletCubit walletCubit;
  @override
  void dispose() {
    super.dispose();
    walletCubit.amountTextController.dispose();
  }

  @override
  void initState() {
    super.initState();
    walletCubit = context.read<WalletCubit>();
    walletCubit.amountTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    walletCubit.getTransactionHistory();
    walletCubit.getAvailableFunds();
    return BlocListener<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state is WalletRequestToGetMoneyErrorState) {
          customSnackBar(state.errorMessage, context);
        } else if (state is WalletGetHistoryErrorState) {
          customSnackBar(state.errorMessage, context);
        } else if (state is WalletRequestToGetMoneySuccessfullyState) {
          walletCubit.amountTextController.clear();
          customSnackBar(
              'We have received your request. An administrator will contact you shortly.',
              context);
        }
      },
      child: Scaffold(
        appBar: appBarPushingScreens('Wallet', isFromScaffold: true),
        backgroundColor: customColors.primaryBackGround,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              moneyDescriptionForUser(),
              const SizedBox(
                height: 15,
              ),
              amountTextFieldSubmitButton(context),
              const SizedBox(height: 20),
              BlocBuilder<WalletCubit, WalletState>(
                builder: (context, state) {
                  String availableFunds = 'Loading...'.tr();
                  if (state is WalletGetAvailableFundsLoadingState) {
                    availableFunds = 'Loading...'.tr();
                  } else if (state is WalletAvailableFundsSuccessfullyState) {
                    availableFunds = '${state.availableFunds} ${'SP'.tr()}';
                  } else if (state is WalletAvailableFundsErrorState) {
                    availableFunds = 'Opps, Error'.tr();
                  }
                  return Text(
                    '${'Remaining Balance:'.tr()} $availableFunds ',
                    style: customTextStyle.bodyLarge,
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customDivider(),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('Transaction history'.tr(),
                      style: customTextStyle.bodyLarge),
                  const SizedBox(
                    height: 5,
                  ),
                  customDivider(),
                ],
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(children: [
                ...List.generate(
                    45,
                    (index) =>
                        Text('whatejklf ', style: customTextStyle.bodyMedium))
              ])))
            ],
          ),
        ),
      ),
    );
  }

  Divider customDivider() {
    return Divider(
      thickness: 3,
      color: customColors.secondaryBackGround,
    );
  }

  Form amountTextFieldSubmitButton(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: walletCubit.amountTextController,
              style: customTextStyle.bodyMedium,
              validator: (value) {
                return ValidationFunctions.isValidAmountOfMoney(value);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: customColors
                          .primary, // Set the desired focus border color here
                      width: 2.0, // Set the desired border width here
                    ),
                  ),
                  labelText: 'Enter amount'.tr(),
                  labelStyle: customTextStyle.bodyMedium
                      .copyWith(color: customColors.secondaryText)),
            ),
          ),
          const SizedBox(width: 10),
          BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
              bool isLoading = state is WalletRequestToGetMoneyLoadingState;
              return GeneralButtonOptions(
                onPressed: () {
                  FormState? formdata = formKey.currentState;
                  if (formdata!.validate()) {
                    formdata.save();
                    walletCubit.makeRequestToGetMoney();
                  }
                },
                options: ButtonOptions(
                    textStyle: customTextStyle.bodyMedium,
                    color: customColors.primary),
                text: 'Submit',
                loading: isLoading,
              );
            },
          ),
        ],
      ),
    );
  }

  Column moneyDescriptionForUser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.moneyDescriptionForUser1.tr(),
          style: customTextStyle.bodySmall
              .copyWith(color: customColors.secondaryText),
        ),
        Text(
          AppString.moneyDescriptionForUser2.tr(),
          style: customTextStyle.bodySmall
              .copyWith(color: customColors.secondaryText),
        ),
        Text(
          AppString.moneyDescriptionForUser3.tr(),
          style: customTextStyle.bodySmall
              .copyWith(color: customColors.secondaryText),
        ),
      ],
    );
  }
}
