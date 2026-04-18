import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../providers/notifications_provider.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import 'widgets/notification_item_widget.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(notificationsViewModelProvider);
    final tabIndex = ref.watch(notificationsTabIndexProvider);
    final navIndex = ref.watch(notificationsNavIndexProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientTop, AppColors.gradientBottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── App Bar ─────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        AppStrings.notifications,
                        style: AppTextStyles.appBarTitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // ── Tab bar: People | Jobs Lists | Trending ──────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: List.generate(vm.tabs.length, (i) {
                    final active = i == tabIndex;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            ref
                                    .read(
                                      notificationsTabIndexProvider.notifier,
                                    )
                                    .state =
                                i,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon per tab
                                  Icon(
                                    i == 0
                                        ? Icons.people_outline
                                        : i == 1
                                        ? Icons.work_outline
                                        : Icons.trending_up,
                                    color: active
                                        ? AppColors.linkedInBlue
                                        : AppColors.textSecondary,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    vm.tabs[i],
                                    style: active
                                        ? AppTextStyles.tabActive
                                        : AppTextStyles.tabInactive,
                                  ),
                                ],
                              ),
                            ),
                            // Active underline
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 2,
                              decoration: BoxDecoration(
                                color: active
                                    ? AppColors.linkedInBlue
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const Divider(height: 1, color: AppColors.divider),

              // ── Scrollable notification list ─────────────────────────────
              Expanded(
                child: ListView(
                  children: [
                    // ── New Invitations header ───────────────────────────
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
                      child: Row(
                        children: [
                          Text(
                            AppStrings.newInvitations,
                            style: AppTextStyles.sectionHeader,
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.linkedInBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '0${vm.newInvitationsCount}',
                              style: AppTextStyles.badgeText,
                            ),
                          ),
                          const Spacer(),
                          // Recent Lists dropdown button
                          Row(
                            children: [
                              const Icon(
                                Icons.sort,
                                size: 14,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                AppStrings.recentLists,
                                style: AppTextStyles.bodySmall,
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                size: 14,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // New invitation items
                    ...vm.newInvitations.map(
                      (n) => NotificationItemWidget(notification: n),
                    ),

                    // ── This Weeks header ────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
                      child: Row(
                        children: [
                          Text(
                            AppStrings.thisWeeks,
                            style: AppTextStyles.sectionHeader,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(
                                Icons.sort,
                                size: 14,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                AppStrings.recentLists,
                                style: AppTextStyles.bodySmall,
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                size: 14,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // This weeks notification items
                    ...vm.thisWeeksNotifications.map(
                      (n) => NotificationItemWidget(notification: n),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: AppBottomNavBar(
        currentIndex: navIndex,
        onTap: (i) =>
            ref.read(notificationsNavIndexProvider.notifier).state = i,
      ),
    );
  }
}
