import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/cart_provider.dart';
import 'booking_success_screen.dart';

class BookingSummaryScreen extends StatefulWidget {
  final String serviceName;
  final String price;
  final DateTime date;
  final TimeOfDay time;
  final bool isCartCheckout;

  const BookingSummaryScreen({
    super.key,
    required this.serviceName,
    required this.price,
    required this.date,
    required this.time,
    this.isCartCheckout = false,
  });

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  int _selectedPaymentMethod = 0; // 0: COD, 1: GPay, 2: PhonePe, 3: Bank Transfer

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    
    // Calculate total if cart checkout
    String displayPrice = widget.price;
    if (widget.isCartCheckout) {
       // Simple logic to sum up prices if they were numbers, but they are strings like "Starts from...".
       // For now, let's just show "Calculated at Checkout" or sum if possible.
       // We'll stick to the passed price for now.
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Booking Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    if (widget.isCartCheckout)
                      ...cart.items.map((item) => Column(
                        children: [
                          _buildRow('Service', item.serviceName),
                          _buildRow('Date', '${item.date.day}/${item.date.month}/${item.date.year}'),
                          _buildRow('Time', item.time.format(context)),
                          const Divider(),
                        ],
                      ))
                    else ...[
                      _buildRow('Service', widget.serviceName),
                      const Divider(),
                      _buildRow('Date', '${widget.date.day}/${widget.date.month}/${widget.date.year}'),
                      const Divider(),
                      _buildRow('Time', widget.time.format(context)),
                      const Divider(),
                    ],
                    _buildRow('Total Amount', displayPrice, isBold: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildPaymentOption(0, 'Cash on Delivery', Icons.money),
            _buildPaymentOption(1, 'Google Pay', Icons.payment),
            _buildPaymentOption(2, 'PhonePe', Icons.smartphone),
            _buildPaymentOption(3, 'Bank Transfer', Icons.account_balance),
            
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.isCartCheckout) {
                    cart.checkout();
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const BookingSuccessScreen()),
                  );
                },
                child: const Text('Confirm Booking'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(int index, String title, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: RadioListTile(
        value: index,
        groupValue: _selectedPaymentMethod,
        onChanged: (val) {
          setState(() {
            _selectedPaymentMethod = val as int;
          });
        },
        title: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 12),
            Text(title),
          ],
        ),
        activeColor: AppColors.primary,
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
              color: isBold ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
