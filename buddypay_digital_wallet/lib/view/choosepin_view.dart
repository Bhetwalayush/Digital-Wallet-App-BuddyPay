import 'package:buddypay_digital_wallet/view/account_created_view.dart';
import 'package:flutter/material.dart';
import '../viewmodels/signup_viewmodel.dart';

class ChoosePinView extends StatefulWidget {
  final SignupViewModel viewModel;

  const ChoosePinView({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<ChoosePinView> createState() => _ChoosePinViewState();
}

class _ChoosePinViewState extends State<ChoosePinView> {
  final TextEditingController _pinController = TextEditingController();

  // Method to navigate back to the signup page
  void _navigateBackToSignup() {
    Navigator.pop(context);
  }
  void _congratspage(){
    
  }
  // Method to save PIN and send data to the database
  void _saveAndCompleteSignup() async {
    if (_pinController.text.trim().length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a 4-digit PIN."),
        ),
      );
      return ;
    }

    // Save PIN in the ViewModel
    widget.viewModel.setPin(_pinController.text.trim());

    // Save all data to the database
    bool success = await widget.viewModel.saveUser();

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup successful!")));
      Navigator.popUntil(context, ModalRoute.withName('/')); // Navigate to the main screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup failed. Please try again.")),
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
          onPressed: _navigateBackToSignup, // Navigate back to signup screen
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
              // onPressed: _saveAndCompleteSignup, // Save PIN and complete signup
              onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CongratsView()),
                    );
                  },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('SAVE'),
            ),
          ],
        ),
      ),
    );
  }
}
