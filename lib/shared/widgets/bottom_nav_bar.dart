import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';

/// Shared bottom navigation bar that appears on both the Home and
/// Notifications screens.
///
/// It has 5 items: Home | Network | [FAB-style centre button] | Messages | Jobs
/// The centre item is a raised circular blue button (+).
///
/// [currentIndex] – which tab is active (0-based, skipping the centre)
/// [onTap] – called with the tapped index
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      // White background with top shadow / border
      decoration: BoxDecoration(
        color: AppColors.navBarBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // ── Home ──────────────────────────────────────────────────────────
          _NavItem(
            icon: Icons.home_rounded,
            label: AppStrings.navHome,
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),

          // ── Network ───────────────────────────────────────────────────────
          _NavItem(
            icon: Icons.people_outline_rounded,
            label: AppStrings.navNetwork,
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),

          // ── Centre "+" FAB button ─────────────────────────────────────────
          GestureDetector(
            onTap: () => onTap(2),
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.linkedInBlue,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.linkedInBlue.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: AppColors.white, size: 26),
            ),
          ),

          // ── Messages ──────────────────────────────────────────────────────
          _NavItem(
            icon: Icons.chat_bubble_outline_rounded,
            label: AppStrings.navMessages,
            isActive: currentIndex == 3,
            onTap: () => onTap(3),
          ),

          // ── Jobs ──────────────────────────────────────────────────────────
          _NavItem(
            icon: Icons.work_outline_rounded,
            label: AppStrings.navJobs,
            isActive: currentIndex == 4,
            onTap: () => onTap(4),
          ),
        ],
      ),
    );
  }
}

/// A single icon + label item in the bottom nav bar.
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.linkedInBlue : AppColors.textSecondary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 3),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: color,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
