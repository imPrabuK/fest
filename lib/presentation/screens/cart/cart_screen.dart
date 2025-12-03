import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../../core/constants/app_colors.dart';
import '../booking/booking_summary_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items;

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: items.isEmpty
          ? const Center(child: Text('Cart is Empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(item.serviceName),
                          subtitle: Text(
                            '${item.date.day}/${item.date.month}/${item.date.year} at ${item.time.format(context)}\n${item.price}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: AppColors.error),
                            onPressed: () {
                              cart.removeItem(item.id);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // For now, we'll just take the first item to show the summary flow, 
                        // or we could create a "Bulk Checkout" screen.
                        // Given the existing BookingSummaryScreen takes single item details,
                        // let's assume we want to checkout the first item or modify BookingSummary to handle lists.
                        // For simplicity/MVP, let's just navigate to a new Checkout Screen or reuse BookingSummary for the first item.
                        
                        // Better approach: Create a CheckoutScreen that handles the whole cart.
                        // But to stick to the requested "Payment Methods" task, let's modify BookingSummaryScreen to be more generic 
                        // or create a new PaymentScreen.
                        
                        // Let's create a simple "Checkout" action here that mimics the BookingSummary but for multiple items?
                        // Or just navigate to BookingSummary for the first item as a demo if list has 1 item.
                        
                        if (items.isNotEmpty) {
                           // For this demo, we will just proceed to payment for all items.
                           // We need a screen that shows total and payment options.
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => BookingSummaryScreen(
                                 serviceName: "Cart Checkout", // Placeholder
                                 price: "Calculated at Checkout", // Placeholder
                                 // We need to update BookingSummaryScreen to handle cart or be optional
                                 date: DateTime.now(), 
                                 time: TimeOfDay.now(),
                                 isCartCheckout: true,
                               ),
                             ),
                           );
                        }
                      },
                      child: const Text('Proceed to Checkout'),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
