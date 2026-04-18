import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../models/story_model.dart';

/// Renders one story/profile circle in the horizontal stories row.
///
/// If [story.isAdd] is true, the circle shows a "+" icon instead of
/// an avatar initial, and has the LinkedIn-blue background.
/// If [story.isVerified], a small blue badge is overlaid on the avatar.
class StoryCircleWidget extends StatelessWidget {
  final StoryModel story;

  const StoryCircleWidget({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      child: Column(
        children: [
          // ── Avatar / Add circle ───────────────────────────────────────────
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Outer ring for non-add stories (mimics story ring border)
              if (!story.isAdd)
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.linkedInBlue, width: 2),
                  ),
                ),

              // Inner avatar circle
              Padding(
                padding: EdgeInsets.all(story.isAdd ? 0 : 3),
                child: Container(
                  width: story.isAdd ? 54 : 48,
                  height: story.isAdd ? 54 : 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(story.avatarColorHex),
                  ),
                  child: Center(
                    child: story.isAdd
                        ? const Icon(
                            Icons.add,
                            color: AppColors.white,
                            size: 22,
                          )
                        : Text(
                            story.name[0].toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ),

              // Verified blue badge (bottom-right of avatar)
              if (story.isVerified)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: AppColors.linkedInBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.white,
                      size: 10,
                    ),
                  ),
                ),

              // "+" add badge on the bottom-right of "Add" story
              if (story.isAdd)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: AppColors.linkedInBlue,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.white,
                      size: 10,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 5),

          // ── Name label below circle ───────────────────────────────────────
          Text(
            story.name,
            style: AppTextStyles.storyLabel,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
