import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class ButtonOptions {
  const ButtonOptions({
    this.textStyle,
    this.textShadows,
    this.elevation,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.disabledColor,
    this.disabledTextColor,
    this.splashColor,
    this.iconSize,
    this.iconColor,
    this.iconPadding,
    this.borderRadius,
    this.borderSide,
    this.hoverColor,
    this.hoverBorderSide,
    this.hoverTextColor,
    this.hoverElevation,
    this.maxLines,
  });
  final List<Shadow>? textShadows;
  final TextStyle? textStyle;
  final double? elevation;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final int? maxLines;
  final Color? splashColor;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry? iconPadding;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final Color? hoverColor;
  final BorderSide? hoverBorderSide;
  final Color? hoverTextColor;
  final double? hoverElevation;
}

// ignore: must_be_immutable
class GeneralButtonOptions extends StatefulWidget {
  GeneralButtonOptions(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.icon,
      this.iconData,
      required this.options,
      this.showLoadingIndicator = false,
      this.loading = false})
      : super(key: key);

  final String text;
  final Widget? icon;
  final IconData? iconData;
  final Function()? onPressed;
  final ButtonOptions options;
  final bool showLoadingIndicator;
  bool loading = false;

  @override
  State<GeneralButtonOptions> createState() => _GeneralButtonOptionsState();
}

class _GeneralButtonOptionsState extends State<GeneralButtonOptions> {
  int get maxLines => widget.options.maxLines ?? 1;

  @override
  Widget build(BuildContext context) {
    Widget textWidget = widget.loading
        ? Center(
            child: SizedBox(
              width: 23,
              height: 23,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.options.textStyle?.color ?? Colors.white,
                ),
              ),
            ),
          )
        : Text(
            widget.text.tr(),
            style: widget.options.textStyle
                ?.withoutColor()
                .copyWith(shadows: widget.options.textShadows),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          );

    final onPressed = widget.onPressed != null
        ? (widget.showLoadingIndicator
            ? () async {
                if (widget.loading) {
                  return;
                }
                setState(() => widget.loading = true);
                try {
                  await widget.onPressed!();
                } finally {
                  if (mounted) {
                    setState(() => widget.loading = false);
                  }
                }
              }
            : () => widget.onPressed!())
        : null;

    ButtonStyle style = ButtonStyle(
      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
        (states) {
          if (states.contains(MaterialState.hovered) &&
              widget.options.hoverBorderSide != null) {
            return RoundedRectangleBorder(
              borderRadius:
                  widget.options.borderRadius ?? BorderRadius.circular(8),
              side: widget.options.hoverBorderSide!,
            );
          }
          return RoundedRectangleBorder(
            borderRadius:
                widget.options.borderRadius ?? BorderRadius.circular(8),
            side: widget.options.borderSide ?? BorderSide.none,
          );
        },
      ),
      shadowColor: MaterialStateProperty.all<Color?>(customColors.shadow),

      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.disabled) &&
              widget.options.disabledTextColor != null) {
            return widget.options.disabledTextColor;
          }
          if (states.contains(MaterialState.hovered) &&
              widget.options.hoverTextColor != null) {
            return widget.options.hoverTextColor;
          }
          return widget.options.textStyle?.color;
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.disabled) &&
              widget.options.disabledColor != null) {
            return widget.options.disabledColor;
          }
          if (states.contains(MaterialState.hovered) &&
              widget.options.hoverColor != null) {
            return widget.options.hoverColor;
          }
          return widget.options.color;
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.pressed)) {
          return widget.options.splashColor;
        }
        return null;
      }),
      padding: MaterialStateProperty.all(widget.options.padding ??
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0)),
      elevation: MaterialStateProperty.resolveWith<double?>(
        (states) {
          if (states.contains(MaterialState.hovered) &&
              widget.options.hoverElevation != null) {
            return widget.options.hoverElevation!;
          }
          return widget.options.elevation;
        },
      ),

      // shadowColor:
      //     MaterialStateProperty.all(customColors.shadow), // Add shadow color here
    );

    if ((widget.icon != null || widget.iconData != null) && !widget.loading) {
      return SizedBox(
        height: widget.options.height,
        width: widget.options.width,
        child: ElevatedButton.icon(
          icon: Padding(
            padding: widget.options.iconPadding ?? EdgeInsets.zero,
            child: widget.icon ??
                FaIcon(
                  widget.iconData,
                  size: widget.options.iconSize,
                  color: widget.options.iconColor ??
                      widget.options.textStyle!.color,
                ),
          ),
          label: textWidget,
          onPressed: onPressed,
          style: style,
        ),
      );
    }

    return SizedBox(
      height: widget.options.height,
      width: widget.options.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: textWidget,
      ),
    );
  }
}

extension _WithoutColorExtension on TextStyle {
  TextStyle withoutColor() => TextStyle(
        inherit: inherit,
        color: null,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        // The _package field is private so unfortunately we can't set it here,
        // but it's almost always unset anyway.
        // package: _package,
        overflow: overflow,
      );
}
