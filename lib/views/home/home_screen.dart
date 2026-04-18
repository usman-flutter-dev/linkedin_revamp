import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../providers/home_provider.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import 'widgets/feed_card_widget.dart';
import 'widgets/filter_chips_widget.dart';
import 'widgets/live_session_card.dart';
import 'widgets/story_circle_widget.dart';

/// Home screen — the "View" layer in MVVM.
/// It reads state from Riverpod providers and renders the UI.
/// It NEVER contains business logic; that lives in HomeViewModel.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read the ViewModel (data source)
    final vm = ref.watch(homeViewModelProvider);
    // Watch nav index so bottom bar rebuilds on tab change
    final navIndex = ref.watch(homeNavIndexProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        // Soft gradient background matching the mockup
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientTop, AppColors.gradientBottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // ── App Bar ──────────────────────────────────────────────────
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    // LinkedIn "in" logo circle
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppColors.linkedInBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'in',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(AppStrings.appName, style: AppTextStyles.appBarTitle),
                  ],
                ),
                actions: [
                  // Search icon
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.textPrimary,
                    ),
                    onPressed: () {},
                  ),
                  // Bell with notification badge
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_none_rounded,
                          color: AppColors.textPrimary,
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/notifications'),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: AppColors.badgeRed,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text('13', style: AppTextStyles.badgeText),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // ── Stories row ──────────────────────────────────────
                    SizedBox(
                      height: 90,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: vm.stories.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 8),
                        itemBuilder: (_, i) =>
                            StoryCircleWidget(story: vm.stories[i]),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── Filter chips ─────────────────────────────────────
                    FilterChipsWidget(chips: vm.filterChips),

                    const SizedBox(height: 16),

                    // ── "Creator on Live" section header ─────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            AppStrings.creatorOnLive,
                            style: AppTextStyles.sectionHeader,
                          ),
                          const SizedBox(width: 6),
                          // Live count badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.liveRed,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '0${vm.liveCount}',
                              style: AppTextStyles.badgeText,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.more_horiz,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ── Live session cards ────────────────────────────────
                    SizedBox(
                      height: 130,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: vm.liveSessions.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 10),
                        itemBuilder: (_, i) =>
                            LiveSessionCard(session: vm.liveSessions[i]),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── "All Feeds" section header ────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            AppStrings.allFeeds,
                            style: AppTextStyles.sectionHeader,
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.more_horiz,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ── Feed cards ────────────────────────────────────────
                    ...vm.feeds.map((f) => FeedCardWidget(feed: f)),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // ── Bottom navigation bar ─────────────────────────────────────────────
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: navIndex,
        onTap: (i) {
          ref.read(homeNavIndexProvider.notifier).state = i;
          if (i == 0) Navigator.pushNamed(context, '/notifications');
        },
      ),
    );
  }
}
