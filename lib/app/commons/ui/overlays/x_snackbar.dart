import 'package:flutter/material.dart';
import 'package:mvvm_getx_pattern/app/commons/theme_manager.dart';

enum SnackBarType {
  success,
  error,
  warning,
  info,
}

class XSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.info,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: type.textColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
          backgroundColor: type.backgroundColor,
          margin: const EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          showCloseIcon: true,
          closeIconColor: type.textColor,

          // action: SnackBarAction(
          //   label: 'Close',
          //   textColor: type.textColor,
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
          //   },
          // ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      );
  }
}

extension SnackBarTypeExtension on SnackBarType {
  Color get backgroundColor {
    switch (this) {
      case SnackBarType.success:
        return ThemeManager().successColor;
      case SnackBarType.error:
        return ThemeManager().errorColor;
      case SnackBarType.warning:
        return ThemeManager().warningColor;
      case SnackBarType.info:
        return ThemeManager().infoColor;
    }
  }

  Color get color {
    switch (this) {
      case SnackBarType.success:
        return ThemeManager().successColor;
      case SnackBarType.error:
        return ThemeManager().errorColor;
      case SnackBarType.warning:
        return ThemeManager().warningColor;
      case SnackBarType.info:
        return ThemeManager().infoColor;
    }
  }

  Color get textColor {
    switch (this) {
      case SnackBarType.success:
        return Colors.white;
      case SnackBarType.error:
        return Colors.white;
      case SnackBarType.warning:
        return ThemeManager().textColor;
      case SnackBarType.info:
        return ThemeManager().textColor;
    }
  }
}
