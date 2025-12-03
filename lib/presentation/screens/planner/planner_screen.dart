import 'package:flutter/material.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _eventType;
  double? _budget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Fest Planner')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Plan your event in seconds',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Event Type',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Diwali', child: Text('Diwali')),
                  DropdownMenuItem(value: 'Birthday', child: Text('Birthday')),
                  DropdownMenuItem(value: 'Housewarming', child: Text('Housewarming')),
                ],
                onChanged: (value) {
                  setState(() {
                    _eventType = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Budget (₹)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _budget = double.tryParse(value ?? '');
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Mock AI Suggestion
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('AI Suggestion'),
                          content: Text(
                            'For $_eventType with budget ₹$_budget, we suggest:\n\n'
                            '1. Flowers & Rangoli Kit (₹500)\n'
                            '2. Sweets Box (₹800)\n'
                            '3. LED Lights Setup (₹1200)',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Items added to cart!')),
                                );
                              },
                              child: const Text('Add All to Cart'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('Get Suggestions'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
