import 'package:buddypay_digital_wallet/features/homepage/presentation/view/homepage_view.dart';
import 'package:buddypay_digital_wallet/features/send_credits/presentation/view_models/bloc/send_credit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreditScreen extends StatelessWidget {
  final String? fullname;
  final String? phone;
  CreditScreen({super.key, this.fullname, this.phone});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final _gap = const SizedBox(height: 8);

  @override
  Widget build(BuildContext context) {
    if (phone != null && phone!.isNotEmpty) {
      _recipientController.text = phone!;
    }
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        const Text(
                          'Send Credit',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Brand Bold",
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 30),
                        _gap,
                        TextField(
                          controller: _recipientController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: '+977 9876543210',
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[900],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _gap,
                        TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Amount',
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[900],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _gap,
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              context.read<SendCreditBloc>().add(
                                    SendCreditRequested(
                                      context: context,
                                      recipientNumber:
                                          _recipientController.text,
                                      amount:
                                          double.parse(_amountController.text),
                                    ),
                                  );
                            }
                          },
                          child: const SizedBox(
                            height: 50,
                            child: Center(
                              child: Text(
                                'Send Credit',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Brand Bold',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Add the Positioned widget here
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false, // Remove all previous routes
                );
              },
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
