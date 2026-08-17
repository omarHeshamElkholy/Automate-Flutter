class Reminder {
  final String id;
  final String maintenanceType;
  final String status;
  final String? dueDate;
  final int? dueMileage;

  Reminder({
    required this.id,
    required this.maintenanceType,
    required this.status,
    this.dueDate,
    this.dueMileage,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'] as String,
      maintenanceType: json['maintenanceType'] as String,
      status: json['status'] as String,
      dueDate: json['dueDate'] as String?,
      dueMileage: json['dueMileage'] as int?,
    );
  }
}
