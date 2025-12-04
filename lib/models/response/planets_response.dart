import 'package:dragon_ball_provider/models/modelos.dart';

class PlanetResponse {
  final List<Planet> items;
  final Meta meta;
  final Links links;

  PlanetResponse({
    required this.items,
    required this.meta,
    required this.links,
  });

  factory PlanetResponse.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    return PlanetResponse(
      items: itemsList.map((e) => Planet.fromJson(e)).toList(),
      meta: Meta.fromJson(json['meta']),
      links: Links.fromJson(json['links']),
    );
  }
}