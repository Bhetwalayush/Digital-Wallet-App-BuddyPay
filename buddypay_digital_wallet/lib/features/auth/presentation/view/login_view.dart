import 'package:buddypay_digital_wallet/app/shared_prefs/user_shared_prefs.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/login/login_bloc.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view/homepage_view.dart';
import 'package:buddypay_digital_wallet/features/landing_page/view/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LocalAuthentication _localAuth = LocalAuthentication();
  final _gap = const SizedBox(height: 8);

  late UserSharedPrefs userSharedPrefs;
  String? loadedPhone; // Declare loadedPhone here

  @override
  void initState() {
    super.initState();
    _loadPhoneNumber();
  }

  // Method to load phone number from SharedPreferences
  // Method to load phone number from SharedPreferences
  Future<void> _loadPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    userSharedPrefs = UserSharedPrefs(prefs);

    // Get phone from SharedPreferences, which returns Either<Failure, String?>
    final result = await userSharedPrefs.getPhone();

    // Handle the result using fold
    result.fold(
      (failure) {
        // Handle failure (optional logging or showing a message)
        setState(() {
          loadedPhone = null; // Set to null if there's a failure
        });
      },
      (phone) {
        // If successful, update the loadedPhone
        setState(() {
          loadedPhone = phone;
        });
      },
    );
  }

  // Method to authenticate using biometrics
  Future<void> _authenticateWithBiometrics(BuildContext context) async {
    try {
      bool canAuthenticate = await _localAuth.canCheckBiometrics ||
          await _localAuth.isDeviceSupported();

      if (!canAuthenticate) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Biometric authentication not available')),
        );
        return;
      }

      List<BiometricType> availableBiometrics =
          await _localAuth.getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('No biometric data enrolled on this device')),
        );
        return;
      }

      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to log in',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        if (loadedPhone != null && loadedPhone!.isNotEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login with Credentials first')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Biometric authentication failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during biometric authentication: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          'Login',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Brand Bold",
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 30),
                        _gap,
                        if (loadedPhone == null || loadedPhone!.isEmpty) ...[
                          // Show login form if phone number is empty
                          TextField(
                            controller: _phoneController,
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
                            controller: _passwordController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Password',
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
                                context.read<LoginBloc>().add(
                                      LoginUserEvent(
                                        context: context,
                                        phone: _phoneController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                              }
                            },
                            child: const SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Brand Bold',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ] else ...[
                          // If phone is not empty, show the fingerprint icon for biometric login
                          Center(
                            child: GestureDetector(
                              onTap: () => _authenticateWithBiometrics(context),
                              child: const Icon(
                                Icons.fingerprint,
                                size: 50, // Adjust size as needed
                                color: Colors.white, // Adjust color as needed
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Close button for redirecting to LandingPage
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingPage()),
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
