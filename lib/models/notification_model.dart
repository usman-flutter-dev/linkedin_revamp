/// Represents a single notification entry on the Notifications screen.
class NotificationModel {
  final String senderName;
  final String subtitle;
  final String dateLabel;
  final int avatarColorHex;
  final bool isVerified;

  /// Optional body text shown in a preview card (e.g. Jacob Jones post body)
  final String? postBody;

  /// Optional engagement line (e.g. "534 Reactions · 32 Comments")
  final String? engagement;

  /// Optional preview image colour for post thumbnails
  final int? previewColorHex;

  const NotificationModel({
    required this.senderName,
    required this.subtitle,
    required this.dateLabel,
    required this.avatarColorHex,
    this.isVerified = false,
    this.postBody,
    this.engagement,
    this.previewColorHex,
  });
}
