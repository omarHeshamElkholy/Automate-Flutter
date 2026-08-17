import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/reminder.dart';
import '../providers/car_provider.dart';
import 'package:provider/provider.dart';

class ReminderDetailsScreen extends StatelessWidget {
  const ReminderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final reminder = args['reminder'] as Reminder;
    final carId = args['carId'] as String;
    final car = Provider.of<CarProvider>(context, listen: false).getCar(carId);

    final numberFormat = NumberFormat('#,##0');
    final isUrgent = reminder.status == 'OVERDUE' || reminder.status == 'DUE';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Reminder Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5EEFF)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isUrgent ? const Color(0xFFFFEBEE) : const Color(0xFFE5EEFF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.build_circle_outlined,
                      color: isUrgent ? const Color(0xFFD32F2F) : const Color(0xFF515F74),
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    reminder.maintenanceType.replaceAll('_', ' '),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isUrgent ? const Color(0xFFD32F2F) : const Color(0xFF10B981),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      reminder.status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5EEFF)),
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    icon: Icons.directions_car_outlined,
                    label: 'Vehicle',
                    value: car != null ? '${car.make} ${car.model}' : 'Unknown',
                  ),
                  const Divider(height: 24, color: Color(0xFFE5EEFF)),
                  if (reminder.dueMileage != null) ...[
                    _buildDetailRow(
                      icon: Icons.speed_outlined,
                      label: 'Due Mileage',
                      value: '${numberFormat.format(reminder.dueMileage)} km',
                    ),
                    const Divider(height: 24, color: Color(0xFFE5EEFF)),
                  ],
                  if (reminder.dueDate != null) ...[
                    _buildDetailRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Due Date',
                      value: reminder.dueDate!,
                    ),
                  ],
                  if (reminder.dueMileage == null && reminder.dueDate == null)
                    const Text('No specific due date or mileage recorded.', style: TextStyle(color: Color(0xFF515F74))),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/add-record',
                    arguments: carId, // Pre-select the car
                  );
                },
                child: const Text('Log Maintenance'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Remind Me Later'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({required IconData icon, required String label, required String value}) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF515F74), size: 20),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF515F74),
            fontSize: 14,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
