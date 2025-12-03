import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import '../../../core/constants/app_colors.dart';
import 'otp_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isEmail(String input) {
    return input.contains('@');
  }

  Future<void> _sendOtp() async {
    if (_formKey.currentState!.validate()) {
      final input = _controller.text.trim();
      
      setState(() {
        _isSending = true;
      });

      try {
        if (_isEmail(input)) {
          // Configure Email OTP
          EmailOTP.config(
            appName: 'FestFix',
            otpType: OTPType.numeric,
            emailTheme: EmailTheme.v1,
          );
          
          // Send Email OTP
          bool result = await EmailOTP.sendOTP(email: input);
          if (!mounted) return;
          
          if (result) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('OTP sent to your email')),
            );
            _navigateToOtp(input, isEmail: true);
          } else {
            _showError('Failed to send Email OTP. Please try again.');
          }
        } else {
          // Mobile Number Logic
          // NOTE: Real SMS requires a paid gateway or Firebase.
          // For this "Free" implementation, we simulate sending.
          await Future.delayed(const Duration(seconds: 1)); // Simulate network
          if (!mounted) return;
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP sent to your mobile (Demo: 1234)')),
          );
          _navigateToOtp(input, isEmail: false);
        }
      } catch (e) {
        _showError('Error: $e');
      } finally {
        if (mounted) {
          setState(() {
            _isSending = false;
          });
        }
      }
    }
  }

  void _navigateToOtp(String contact, {required bool isEmail}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          contactInfo: contact,
          isEmail: isEmail,
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                // Logo or App Name
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.celebration, size: 60, color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    'FestFix',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Your Festival, Our Fix!',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const Spacer(),
                
                const Text(
                  'Login or Signup',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter Email or Mobile Number',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                
                TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.emailAddress, // Works for both
                  decoration: InputDecoration(
                    labelText: 'Email or Mobile Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email or mobile number';
                    }
                    final isEmail = value.contains('@');
                    if (isEmail) {
                       // Simple Email Validation
                       if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                         return 'Please enter a valid email';
                       }
                    } else {
                      // Mobile Validation
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return 'Please enter a valid 10-digit mobile number';
                      }
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 24),
                
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isSending ? null : _sendOtp,
                    child: _isSending 
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text(
                          'Continue',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                  ),
                ),
                const Spacer(),
                const Center(
                  child: Text(
                    'By continuing, you agree to our Terms & Privacy Policy',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
