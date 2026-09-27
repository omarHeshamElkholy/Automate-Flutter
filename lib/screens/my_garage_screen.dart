import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/car_provider.dart';
import '../models/car.dart';
import 'package:intl/intl.dart';
import 'notifications_screen.dart';
import '../widgets/notification_bell.dart';
import 'vehicle_details_screen.dart';

class MyGarageScreen extends StatelessWidget {
  const MyGarageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF8F9FF),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.directions_car, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              'AutoMate',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        actions: [
          const NotificationBell(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Garage',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Manage your registered fleet and personal vehicles.',
                style: TextStyle(fontSize: 14, color: Color(0xFF515F74)),
              ),
              const SizedBox(height: 24),
              
              Consumer<CarProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()));
                  }
                  
                  if (provider.cars.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Text('No vehicles in your garage yet.', style: TextStyle(color: Color(0xFF7C839B))),
                      ),
                    );
                  }
                  
                  final NumberFormat numberFormat = NumberFormat('#,##0');
                  
                  return Column(
                    children: provider.cars.map((car) {
                      final summary = provider.getSummary(car.id);
                      final isActive = summary?.isGood ?? true;
                      final formattedMileage = '${numberFormat.format(car.currentMileage)} km';
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: _buildGarageItem(
                          context,
                          carId: car.id,
                          title: car.displayName, 
                          subtitle: '${car.year} • ${car.model}', 
                          mileage: formattedMileage, 
                          plate: 'Not Assigned', // Mock plate since it's not in our simple Car model
                          isActive: isActive,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-vehicle');
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildGarageItem(BuildContext context, {
    required String carId,
    required String title,
    required String subtitle,
    required String mileage,
    required String plate,
    required bool isActive,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/vehicle-details', arguments: carId);
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image Placeholder Area
          Container(
            height: 160,
            color: const Color(0xFFC6C6CD), // Gray placeholder
            child: Stack(
              children: [
                const Center(child: Text('img', style: TextStyle(color: Color(0xFF515F74)))),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isActive ? 'Active' : 'Service\nDue',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: const TextStyle(fontSize: 14, color: Color(0xFF515F74)),
                        ),
                      ],
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      color: const Color(0xFFC6C6CD), // Small logo placeholder
                      child: const Center(child: Text('img', style: TextStyle(fontSize: 8))),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE5EEFF), height: 1),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'MILEAGE',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1, color: Color(0xFF45464D)),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            mileage,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'PLATE',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1, color: Color(0xFF45464D)),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            plate,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
