import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../viewmodels/home_viewmodel.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Home Providers
// Each provider exposes a piece of the HomeViewModel to the widget tree.
// Widgets can watch individual providers so they only rebuild when their
// specific data changes — this keeps rebuilds minimal.
// ─────────────────────────────────────────────────────────────────────────────

/// Provides a singleton [HomeViewModel].
/// Use [homeViewModelProvider] as the root; all other home providers
/// derive their data from it.
final homeViewModelProvider = Provider<HomeViewModel>((ref) {
  return HomeViewModel();
});

/// Currently selected filter chip index (defaults to 0 = "Add" chip)
final selectedFilterIndexProvider = StateProvider<int>((ref) => 0);

/// Currently selected bottom nav index on the Home screen (0 = Home)
final homeNavIndexProvider = StateProvider<int>((ref) => 0);
