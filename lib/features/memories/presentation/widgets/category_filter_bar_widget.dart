import 'package:flutter/material.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entity/memory_item_entity.dart';

/// Segmented filter bar for selecting media categories.
class CategoryFilterBarWidget extends StatelessWidget {
  final MemoryCategory selectedCategory;
  final ValueChanged<MemoryCategory> onCategorySelected;

  const CategoryFilterBarWidget({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.0,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _FilterChip(
            label: AppStrings.categoryAll,
            isSelected: selectedCategory == MemoryCategory.all,
            onTap: () => onCategorySelected(MemoryCategory.all),
          ),
          _FilterChip(
            label: AppStrings.categoryPhotos,
            isSelected: selectedCategory == MemoryCategory.photos,
            onTap: () => onCategorySelected(MemoryCategory.photos),
          ),
          _FilterChip(
            label: AppStrings.categoryVideos,
            isSelected: selectedCategory == MemoryCategory.videos,
            onTap: () => onCategorySelected(MemoryCategory.videos),
          ),
          _FilterChip(
            label: AppStrings.categoryAudio,
            isSelected: selectedCategory == MemoryCategory.audio,
            onTap: () => onCategorySelected(MemoryCategory.audio),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.copperAccent : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
