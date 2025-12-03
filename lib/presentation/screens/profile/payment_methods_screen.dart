import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Methods')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMethodItem(Icons.payment, 'Google Pay', 'Linked: prabu@okaxis'),
          _buildMethodItem(Icons.smartphone, 'PhonePe', 'Linked: 9876543210@ybl'),
          _buildMethodItem(Icons.credit_card, 'HDFC Bank', '**** **** **** 1234'),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Add New Payment Method'),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodItem(IconData icon, String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.grey),
          onPressed: () {},
        ),
      ),
    );
  }
}
