// category_slider.dart → ¡AHORA SÍ ES HORIZONTAL!
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategorySlider extends StatelessWidget {
  final String title;
  final List<dynamic> items;
  final String type;
  final Function(dynamic) onTap;

  const CategorySlider({
    required this.title,
    required this.items,
    required this.type,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber),
          ),
        ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // ← HORIZONTAL
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: items.length > 20 ? 20 : items.length,
            itemBuilder: (context, i) {
              final item = items[i];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () => onTap(item),
                  child: Column(
                    children: [
                      Container(
                        width: 140,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[800],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: item.image ?? '',
                            fit: BoxFit.cover,
                            placeholder: (_, __) => const Center(child: CircularProgressIndicator(color: Colors.amber)),
                            errorWidget: (_, __, ___) => const Icon(Icons.error, color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 140,
                        child: Text(
                          item.name ?? 'Sin nombre',
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}