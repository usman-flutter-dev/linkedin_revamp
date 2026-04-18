/// Represents a single post in the "All Feeds" section.
class FeedModel {
  final String authorName;
  final String authorRole;
  final String timeAgo;
  final String? postHeadline; // Optional large headline text on the post image
  final int avatarColorHex;
  final bool isVerified;

  const FeedModel({
    required this.authorName,
    required this.authorRole,
    required this.timeAgo,
    this.postHeadline,
    required this.avatarColorHex,
    this.isVerified = false,
  });
}
