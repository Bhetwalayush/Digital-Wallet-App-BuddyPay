import 'dart:async';

import 'package:buddypay_digital_wallet/app/constants/api_endpoints.dart';
import 'package:buddypay_digital_wallet/app/shared_prefs/token_shared_prefs.dart';
import 'package:buddypay_digital_wallet/app/shared_prefs/user_shared_prefs.dart';
import 'package:buddypay_digital_wallet/core/common/internet_checker/internet_checker.dart';
import 'package:buddypay_digital_wallet/core/common/snackbar/my_snackbar.dart';
import 'package:buddypay_digital_wallet/features/add_balance/presentation/view/recharge_view.dart';
import 'package:buddypay_digital_wallet/features/homepage/data/datasource/home_remote_datasource.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view/bottom_view/contacts_view.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view/bottom_view/profile_view.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view/bottom_view/qr_code_view.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view/bottom_view/transactions_view.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view_models/cubit/home_cubit.dart';
import 'package:buddypay_digital_wallet/features/homepage/presentation/view_models/cubit/theme_cubit.dart';
import 'package:buddypay_digital_wallet/features/send_credits/presentation/view/send_credits_view.dart';
import 'package:buddypay_digital_wallet/view/notification_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isThemeVisible = false;
  String userName = 'Loading...';
  int balance = 0;
  String? userImage;
  late UserSharedPrefs userSharedPrefs;
  late TokenSharedPrefs tokenSharedPrefs;
  late ThemeCubit _themeCubit;
  GyroscopeEvent? _gyroscopeEvent;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  late final GlobalKey<ScaffoldState> _scaffoldKey;
  List<Map<String, dynamic>> recentStatements = [];

  @override
  void initState() {
    super.initState();
    _themeCubit = context.read<ThemeCubit>();
    _initializeSharedPrefs().then((_) {
      _fetchRecentStatements();
    });
    _scaffoldKey = GlobalKey<ScaffoldState>();

    _streamSubscriptions.add(
      gyroscopeEventStream().listen(
        (GyroscopeEvent event) {
          setState(() {
            _gyroscopeEvent = event;
          });
          _checkTiltForDrawer();
        },
        onError: (e) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("Sensor Not Found"),
                content: Text(
                    "It seems that your device doesn't support Gyroscope Sensor"),
              );
            },
          );
        },
        cancelOnError: true,
      ),
    );
  }

  @override
  void dispose() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }

  void _checkTiltForDrawer() {
    // Define a threshold for tilt sensitivity
    const tiltThreshold = 1.5;

    if (_gyroscopeEvent != null) {
      // Check if the X-axis tilt exceeds the threshold to open/close the drawer
      if (_gyroscopeEvent!.x > tiltThreshold &&
          !_scaffoldKey.currentState!.isDrawerOpen) {
        _scaffoldKey.currentState!.openDrawer();
      } else if (_gyroscopeEvent!.x < -tiltThreshold &&
          _scaffoldKey.currentState!.isDrawerOpen) {
        _scaffoldKey.currentState!.closeDrawer();
      }
    }
  }

  Future<void> _initializeSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    userSharedPrefs = UserSharedPrefs(prefs);
    tokenSharedPrefs = TokenSharedPrefs(prefs);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userNameResult = await userSharedPrefs.getUserName();
    final balanceResult = await userSharedPrefs.getUserBalance();
    final imageResult = await userSharedPrefs.getImage();
    final token = await userSharedPrefs.getUserToken();
    final homeRemoteDataSource = HomeRemoteDatasource(Dio(), userSharedPrefs);
    final internetChecker = InternetChecker();
    // final clearData = await userSharedPrefs.clearUserData();

    userNameResult.fold(
      (failure) {
        // Handle failure (show an error message, for example)
        setState(() {
          userName = 'Error loading user name';
        });
      },
      (name) {
        setState(() {
          userName = name ?? 'Unknown';
        });
      },
    );

    balanceResult.fold(
      (failure) {
        // Handle failure (show an error message, for example)
        setState(() {
          balance = 0;
        });
      },
      (balance) {
        setState(() {
          balance = balance ?? 0;
        });
      },
    );
    try {
      // Check network connectivity
      bool isOnline =
          await internetChecker.isConnected(); // Use the InternetChecker class

      if (isOnline) {
        print("Fetching balance from remote...");
        final fetchedBalance = await homeRemoteDataSource.fetchBalance();
        print("Fetched balance: $fetchedBalance");

        setState(() {
          balance = fetchedBalance;
        });
      } else {
        print("No internet connection, using shared preferences balance.");
        final sharedPrefsBalance = await userSharedPrefs.getUserBalance();
        sharedPrefsBalance.fold(
          (failure) {
            setState(() {
              balance = 0;
            });
          },
          (storedBalance) {
            setState(() {
              balance = storedBalance ?? 0;
            });
          },
        );
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        balance = 0;
      });
    }

    imageResult.fold(
      (failure) {
        setState(() {
          userImage = null; // Handle failure by setting null
        });
      },
      (image) {
        setState(() {
          userImage = image != null ? ApiEndpoints.imageUrl + image : null;
        });
      },
    );
  }

  Future<void> _fetchRecentStatements() async {
    try {
      final homeRemoteDataSource = HomeRemoteDatasource(Dio(), userSharedPrefs);
      final statements = await homeRemoteDataSource.fetchStatement();
      setState(() {
        recentStatements = statements; // Update UI with statements
      });
    } catch (e) {
      print("Error fetching statements: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final currentTheme = themeCubit.state;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: userImage != null && userImage!.isNotEmpty
                  ? NetworkImage(userImage!) // Load from network
                  : const AssetImage('assets/images/profile.png')
                      as ImageProvider,
            ),
            const SizedBox(width: 10),
            Text(
              'Hi! $userName',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
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
          ),
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  // Now, this context has a valid Scaffold ancestor.
                  Scaffold.of(context)
                      .openDrawer(); // Example for using Scaffold.
                },
                icon: const Icon(Icons.menu),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: DefaultTextStyle(
          style: Theme.of(context)
              .textTheme
              .bodyMedium!, // Apply the global text style here
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                // decoration: const BoxDecoration(
                //   color: Colors.black,
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          userImage != null && userImage!.isNotEmpty
                              ? NetworkImage(userImage!)
                              : const AssetImage('assets/images/profile.png')
                                  as ImageProvider,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
              ),
              ListTile(
                  leading: const Icon(Icons.color_lens),
                  title: const Text('Theme'),
                  subtitle: const Text('Select app theme'),
                  trailing: const Icon(Icons.arrow_drop_down),
                  onTap: () {
                    // Theme Selection Buttons
                    _isThemeVisible = !_isThemeVisible;
                  }),
              // _buildThemeButton(
              //     context, "Default", AppTheme.defaultTheme, currentTheme),
              // _buildThemeButton(context, "Light", AppTheme.light, currentTheme),
              // _buildThemeButton(context, "Dark", AppTheme.dark, currentTheme),
              if (_isThemeVisible) ...[
                _buildThemeButton(
                    context, "Default", AppTheme.defaultTheme, currentTheme),
                _buildThemeButton(
                    context, "Light", AppTheme.light, currentTheme),
                _buildThemeButton(context, "Dark", AppTheme.dark, currentTheme),
              ],
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text(
                  'Logout',
                ),
                onTap: () async {
                  // Clear user data from shared preferences
                  await userSharedPrefs.clearUserData();
                  await tokenSharedPrefs.clearToken();

                  // Show SnackBar for feedback
                  showMySnackBar(
                    context: context,
                    message: 'Logging out...',
                    color: Colors.red,
                  );

                  // Ensure that context is still mounted before calling the logout function
                  if (context.mounted) {
                    // Call the logout function inside a Future.delayed to allow asynchronous operation
                    Future.delayed(const Duration(seconds: 1), () {
                      if (context.mounted) {
                        // Only navigate to the login screen if the context is still mounted
                        context.read<HomeCubit>().logout(context);
                      }
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
        child: Column(
          children: [
            Flexible(
              flex: 0,
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
                        Text(
                          'Rs ${balance.toStringAsFixed(2)}',
                          style: const TextStyle(
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
                                  builder: (context) => CreditScreen()),
                            );
                          },
                          icon: const Icon(Icons.send),
                          label: const Text(
                            'SEND',
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
                                  builder: (context) => RechargeScreen()),
                            );
                          },
                          icon: const Icon(Icons.request_page),
                          label: const Text(
                            'RECHARGE',
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
            const SizedBox(height: 14),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              // flex: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Statement",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to full statement history page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Transactions()),
                      );
                    },
                    child: const Text(
                      "Recent",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),

            // **Recent Statements List**
            recentStatements.isEmpty
                ? const Center(child: Text("No recent transactions"))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListView.builder(
                      shrinkWrap: true, // Prevent scrolling issues
                      itemCount: recentStatements.length,
                      itemBuilder: (context, index) {
                        final statement = recentStatements[index];

                        // Format the createdAt date
                        String formattedDate = "Unknown Date";
                        if (statement["createdAt"] != null) {
                          DateTime dateTime =
                              DateTime.parse(statement["createdAt"]);
                          formattedDate = DateFormat("dd MMM yyyy, hh:mm a")
                              .format(dateTime);
                        }

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          elevation: 2,
                          child: ListTile(
                            title: Text(
                              statement["statement"] ?? "Transaction",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle:
                                Text(formattedDate), // Show formatted date
                            trailing: Text(
                              "Rs ${statement["amount"]}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18, // Increased font size
                                color: Color.fromARGB(255, 108, 229, 112),
                              ),
                            ),
                          ),
                        );
                      },
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
                    icon: const Icon(Icons.person),
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

  Widget _buildThemeButton(BuildContext context, String label, AppTheme theme,
      AppTheme currentTheme) {
    return ListTile(
      leading: Icon(
        theme == AppTheme.defaultTheme
            ? Icons.color_lens
            : theme == AppTheme.light
                ? Icons.wb_sunny
                : Icons.nightlight_round,
      ),
      title: Text(label),
      tileColor: theme == currentTheme ? Colors.teal.withOpacity(0.2) : null,
      selected: theme == currentTheme,
      onTap: () {
        context.read<ThemeCubit>().setTheme(theme); // Set the theme
        setState(() {
          _isThemeVisible = false; // Hide theme options after selection
        });
      },
    );
  }
}
