import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications, color: AppColors.primary),
              ),
              title: Text(
                index % 2 == 0 ? 'Booking Confirmed!' : 'Special Offer!',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                index % 2 == 0
                    ? 'Your decor setup for Diwali is confirmed for tomorrow.'
                    : 'Get 20% off on all catering orders today.',
              ),
              trailing: Text(
                '${index + 1}h ago',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}
