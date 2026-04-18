import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../viewmodels/notifications_viewmodel.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Notifications Providers
// ─────────────────────────────────────────────────────────────────────────────

/// Provides the singleton [NotificationsViewModel].
final notificationsViewModelProvider = Provider<NotificationsViewModel>((ref) {
  return NotificationsViewModel();
});

/// Currently selected tab index on the Notifications screen (0 = "People")
final notificationsTabIndexProvider = StateProvider<int>((ref) => 0);

/// Currently selected bottom nav index on the Notifications screen (home=0)
final notificationsNavIndexProvider = StateProvider<int>((ref) => 0);
