import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/signup/signup_bloc.dart';
import 'package:buddypay_digital_wallet/view/account_created_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoosePinView extends StatefulWidget {
  final String fullname;
  final String phone;
  final String password;

  const ChoosePinView({
    super.key,
    required this.fullname,
    required this.phone,
    required this.password,
  });

  @override
  State<ChoosePinView> createState() => _ChoosePinViewState();
}

class _ChoosePinViewState extends State<ChoosePinView> {
  final TextEditingController _pinController = TextEditingController();

  void _saveAndCompleteSignup() {
    final pin = _pinController.text.trim();

    if (pin.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a 4-digit PIN.")),
      );
      return;
    }

    // Dispatch the event to SignupBloc
    try {
      BlocProvider.of<SignupBloc>(context).add(
        RegisterUser(
          context: context,
          fullname: widget.fullname,
          phone: widget.phone,
          password: widget.password,
          pin: pin,
          device: "mobile",
        ),
      );

      // Navigate to the account creation success view
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CongratsView()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a PIN',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter 4-digit PIN',
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
            ElevatedButton(
              onPressed: _saveAndCompleteSignup,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('CONFIRM'),
            ),
          ],
        ),
      ),
    );
  }
}
