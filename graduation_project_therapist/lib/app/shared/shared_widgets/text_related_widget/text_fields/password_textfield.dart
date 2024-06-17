import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/text_field.dart';

class PasswordTextField extends StatefulWidget {
  final String? Function(String?)? validator;
  final String label;
  final TextEditingController? controller;
  const PasswordTextField(
      {super.key,
      this.validator,
      required this.controller,
      required this.label});
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool passwordSecur = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: customTextField(
                  isPassWordInVisible: passwordSecur,
                  textInputType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    icon: Icon(passwordSecur
                        ? Icons.visibility_off_outlined
                        : Icons.remove_red_eye_outlined),
                    onPressed: () {
                      setState(() {
                        passwordSecur = !passwordSecur;
                      });
                    },
                  ),
                  validator: widget.validator ??
                      (value) {
                        return ValidationFunctions.isStrongPassword(value!);
                      },
                  controller: widget.controller,
                  context: context,
                  label: widget.label.tr()))
        ],
      ),
    );
  }
}
