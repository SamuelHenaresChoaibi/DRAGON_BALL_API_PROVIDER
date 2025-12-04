import 'package:dragon_ball_provider/models/modelos.dart';

class CharacterResponse {
  final List<Character> items;
  final Meta meta;
  final Links links;

  CharacterResponse({
    required this.items,
    required this.meta,
    required this.links,
  });

  factory CharacterResponse.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    return CharacterResponse(
      items: itemsList.map((e) => Character.fromJson(e)).toList(),
      meta: Meta.fromJson(json['meta']),
      links: Links.fromJson(json['links']),
    );
  }
}