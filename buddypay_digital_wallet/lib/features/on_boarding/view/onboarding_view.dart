import 'package:buddypay_digital_wallet/features/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:buddypay_digital_wallet/features/on_boarding/cubit/on_boarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  final List<Map<String, String>> onboardingData = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: BlocBuilder<OnboardingCubit, OnboardingState>(
                  builder: (context, state) {
                    return PageView.builder(
                      onPageChanged: (index) {
                        context.read<OnboardingCubit>().updatePage(index);
                      },
                      itemCount: onboardingData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Text(
                                onboardingData[index]["title"]!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                onboardingData[index]["description"]!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              if (index == onboardingData.length - 1)
                                ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<OnboardingCubit>()
                                        .goToLandingPage(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    minimumSize:
                                        const Size(double.infinity, 50),
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
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 8,
                    width: context.watch<OnboardingCubit>().state.currentPage ==
                            index
                        ? 16
                        : 8,
                    decoration: BoxDecoration(
                      color:
                          context.watch<OnboardingCubit>().state.currentPage ==
                                  index
                              ? Colors.teal
                              : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () {
                context.read<OnboardingCubit>().goToLandingPage(context);
              },
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
