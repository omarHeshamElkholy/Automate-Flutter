class ServiceCenter {
  final String id;
  final String name;
  final String type;
  final String? phone;
  final String address;
  final String city;
  final double? latitude;
  final double? longitude;
  final String? googleMapsLink;

  ServiceCenter({
    required this.id,
    required this.name,
    required this.type,
    this.phone,
    required this.address,
    required this.city,
    this.latitude,
    this.longitude,
    this.googleMapsLink,
  });

  factory ServiceCenter.fromJson(Map<String, dynamic> json) {
    return ServiceCenter(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      phone: json['phone'] as String?,
      address: json['address'] as String,
      city: json['city'] as String,
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
      googleMapsLink: json['googleMapsLink'] as String?,
    );
  }
}
