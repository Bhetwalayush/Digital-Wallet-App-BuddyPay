import 'package:buddypay_digital_wallet/features/landing_page/view/landing_page.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Send Money",
      "description":
          "Send money with BuddyPay. Your payment buddy and partner.",
    },
    {
      "title": "Receive Money",
      "description": "Receive money securely and instantly with BuddyPay.",
    },
    {
      "title": "Load Balance",
      "description":
          "Easily load money to your BuddyPay wallet and get started.",
    },
  ];

  void _goToLandingPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LandingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Text(
                            _onboardingData[index]["title"]!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _onboardingData[index]["description"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          if (index ==
                              _onboardingData.length -
                                  1) // Only show on last page
                            ElevatedButton(
                              onPressed: _goToLandingPage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text("GET STARTED"),
                            ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Page Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingData.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 8,
                    width: _currentPage == index ? 16 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.teal : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
          // Skip Button
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: _goToLandingPage,
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
