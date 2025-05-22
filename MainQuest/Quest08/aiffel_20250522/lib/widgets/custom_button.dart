import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/// A customizable button widget that can be used as a text button with icon,
/// icon-only button, or dropdown button.
///
/// Supports different styles, sizes, and positioning.
class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.text,
    this.onTap,
    this.imagePath,
    this.imagePosition = CustomImagePosition.right,
    this.imageSize,
    this.spacing,
    this.padding,
    this.margin,
    this.alignment,
    this.decoration,
    this.textStyle,
    this.width,
    this.height,
  }) : super(key: key);

  /// Text to display in the button
  final String? text;

  /// Callback function when button is tapped
  final VoidCallback? onTap;

  /// Path to the image to display (if any)
  final String? imagePath;

  /// Position of the image relative to the text (left or right)
  final CustomImagePosition? imagePosition;

  /// Size of the image
  final Size? imageSize;

  /// Spacing between text and image
  final double? spacing;

  /// Padding inside the button
  final EdgeInsetsGeometry? padding;

  /// Margin around the button
  final EdgeInsetsGeometry? margin;

  /// Alignment of the button content
  final Alignment? alignment;

  /// Decoration for the button
  final BoxDecoration? decoration;

  /// Text style for the button text
  final TextStyle? textStyle;

  /// Width of the button
  final double? width;

  /// Height of the button
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        alignment: alignment ?? Alignment.center,
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.h),
        decoration:
            decoration ??
            BoxDecoration(
              border: Border.all(color: appTheme.colorFFE5E7, width: 1),
              borderRadius: BorderRadius.circular(6.h),
            ),
        child: _buildButtonContent(),
      ),
    );
  }

  /// Builds the internal content of the button based on configuration
  Widget _buildButtonContent() {
    // If we only have an image (no text), just return the image
    if (text == null && imagePath != null) {
      return CustomImageView(
        imagePath: imagePath,
        height: imageSize?.height ?? 24.h,
        width: imageSize?.width ?? 24.h,
        fit: BoxFit.contain,
      );
    }

    // If we have text (with or without image)
    final buttonText = Text(
      text ?? "",
      style: textStyle ?? TextStyleHelper.instance.body14Medium,
    );

    // If we have both text and image
    if (imagePath != null) {
      final image = CustomImageView(
        imagePath: imagePath,
        height: imageSize?.height ?? 18.h,
        width: imageSize?.width ?? 18.h,
        fit: BoxFit.contain,
      );

      return Row(
        mainAxisSize: MainAxisSize.min,
        children:
            imagePosition == CustomImagePosition.left
                ? [image, SizedBox(width: spacing ?? 4.h), buttonText]
                : [buttonText, SizedBox(width: spacing ?? 4.h), image],
      );
    }

    // If we only have text
    return buttonText;
  }
}

/// Enum defining the possible positions of an image in the button
enum CustomImagePosition { left, right }