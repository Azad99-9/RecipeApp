import 'package:flutter/material.dart';

/// A utility class for managing responsive layouts in Flutter applications.
///
/// This class provides methods to calculate appropriate sizes for UI elements
/// based on the device screen dimensions. It helps ensure consistent scaling
/// across different screen sizes.
class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;

  /// Initializes the `SizeConfig` class with the current BuildContext.
  ///
  /// This method should be called once during app startup, typically
  /// in the `initState` method of your main widget or a higher-level widget
  /// that provides the context.
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }

  /// Calculates the vertical size based on the design reference height.
  ///
  /// This method takes a size value and scales it proportionally based on the
  /// current screen height and a pre-defined design reference height (default 800).
  /// This ensures that vertical elements like paddings, margins, and font sizes
  /// adapt appropriately to different screen heights.
  ///
  /// You can optionally adjust the `designReferenceHeight` parameter to match
  /// your specific design specifications.
  static double getVerticalSize(double size, {double designReferenceHeight = 800}) {
    return size * screenHeight / designReferenceHeight;
  }

  /// Calculates the horizontal size based on the design reference width.
  ///
  /// This method takes a size value and scales it proportionally based on the
  /// current screen width and a pre-defined design reference width (default 360).
  /// This ensures that horizontal elements like paddings, margins, and widget
  /// widths adapt appropriately to different screen widths.
  ///
  /// You can optionally adjust the `designReferenceWidth` parameter to match
  /// your specific design specifications.
  static double getHorizontalSize(double size, {double designReferenceWidth = 360}) {
    return size * screenWidth / designReferenceWidth;
  }

  /// Gets the scaled size based on the provided size and a boolean flag.
  ///
  /// This method is a convenience wrapper for `getVerticalSize` and
  /// `getHorizontalSize`. It takes a size value and an optional `isVertical`
  /// flag. If `isVertical` is true, it calls `getVerticalSize`. Otherwise,
  /// it calls `getHorizontalSize`.
  static double getScaledSize(double size, {bool isVertical = false}) {
    if (isVertical) {
      return getVerticalSize(size);
    } else {
      return getHorizontalSize(size);
    }
  }
}
