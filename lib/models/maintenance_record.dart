class MaintenanceRecord {
  final String id;
  final String maintenanceType;
  final String description;
  final double cost;
  final int mileageAtService;
  final String date;
  final String? serviceCenterId;
  final String? carId;

  MaintenanceRecord({
    required this.id,
    required this.maintenanceType,
    required this.description,
    required this.cost,
    required this.mileageAtService,
    required this.date,
    this.serviceCenterId,
    this.carId,
  });

  factory MaintenanceRecord.fromJson(Map<String, dynamic> json) {
    return MaintenanceRecord(
      id: json['id'] as String,
      maintenanceType: json['maintenanceType'] as String,
      description: json['notes'] as String? ?? '',
      cost: json['cost'] != null ? (json['cost'] as num).toDouble() : 0.0,
      mileageAtService: json['serviceMileage'] as int? ?? 0,
      date: json['serviceDate'] as String? ?? '',
      serviceCenterId: json['serviceCenterName'] as String?,
      carId: json['carId'] as String?,
    );
  }
}
