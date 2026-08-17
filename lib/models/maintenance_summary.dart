class MaintenanceSummary {
  final List<dynamic> ok;
  final List<dynamic> upcoming;
  final List<dynamic> due;
  final List<dynamic> overdue;

  MaintenanceSummary({
    required this.ok,
    required this.upcoming,
    required this.due,
    required this.overdue,
  });

  factory MaintenanceSummary.fromJson(Map<String, dynamic> json) {
    return MaintenanceSummary(
      ok: json['ok'] as List<dynamic>? ?? [],
      upcoming: json['upcoming'] as List<dynamic>? ?? [],
      due: json['due'] as List<dynamic>? ?? [],
      overdue: json['overdue'] as List<dynamic>? ?? [],
    );
  }

  bool get isGood => due.isEmpty && overdue.isEmpty;
  
  String get statusText {
    if (overdue.isNotEmpty) return 'Overdue';
    if (due.isNotEmpty) return 'Due';
    if (upcoming.isNotEmpty) return 'Upcoming';
    return 'Good';
  }

  String getStatusFor(String type) {
    bool check(List<dynamic> list) => list.any((item) => item is Map && item['maintenanceType'] == type);
    if (check(overdue)) return 'Overdue';
    if (check(due)) return 'Due';
    if (check(upcoming)) return 'Upcoming';
    return 'Good';
  }
}
