import 'package:buddypay_digital_wallet/app/shared_prefs/user_shared_prefs.dart';
import 'package:buddypay_digital_wallet/features/homepage/data/datasource/home_remote_datasource.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view/bottom_view/contacts_view.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view/bottom_view/profile_view.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view/bottom_view/qr_code_view.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view/homepage_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:shared_preferences/shared_preferences.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  List<dynamic> recentStatements = [];

  @override
  void initState() {
    super.initState();
    _fetchRecentStatements();
  }

  Future<void> _fetchRecentStatements() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userSharedPrefs = UserSharedPrefs(prefs);
      final homeRemoteDataSource = HomeRemoteDatasource(Dio(), userSharedPrefs);

      final statements = await homeRemoteDataSource.fetchAllStatement();
      setState(() {
        recentStatements = statements; // Update UI with statements
      });
    } catch (e) {
      print("Error fetching statements: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statement History"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: recentStatements.isEmpty
            ? const Center(child: Text("No recent transactions"))
            : ListView.builder(
                itemCount: recentStatements.length,
                itemBuilder: (context, index) {
                  final statement = recentStatements[index];

                  // Format the createdAt date
                  String formattedDate = "Unknown Date";
                  if (statement["createdAt"] != null) {
                    DateTime dateTime = DateTime.parse(statement["createdAt"]);
                    formattedDate =
                        DateFormat("dd MMM yyyy, hh:mm a").format(dateTime);
                  }

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        statement["statement"] ?? "Transaction",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(formattedDate), // Show formatted date
                      trailing: Text(
                        "Rs ${statement["amount"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18, // Increased font size
                          color: Colors.green,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home Button
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              icon: const Icon(Icons.home),
              iconSize: 30,
            ),

            // Transactions Button
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Transactions()),
                );
              },
              icon: const Icon(Icons.sync_alt, color: Colors.teal),
              iconSize: 30,
            ),

            // Center QR Code Scanner Button
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QRCodeScreen()),
                  );
                },
                icon: const Icon(Icons.qr_code_scanner),
                iconSize: 40,
                color: Colors.white,
              ),
            ),

            // Contacts Button
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactsPage()),
                );
              },
              icon: const Icon(Icons.contacts),
              iconSize: 30,
            ),

            // Profile Button (Highlighted in Teal)
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              icon: const Icon(
                Icons.person,
              ),
              iconSize: 30,
            ),
          ],
        ),
      ),
    );
  }
}
