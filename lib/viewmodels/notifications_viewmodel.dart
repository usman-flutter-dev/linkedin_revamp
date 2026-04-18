import '../core/constants/app_strings.dart';
import '../models/notification_model.dart';

/// [NotificationsViewModel] owns the state & business logic for the
/// Notifications screen. The View layer queries this class for data and
/// calls its methods when the user interacts with the screen.
class NotificationsViewModel {
  // ── Tab Bar ───────────────────────────────────────────────────────────────

  /// Tab labels shown below the app bar
  List<String> get tabs => const [
    AppStrings.tabPeople,
    AppStrings.tabJobsLists,
    AppStrings.tabTrending,
  ];

  // ── New Invitations ──────────────────────────────────────────────────────

  /// Badge count on the "New Invitations" header
  int get newInvitationsCount => 2;

  /// Notifications listed under "New Invitations"
  List<NotificationModel> get newInvitations => const [
    NotificationModel(
      senderName: AppStrings.wadeWarren,
      subtitle: AppStrings.wadeSubtitle,
      dateLabel: AppStrings.wadeDate,
      avatarColorHex: 0xFF7C3AED,
      isVerified: true,
    ),
    NotificationModel(
      senderName: AppStrings.bessie,
      subtitle: AppStrings.bessieSubtitle,
      dateLabel: AppStrings.bessieDate,
      avatarColorHex: 0xFFDB2777,
    ),
  ];

  // ── This Weeks ────────────────────────────────────────────────────────────

  /// Notifications listed under "This Weeks"
  List<NotificationModel> get thisWeeksNotifications => const [
    NotificationModel(
      senderName: AppStrings.jacobJones,
      subtitle: AppStrings.jacobSubtitle,
      dateLabel: AppStrings.jacobDate,
      avatarColorHex: 0xFF059669,
      isVerified: true,
      postBody: AppStrings.jacobBody,
      engagement: AppStrings.jacobReactions,
      previewColorHex: 0xFF1E3A5F,
    ),
    NotificationModel(
      senderName: AppStrings.kristinWatson,
      subtitle: AppStrings.kristinSubtitle,
      dateLabel: AppStrings.kristinDate,
      avatarColorHex: 0xFFD97706,
    ),
  ];
}
