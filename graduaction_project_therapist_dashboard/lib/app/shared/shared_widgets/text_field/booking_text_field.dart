import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class ConfirmBookingTextField extends StatefulWidget {
  final String initValue;
  final String prefixText;
  final String? labelText;
  final IconData? suffixIcon;
  final double? height;
  final int position;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const ConfirmBookingTextField(
      {super.key,
      required this.initValue,
      required this.validator,
      required this.prefixText,
      this.height,
      this.labelText,
      this.suffixIcon,
      this.position = 0,
      required this.controller,
      required this.textInputType});

  @override
  // ignore: library_private_types_in_public_api
  _ConfirmBookingTextField createState() => _ConfirmBookingTextField();
}

class _ConfirmBookingTextField extends State<ConfirmBookingTextField> {
  late FocusNode _focusNode;
  late bool _isEditing;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _isEditing = widget.suffixIcon != null ? false : true;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      keyboardType: widget.textInputType,
      style: customTextStyle.bodyMedium
          .copyWith(color: customColors.primary, fontWeight: FontWeight.bold),
      controller: widget.controller,
      focusNode: _focusNode,
      readOnly: !_isEditing,
      cursorColor: customColors.primary,
      maxLines: null,
      decoration: buildInputDecoration(),
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      labelText: widget.labelText?.tr(),
      labelStyle:
          customTextStyle.bodySmall.copyWith(color: customColors.secondaryText),
      contentPadding: EdgeInsets.symmetric(
        vertical: widget.height ?? 10, // Default height is 10
        horizontal: 14.0,
      ),
      focusColor: customColors.secondaryText,
      hoverColor: customColors.secondaryText,
      border: borderInfo(),
      focusedBorder: focuseBorderInfo(),
      enabledBorder: enableBorderInfo(),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(14.0),
        child: prefixTextWidget(),
      ),
      suffixIcon:
          widget.suffixIcon != null ? suffixIconButton() : const SizedBox(),
    );
  }

  Text prefixTextWidget() {
    return Text(
      widget.prefixText.tr(),
      style: customTextStyle.bodyMedium.copyWith(
          color: customColors.secondaryText, fontWeight: FontWeight.bold),
    );
  }

  IconButton suffixIconButton() {
    return IconButton(
      icon: Icon(widget.suffixIcon, color: customColors.secondaryText),
      onPressed: () {
        setState(() {
          _isEditing = !_isEditing;
          if (_isEditing) {
            _focusNode.requestFocus();
          }
        });
      },
    );
  }

  OutlineInputBorder enableBorderInfo() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.position == 1 ? 10 : 0),
          topRight: Radius.circular(widget.position == 1 ? 10 : 0),
          bottomLeft: Radius.circular(widget.position == -1 ? 10 : 0),
          bottomRight: Radius.circular(widget.position == -1
              ? 10
              : 0)), // Adjust the border radius as needed
      borderSide: BorderSide(color: customColors.secondaryBackGround),
    );
  }

  OutlineInputBorder focuseBorderInfo() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.position == 1 ? 10 : 0),
          topRight: Radius.circular(widget.position == 1 ? 10 : 0),
          bottomLeft: Radius.circular(widget.position == -1 ? 10 : 0),
          bottomRight: Radius.circular(widget.position == -1
              ? 10
              : 0)), // Adjust the border radius as needed
      borderSide: BorderSide(color: customColors.secondaryBackGround),
    );
  }

  OutlineInputBorder borderInfo() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.position == 1 ? 10 : 0),
          topRight: Radius.circular(widget.position == 1 ? 10 : 0),
          bottomLeft: Radius.circular(widget.position == -1 ? 10 : 0),
          bottomRight: Radius.circular(widget.position == -1 ? 10 : 0)),
      borderSide: BorderSide(color: customColors.secondaryBackGround),
    );
  }
}
