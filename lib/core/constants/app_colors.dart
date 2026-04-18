import 'package:flutter/material.dart';

/// Centralized color palette extracted from the LinkedIn redesign mockup.
/// All colors are defined as static constants so they can be referenced
/// anywhere in the app without hardcoding hex values.
class AppColors {
  AppColors._(); // Prevent instantiation

  // ── Brand ────────────────────────────────────────────────────────────────
  /// LinkedIn signature blue used for the logo, buttons, selected tabs, etc.
  static const Color linkedInBlue = Color(0xFF0A66C2);

  /// Lighter tint of blue used for chip/pill backgrounds and subtle accents
  static const Color linkedInBlueTint = Color(0xFFE8F1FB);

  // ── Background ───────────────────────────────────────────────────────────
  /// Main screen background – very light grey-blue (matches the neo-soft look)
  static const Color background = Color(0xFFEEF2F7);

  /// Pure white used for cards, bottom sheets, bottom nav, etc.
  static const Color white = Color(0xFFFFFFFF);

  // ── Text ─────────────────────────────────────────────────────────────────
  /// Primary text – near-black
  static const Color textPrimary = Color(0xFF1A1A2E);

  /// Secondary / muted text – medium grey
  static const Color textSecondary = Color(0xFF6B7280);

  /// Tertiary / caption text – light grey
  static const Color textTertiary = Color(0xFF9CA3AF);

  // ── UI Elements ──────────────────────────────────────────────────────────
  /// Divider / border colour – very light grey
  static const Color divider = Color(0xFFE5E7EB);

  /// Badge / notification indicator red
  static const Color badgeRed = Color(0xFFEF4444);

  /// Card shadow colour used in BoxShadow
  static const Color shadowColor = Color(0x1A0A66C2);

  /// Bottom navigation bar background – white with slight transparency feel
  static const Color navBarBackground = Color(0xFFFFFFFF);

  /// Live indicator red dot
  static const Color liveRed = Color(0xFFFF3B30);

  // ── Gradient ─────────────────────────────────────────────────────────────
  /// Top of the soft background gradient
  static const Color gradientTop = Color(0xFFF0F6FF);

  /// Bottom of the soft background gradient
  static const Color gradientBottom = Color(0xFFE8EEF8);
}
