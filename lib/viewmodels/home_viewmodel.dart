import '../core/constants/app_strings.dart';
import '../models/feed_model.dart';
import '../models/live_session_model.dart';
import '../models/story_model.dart';

/// [HomeViewModel] holds all the data and logic for the Home screen.
/// The View (HomeScreen) only talks to this class — never directly to raw data.
/// This is the "VM" in MVVM.
class HomeViewModel {
  // ── Stories ──────────────────────────────────────────────────────────────

  /// Returns the list of story/profile circles to display.
  List<StoryModel> get stories => const [
    StoryModel(name: AppStrings.add, avatarColorHex: 0xFF0A66C2, isAdd: true),
    StoryModel(name: AppStrings.albert, avatarColorHex: 0xFF7C3AED),
    StoryModel(
      name: AppStrings.dianne,
      avatarColorHex: 0xFF059669,
      isVerified: true,
    ),
    StoryModel(name: AppStrings.robert, avatarColorHex: 0xFFD97706),
    StoryModel(name: AppStrings.tyler, avatarColorHex: 0xFFDB2777),
  ];

  // ── Filter Chips ─────────────────────────────────────────────────────────

  /// List of filter chip labels for the home screen
  List<String> get filterChips => const [
    AppStrings.chipAdd,
    AppStrings.chipJobOpenings,
    AppStrings.chipDesignPost,
    AppStrings.chipPinned,
  ];

  // ── Live Sessions ─────────────────────────────────────────────────────────

  /// Number of active live sessions (shown as badge on section header)
  int get liveCount => 6;

  /// Returns list of live session cards
  List<LiveSessionModel> get liveSessions => const [
    LiveSessionModel(
      title: AppStrings.liveSession1Title,
      hostName: AppStrings.liveUser1,
      timeAgo: AppStrings.liveTime1,
      viewerCount: AppStrings.liveViewers,
      thumbnailColorHex: 0xFF1E3A5F,
    ),
    LiveSessionModel(
      title: AppStrings.liveSession2Title,
      hostName: AppStrings.liveUser2,
      timeAgo: AppStrings.liveTime2,
      viewerCount: AppStrings.liveViewers,
      thumbnailColorHex: 0xFF2D4A7A,
    ),
  ];

  // ── Feed ─────────────────────────────────────────────────────────────────

  /// Returns the list of feed posts
  List<FeedModel> get feeds => const [
    FeedModel(
      authorName: AppStrings.sirenUix,
      authorRole: AppStrings.sirenRole,
      timeAgo: AppStrings.sirenTime,
      postHeadline: AppStrings.medicalAppHeadline,
      avatarColorHex: 0xFF0A66C2,
      isVerified: true,
    ),
  ];
}
