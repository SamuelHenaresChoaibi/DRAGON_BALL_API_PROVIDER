// widgets/category_slider.dart
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
    if (items.isEmpty) {
      return const Center(
        child: Text(
          "No hay datos aún...",
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título épico
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
              letterSpacing: 2,
              shadows: [
                Shadow(color: Colors.orangeAccent, blurRadius: 20),
                Shadow(color: Colors.black, blurRadius: 6),
              ],
            ),
          ),
        ),

        // Lista vertical con tarjetas grandes y estilo DBZ
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: items.length,
            itemBuilder: (context, i) {
              final item = items[i];

              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: () => onTap(item),
                  child: Container(
                    height: 340, // Tarjeta alta y poderosa
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF1E3A8A),
                          Color(0xFF1E40AF),
                          Color(0xFF2563EB),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber,
                          blurRadius: 25,
                          spreadRadius: 3,
                        ),
                        const BoxShadow(
                          color: Colors.black87,
                          offset: Offset(0, 10),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Imagen principal con borde dorado
                        Container(
                          height: 220,
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.amber, width: 4),
                            boxShadow: const [
                              BoxShadow(color: Colors.black54, blurRadius: 15, offset: Offset(0, 6)),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: item.image ?? '',
                              fit: BoxFit.contain,
                              width: double.infinity,
                              placeholder: (_, _) => Container(
                                color: Colors.grey[900],
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.amber,
                                    strokeWidth: 6,
                                  ),
                                ),
                              ),
                              errorWidget: (_, _, _) => Container(
                                color: Colors.grey[900],
                                child: const Icon(Icons.broken_image, size: 80, color: Colors.redAccent),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Nombre con fondo negro y brillo
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.amber, width: 2),
                          ),
                          child: Text(
                            (item.name ?? 'Sin nombre').toUpperCase(),
                            style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              shadows: [
                                Shadow(color: Colors.orangeAccent, blurRadius: 12),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Indicador pequeño de tipo (opcional)
                        if (type == 'personajes')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.whatshot, color: Colors.orange, size: 20),
                              const SizedBox(width: 6),
                              Text(
                                item.race ?? 'Humano',
                                style: const TextStyle(color: Colors.white70, fontSize: 14),
                              ),
                            ],
                          )
                        else if (type == 'planetas')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                item.isDestroyed ? Icons.warning : Icons.public,
                                color: item.isDestroyed ? Colors.red : Colors.cyan,
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item.isDestroyed ? "Destruido" : "Intacto",
                                style: TextStyle(
                                  color: item.isDestroyed ? Colors.redAccent : Colors.cyanAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}