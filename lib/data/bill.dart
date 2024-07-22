class BillModel {
  final String id;
  final String fullName;
  final String dateCreated;
  final double total;

  BillModel({
    required this.id,
    required this.fullName,
    required this.dateCreated,
    required this.total,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      id: json['id'],
      fullName: json['fullName'],
      dateCreated: json['dateCreated'],
      total: json['total' ].toDouble(),
    );
  }
}
