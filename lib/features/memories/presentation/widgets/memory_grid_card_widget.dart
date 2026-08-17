import 'package:flutter/material.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entity/memory_item_entity.dart';

/// Single media card component for the memories grid view.
class MemoryGridCardWidget extends StatelessWidget {
  final MemoryItemEntity item;
  final VoidCallback? onTap;

  const MemoryGridCardWidget({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          image: DecorationImage(
            image: AssetImage(item.assetPath),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(8),
              blurRadius: 10.0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Dark gradient overlay for bottom label contrast
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withAlpha(70),
                    ],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
            ),

            // Video Play Button & Duration Overlay
            Positioned(
              left: 8.0,
              bottom: 8.0,
              right: 8.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (item.isVideo)
                    Container(
                      width: 28.0,
                      height: 28.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withAlpha(200),
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        size: 20.0,
                        color: Colors.black87,
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                  Text(
                    item.duration,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
