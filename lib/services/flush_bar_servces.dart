import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';

class FlushbarService {
  /// Show Success Message
  static void showSuccess(
    BuildContext context,
    String message, {
    String title = 'Success',
  }) {
    _showFlushbar(
      context,
      title,
      message,
      Colors.green,
      Icons.check_circle,
      Colors.white,
    );
  }

  /// ⚠️ Show Error Message
  static void showError(
    BuildContext context,
    String message, {
    String title = 'Error',
  }) {
    _showFlushbar(
      context,
      title,
      message,
      Colors.redAccent.shade200,
      Icons.error_outline,
      Colors.white,
    );
  }

  /// ℹ️ Show Info / Alert Message
  static void showInfo(
    BuildContext context,
    String message, {
    String title = 'Info',
  }) {
    _showFlushbar(
      context,
      title,
      message,
      Colors.amber.shade700,
      Icons.info_outline,
      Colors.white,
    );
  }

  /// 🌈 Internal Flushbar Builder
  static void _showFlushbar(
    BuildContext context,
    String title,
    String message,
    Color backgroundColor,
    IconData icon,
    Color iconColor,
  ) {
    Flushbar(
      titleText: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      messageText: Text(
        message,
        style: GoogleFonts.poppins(
          color: Colors.white.withOpacity(0.9),
          fontSize: 14,
          height: 1.4,
        ),
      ),
      backgroundGradient: LinearGradient(
        colors: [
          backgroundColor.withOpacity(0.95),
          backgroundColor.withOpacity(0.8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      icon: Icon(icon, size: 26, color: iconColor),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      borderRadius: BorderRadius.circular(16),
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      animationDuration: const Duration(milliseconds: 700),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ).show(context);
  }
}
