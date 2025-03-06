// import 'package:biometric_storage/biometric_storage.dart';
// import 'package:buddypay_digital_wallet/app/constants/api_endpoints.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AddFingerprintPage extends StatefulWidget {
//   const AddFingerprintPage({super.key});

//   @override
//   _AddFingerprintPageState createState() => _AddFingerprintPageState();
// }

// class _AddFingerprintPageState extends State<AddFingerprintPage> {
//   String? userId;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _getUserId();
//   }

//   Future<void> _getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       userId = prefs.getString('userId');
//     });
//   }

//   Future<void> _addFingerprint() async {
//     if (userId == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("User ID not found!")),
//       );
//       return;
//     }

//     try {
//       final storage = await BiometricStorage().canAuthenticate();
//       if (storage == CanAuthenticateResponse.success) {
//         final bioStorage =
//             await BiometricStorage().getStorage('fingerprint_data');
//         final fingerprint = await bioStorage.read();

//         setState(() {
//           isLoading = true;
//         });

//         final response = await Dio().post(
//           "${ApiEndpoints.baseUrl}/user/update-fingerprint/$userId",
//           data: {"fingerprint": fingerprint},
//         );

//         if (response.statusCode == 200) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Fingerprint updated successfully!")),
//           );
//         } else {
//           throw Exception("Failed to update fingerprint");
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               content: Text("Biometric authentication not available!")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: ${e.toString()}")),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Add Fingerprint")),
//       body: Center(
//         child: isLoading
//             ? const CircularProgressIndicator()
//             : ElevatedButton(
//                 onPressed: _addFingerprint,
//                 child: const Text("Add/Update Fingerprint"),
//               ),
//       ),
//     );
//   }
// }
