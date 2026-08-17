class Car {
  final String id;
  final String make;
  final String model;
  final int year;
  final int currentMileage;

  Car({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.currentMileage,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      currentMileage: json['currentMileage'] as int,
    );
  }

  String get displayName => '$year $make $model';
}
