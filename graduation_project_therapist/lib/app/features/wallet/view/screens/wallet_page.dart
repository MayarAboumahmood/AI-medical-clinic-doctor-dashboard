import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_string/app_string.dart';
import 'package:graduation_project_therapist_dashboard/app/features/wallet/cubit/wallet_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: customColors.primary,
        label:
            Text('View Transaction History', style: customTextStyle.bodyMedium),
      ),
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
            amountTextFieldSubmitButton(),
            const SizedBox(height: 20),
            BlocBuilder<WalletCubit, WalletState>(
              builder: (context, state) {
                String remaningAmount = 'Loading...'.tr();
                if (state is WalletGetRemaininAmountLoadingState) {
                  remaningAmount = 'Loading...'.tr();
                } else if (state is WalletRemaininAmountLoadedState) {
                  remaningAmount = state.remainingMoneyAmount;
                } else if (state is WalletRemaininAmountErrorState) {
                  remaningAmount = 'Opps, Error'.tr();
                }
                return Text(
                  '${'Remaining Balance:'.tr()} $remaningAmount ${'SP'.tr()}',
                  style: customTextStyle.bodyLarge,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Form amountTextFieldSubmitButton() {
    return Form(
      key: formKey,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              style: customTextStyle.bodyMedium,
              validator: (value) {
                return ValidationFunctions.isValidAmountOfMoney(value);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Enter amount'.tr(),
                  labelStyle: customTextStyle.bodyMedium
                      .copyWith(color: customColors.secondaryText)),
            ),
          ),
          const SizedBox(width: 10),
          BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
              bool isLoading = state is WalletGetMoneyRequestLoadingState;
              return GeneralButtonOptions(
                onPressed: () {
                  FormState? formdata = formKey.currentState;
                  if (formdata!.validate()) {
                    formdata.save();
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
