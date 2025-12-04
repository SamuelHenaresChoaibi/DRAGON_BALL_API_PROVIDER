class Meta {
  final int totalItems;
  final int itemCount;
  final int itemsPerPage;
  final int totalPages;
  final int currentPage;

  Meta({
    required this.totalItems,
    required this.itemCount,
    required this.itemsPerPage,
    required this.totalPages,
    required this.currentPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      totalItems: json['totalItems'] as int,
      itemCount: json['itemCount'] as int,
      itemsPerPage: json['itemsPerPage'] as int,
      totalPages: json['totalPages'] as int,
      currentPage: json['currentPage'] as int,
    );
  }
}