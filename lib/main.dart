import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';

/// Entry point of the LinkedIn Redesign App.
/// We wrap the entire app with [ProviderScope] to enable Riverpod
/// dependency injection and state management throughout the widget tree.
void main() {
  runApp(const ProviderScope(child: LinkedInApp()));
}
