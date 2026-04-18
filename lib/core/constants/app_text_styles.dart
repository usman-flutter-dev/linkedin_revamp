import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralised text styles.
/// Using Google Fonts is recommended (add `google_fonts` to pubspec.yaml).
/// Here we use the system font stack but name every style semantically
/// so swapping the font family is a one-line change per style.
class AppTextStyles {
  AppTextStyles._();

  // ── App Bar ──────────────────────────────────────────────────────────────
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 0.2,
  );

  // ── Section Headers ──────────────────────────────────────────────────────
  static const TextStyle sectionHeader = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle sectionHeaderSmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // ── Body ─────────────────────────────────────────────────────────────────
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
  );

  // ── Name / Username ──────────────────────────────────────────────────────
  static const TextStyle userName = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle userHandle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // ── Chips / Pills ─────────────────────────────────────────────────────────
  static const TextStyle chipLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const TextStyle chipLabelActive = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  // ── Tabs ─────────────────────────────────────────────────────────────────
  static const TextStyle tabActive = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.linkedInBlue,
  );

  static const TextStyle tabInactive = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  // ── Badge ─────────────────────────────────────────────────────────────────
  static const TextStyle badgeText = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  // ── Timestamp ────────────────────────────────────────────────────────────
  static const TextStyle timestamp = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
  );

  // ── Follow Button ─────────────────────────────────────────────────────────
  static const TextStyle followButton = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.linkedInBlue,
  );

  // ── Live Counter ─────────────────────────────────────────────────────────
  static const TextStyle liveCounter = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  // ── Story Label ──────────────────────────────────────────────────────────
  static const TextStyle storyLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
}
