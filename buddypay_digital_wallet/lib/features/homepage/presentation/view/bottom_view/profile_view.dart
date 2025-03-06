import 'package:buddypay_digital_wallet/app/constants/api_endpoints.dart';
import 'package:buddypay_digital_wallet/app/shared_prefs/user_shared_prefs.dart';
import 'package:buddypay_digital_wallet/features/homepage/data/datasource/home_remote_datasource.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view/bottom_view/contacts_view.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view/bottom_view/qr_code_view.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view/bottom_view/transactions_view.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view/homepage_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late HomeRemoteDatasource _homeRemoteDatasource;
  late UserSharedPrefs _userSharedPrefs;
  Map<String, dynamic>? _userProfile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      _userSharedPrefs = UserSharedPrefs(await SharedPreferences.getInstance());
      _homeRemoteDatasource = HomeRemoteDatasource(Dio(), _userSharedPrefs);

      final userNameResult = await _userSharedPrefs.getUserName();
      final balanceResult = await _userSharedPrefs.getUserBalance();
      final imageResult = await _userSharedPrefs.getImage();

      setState(() {
        _userProfile = {};
      });

      final userProfile = await _homeRemoteDatasource.getUserDetail();

      if (userProfile.isNotEmpty) {
        setState(() {
          _userProfile = userProfile[0];
        });
      } else {
        setState(() {
          _userProfile = {};
        });
      }

      userNameResult.fold(
        (failure) {
          setState(() {
            _userProfile?["fullname"] = "Unknown";
          });
        },
        (name) {
          setState(() {
            _userProfile?["fullname"] = name ?? "Unknown";
          });
        },
      );

      imageResult.fold(
        (failure) {
          setState(() {
            _userProfile?["image"] = null;
          });
        },
        (image) {
          setState(() {
            _userProfile?["image"] =
                image != null ? ApiEndpoints.imageUrl + image : null;
          });
        },
      );

      balanceResult.fold(
        (failure) {
          setState(() {
            _userProfile?["balance"] = 0.0;
          });
        },
        (balance) {
          setState(() {
            _userProfile?["balance"] = balance ?? 0.0;
          });
        },
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error fetching user profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_userProfile == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: const Center(child: Text("Error fetching user details")),
      );
    }

    String formattedDate = DateFormat("dd MMM yyyy")
        .format(DateTime.parse(_userProfile!["createdAt"]));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Account Creation Date
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today, color: Colors.grey),
                const SizedBox(width: 10),
                Text(
                  "Joined: $formattedDate",
                  style: const TextStyle(
                    fontSize: 20, // Bigger font for date
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Profile Image Section
            CircleAvatar(
              radius: 100, // Increased size
              backgroundImage: _userProfile!["image"] != null &&
                      _userProfile!["image"]!.isNotEmpty
                  ? NetworkImage(_userProfile!["image"]!)
                  : const AssetImage('assets/images/profile.png')
                      as ImageProvider,
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(height: 30),

            // Fullname & Phone (More Unique)
            Text(
              _userProfile!["fullname"] ?? "No Name",
              style: const TextStyle(
                fontSize: 28, // Bigger font for Fullname
                fontWeight: FontWeight.bold,
                // color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              _userProfile!["phone"] ?? "No Phone",
              style: const TextStyle(
                fontSize: 25,
                color: Colors.grey,
                fontStyle: FontStyle.italic, // Italics to make phone unique
              ),
            ),
            const SizedBox(height: 20),

            // Balance Section (Centered)
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    "Balance",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Rs ${_userProfile!['balance'].toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 32, // Bigger font for balance
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
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
                    icon: const Icon(Icons.home),
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
                    icon: const Icon(Icons.sync_alt),
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
                              builder: (context) => const QRCodeScreen()),
                        );
                      },
                      icon: const Icon(Icons.qr_code_scanner),
                      iconSize: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactsPage()),
                      );
                    },
                    icon: const Icon(Icons.contacts),
                    iconSize: 30,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()),
                      );
                    },
                    icon: const Icon(Icons.person, color: Colors.teal),
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
}
