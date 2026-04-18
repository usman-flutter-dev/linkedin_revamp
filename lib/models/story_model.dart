/// Represents a story/profile circle shown in the horizontal stories row
/// on the Home screen.
class StoryModel {
  /// Display name shown below the circle
  final String name;

  /// Colour used to fake an avatar (replace with a real image URL in prod)
  final int avatarColorHex;

  /// Whether this is the "Add" story (shows a "+" icon)
  final bool isAdd;

  /// Whether to show a verified blue tick badge
  final bool isVerified;

  const StoryModel({
    required this.name,
    required this.avatarColorHex,
    this.isAdd = false,
    this.isVerified = false,
  });
}
