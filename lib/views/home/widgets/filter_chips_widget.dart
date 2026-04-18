import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../providers/home_provider.dart';

/// Horizontal scrollable row of filter chips shown below the stories row.
/// The first chip ("+ Add") is always shown with a LinkedIn-blue filled style.
/// Other chips are outlined/ghost pills.
///
/// Tapping a chip updates [selectedFilterIndexProvider] which triggers
/// a rebuild of only this widget (and any other watchers).
class FilterChipsWidget extends ConsumerWidget {
  final List<String> chips;

  const FilterChipsWidget({super.key, required this.chips});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the currently selected chip index from our Riverpod provider
    final selectedIndex = ref.watch(selectedFilterIndexProvider);

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: chips.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isFirst = index == 0; // "Add" chip with "+" prefix
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () {
              // Update the selected filter index via Riverpod
              ref.read(selectedFilterIndexProvider.notifier).state = index;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
              decoration: BoxDecoration(
                // First chip ("Add") is always blue-filled; others toggle
                color: isFirst || isSelected
                    ? AppColors.linkedInBlue
                    : AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isFirst || isSelected
                      ? AppColors.linkedInBlue
                      : AppColors.divider,
                ),
                boxShadow: isFirst || isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.linkedInBlue.withValues(alpha: 0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Show "+" icon only on the first "Add" chip
                  if (isFirst) ...[
                    Icon(Icons.add, color: AppColors.white, size: 14),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    chips[index],
                    style: (isFirst || isSelected)
                        ? AppTextStyles.chipLabelActive
                        : AppTextStyles.chipLabel,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
