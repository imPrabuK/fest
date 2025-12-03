import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSupportItem(
            context,
            icon: Icons.chat,
            title: 'Chat with Support',
            subtitle: 'Get instant help from our team',
            onTap: () {},
          ),
          _buildSupportItem(
            context,
            icon: Icons.email,
            title: 'Email Us',
            subtitle: 'support@festfix.com',
            onTap: () {},
          ),
          _buildSupportItem(
            context,
            icon: Icons.phone,
            title: 'Call Us',
            subtitle: '+91 98765 43210',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          const Text(
            'FAQs',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildFAQItem('How do I cancel a booking?', 'You can cancel your booking from the My Orders section up to 24 hours before the scheduled time.'),
          _buildFAQItem('What payment methods are accepted?', 'We accept Credit/Debit cards, UPI (GPay, PhonePe), and Net Banking.'),
          _buildFAQItem('Is there a refund policy?', 'Yes, refunds are processed within 5-7 business days for eligible cancellations.'),
        ],
      ),
    );
  }

  Widget _buildSupportItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return ExpansionTile(
      title: Text(question, style: const TextStyle(fontWeight: FontWeight.w500)),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(answer, style: const TextStyle(color: AppColors.textSecondary)),
        ),
      ],
    );
  }
}
