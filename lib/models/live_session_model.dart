/// Data model for a "Creator on Live" session card.
class LiveSessionModel {
  /// Title text shown on the thumbnail overlay
  final String title;

  /// Host's name shown at the bottom of the card
  final String hostName;

  /// Time since the session started (e.g. "6m")
  final String timeAgo;

  /// Number of viewers, e.g. "21.2k"
  final String viewerCount;

  /// Background colour for the fake thumbnail
  final int thumbnailColorHex;

  const LiveSessionModel({
    required this.title,
    required this.hostName,
    required this.timeAgo,
    required this.viewerCount,
    required this.thumbnailColorHex,
  });
}
