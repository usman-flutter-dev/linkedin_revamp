import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../models/live_session_model.dart';

/// Card widget for a live session shown in the "Creator on Live" section.
///
/// Layout (from the mockup):
/// ┌─────────────────────┐
/// │  👁 21.2k           │  ← viewer count top-left
/// │                     │
/// │  Title text…        │  ← session title bottom-left
/// │  ● Robert · 6m      │  ← avatar + host + time
/// └─────────────────────┘
class LiveSessionCard extends StatelessWidget {
  final LiveSessionModel session;

  const LiveSessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 150,
        height: 120,
        // Dark gradient thumbnail background (replaces real image)
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(session.thumbnailColorHex),
              Color(session.thumbnailColorHex).withValues(alpha: 0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // ── Viewer count badge (top-left) ─────────────────────────────
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.remove_red_eye_outlined,
                      color: AppColors.white,
                      size: 10,
                    ),
                    const SizedBox(width: 3),
                    Text(session.viewerCount, style: AppTextStyles.liveCounter),
                  ],
                ),
              ),
            ),

            // ── Bottom info overlay ───────────────────────────────────────
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                // Dark gradient from bottom so text is readable
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.65),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Session title
                    Text(
                      session.title,
                      style: AppTextStyles.liveCounter.copyWith(fontSize: 9),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // Host row: live dot + avatar initial + name + time
                    Row(
                      children: [
                        // Live red dot
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(right: 4),
                          decoration: const BoxDecoration(
                            color: AppColors.liveRed,
                            shape: BoxShape.circle,
                          ),
                        ),

                        // Tiny avatar
                        CircleAvatar(
                          radius: 7,
                          backgroundColor: AppColors.linkedInBlue,
                          child: Text(
                            session.hostName[0],
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 7,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        const SizedBox(width: 4),

                        // Host name
                        Text(
                          session.hostName,
                          style: AppTextStyles.liveCounter.copyWith(
                            fontSize: 9,
                          ),
                        ),

                        const SizedBox(width: 4),

                        // Time since started
                        Text(
                          '· ${session.timeAgo}',
                          style: AppTextStyles.liveCounter.copyWith(
                            fontSize: 9,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
