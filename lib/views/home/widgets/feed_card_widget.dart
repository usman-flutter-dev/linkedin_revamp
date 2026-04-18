import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../models/feed_model.dart';

/// A single feed post card shown in the "All Feeds" section.
///
/// Layout (from the mockup):
/// [Avatar] Siren.uix ✓ · Product Designer · 1h ago   [Follow]
/// ┌─ Post image thumbnail with "MEDICAL APP" text ─────────────┐
/// └────────────────────────────────────────────────────────────┘
class FeedCardWidget extends StatelessWidget {
  final FeedModel feed;

  const FeedCardWidget({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Author row ─────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              children: [
                // Author avatar
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(feed.avatarColorHex),
                  child: Text(
                    feed.authorName[0],
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // Author name + role + time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name + verified tick
                      Row(
                        children: [
                          Text(feed.authorName, style: AppTextStyles.userName),
                          if (feed.isVerified) ...[
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.verified,
                              color: AppColors.linkedInBlue,
                              size: 13,
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 1),

                      // Role · time
                      Text(
                        '${feed.authorRole} · ${feed.timeAgo}',
                        style: AppTextStyles.userHandle,
                      ),
                    ],
                  ),
                ),

                // Follow button
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.linkedInBlue,
                    side: const BorderSide(color: AppColors.linkedInBlue),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Follow',
                    style: AppTextStyles.followButton,
                  ),
                ),
              ],
            ),
          ),

          // ── Post image / thumbnail ─────────────────────────────────────
          if (feed.postHeadline != null)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Container(
                height: 80,
                width: double.infinity,
                // Dark blue background simulating the "MEDICAL APP" post image
                color: const Color(0xFF1A3A5C),
                child: Center(
                  child: Text(
                    feed.postHeadline!,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
