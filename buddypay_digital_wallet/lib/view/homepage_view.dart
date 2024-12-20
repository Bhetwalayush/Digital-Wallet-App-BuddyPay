import 'package:buddypay_digital_wallet/view/activity_view.dart';
import 'package:buddypay_digital_wallet/view/additional_options_view.dart';
import 'package:buddypay_digital_wallet/view/contacts_view.dart';
import 'package:buddypay_digital_wallet/view/history_view.dart';
import 'package:buddypay_digital_wallet/view/notification_view.dart';
import 'package:buddypay_digital_wallet/view/profile_view.dart';
import 'package:buddypay_digital_wallet/view/qr_code_view.dart';
import 'package:buddypay_digital_wallet/view/request_credits_view.dart';
import 'package:buddypay_digital_wallet/view/send_credits_view.dart';
import 'package:buddypay_digital_wallet/view/topup_view.dart';
import 'package:buddypay_digital_wallet/view/transactions_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(
                  'assets/images/profile.png'), // Add your profile image here
            ),
            SizedBox(width: 10),
            Text(
              'Hi! Ayush',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationView()),
              );
            },
            icon: const Icon(Icons.notifications_none),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
            color: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Enlarged Balance Card
            Flexible(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Balance',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Rs 0.00',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_circle_outline),
                          color: Colors.teal,
                          iconSize: 35,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Graph Placeholder
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: const LinearGradient(
                          colors: [Colors.teal, Colors.transparent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SendCredits()),
                            );
                          },
                          icon: const Icon(Icons.send),
                          label: const Text(
                            'SEND',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            minimumSize: const Size(140, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RequestCredits()),
                            );
                          },
                          icon: const Icon(Icons.request_page),
                          label: const Text(
                            'REQUEST',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            minimumSize: const Size(140, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Enlarged Feature Buttons with Horizontal Scroll
            Expanded(
              flex: 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFeatureButton('Top Up', Icons.account_balance_wallet,
                        context, const Topup()),
                    const SizedBox(width: 20),
                    _buildFeatureButton(
                        'History', Icons.history, context, const History()),
                    const SizedBox(width: 20),
                    _buildFeatureButton(
                        'Activity', Icons.list, context, const Activity()),
                    const SizedBox(width: 20),
                    _buildFeatureButton('More', Icons.more_horiz, context,
                        const AdditionalOptions()),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Bottom Navigation
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                    icon: const Icon(Icons.home, color: Colors.teal),
                    iconSize: 30,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Transactions()),
                      );
                    },
                    icon: const Icon(Icons.sync_alt, color: Colors.white),
                  ),
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
                              builder: (context) => const QrCode()),
                        );
                      },
                      icon: const Icon(Icons.qr_code_scanner,
                          color: Colors.white),
                      iconSize: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Contacts()),
                      );
                    },
                    icon: const Icon(Icons.contacts, color: Colors.white),
                    iconSize: 30,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profile()),
                      );
                    },
                    icon: const Icon(Icons.person, color: Colors.white),
                    iconSize: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureButton(
      String label, IconData icon, BuildContext context, Widget targetPage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetPage),
          );
        },
        child: Column(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Icon(icon, color: Colors.white, size: 50),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
