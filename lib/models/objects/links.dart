class Links {
  final String first;
  final String? previous;
  final String? next;
  final String last;

  Links({
    required this.first,
    this.previous,
    this.next,
    required this.last,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'] as String,
      previous: json['previous'] is String && json['previous'].toString().isNotEmpty
          ? json['previous'] as String
          : null,
      next: json['next'] is String && json['next'].toString().isNotEmpty
          ? json['next'] as String
          : null,
      last: json['last'] as String,
    );
  }
}