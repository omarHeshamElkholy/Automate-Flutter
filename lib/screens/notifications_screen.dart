import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/car_provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Notifications', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
      ),
      body: Consumer<CarProvider>(
        builder: (context, provider, child) {
          final List<Widget> notifications = [];

          for (var car in provider.cars) {
            final summary = provider.getSummary(car.id);
            if (summary == null) continue;

            for (var item in summary.overdue) {
              if (item is Map) {
                final type = (item['maintenanceType'] ?? 'Service').toString().replaceAll('_', ' ');
                notifications.add(
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildNotificationItem(
                      icon: Icons.error_outline,
                      iconColor: Colors.red,
                      title: 'Overdue: $type',
                      message: 'Your ${car.make} ${car.model} is overdue for $type.',
                      time: 'Action Required',
                      isUnread: true,
                    ),
                  ),
                );
              }
            }

            for (var item in summary.due) {
              if (item is Map) {
                final type = (item['maintenanceType'] ?? 'Service').toString().replaceAll('_', ' ');
                notifications.add(
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildNotificationItem(
                      icon: Icons.warning_amber_rounded,
                      iconColor: Colors.orange,
                      title: 'Maintenance Due: $type',
                      message: 'Your ${car.make} ${car.model} is due for $type.',
                      time: 'Soon',
                      isUnread: true,
                    ),
                  ),
                );
              }
            }
          }

          if (notifications.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 64, color: Color(0xFFCBD5E1)),
                  SizedBox(height: 16),
                  Text(
                    'No new notifications',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 16),
                  ),
                ],
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: notifications,
          );
        },
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String message,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? const Color(0xFFF8FAFC) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isUnread ? const Color(0xFFE2E8F0) : const Color(0xFFF1F5F9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
                    ),
                    const SizedBox(width: 8),
                    Text(time, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                  ],
                ),
                const SizedBox(height: 4),
                Text(message, style: const TextStyle(fontSize: 14, color: Color(0xFF334155))),
              ],
            ),
          ),
          if (isUnread) ...[
            const SizedBox(width: 12),
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 6),
              decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            ),
          ],
        ],
      ),
    );
  }
}
