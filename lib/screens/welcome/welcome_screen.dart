import 'package:flutter/material.dart';
import 'package:quiz_app_project/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004643),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Center(
                      child: Container(
                        width: 160.0,
                        height: 160.0,
                        padding: const EdgeInsets.all(20.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "QUIZ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF004643),
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                            color: Color(0xFFEFF0F3),
                            width: 1,
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0xFF004643),
                        hintText: "Enter your name",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                        contentPadding: const EdgeInsets.all(10.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFEFF0F3),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(defaultPadding * 0.75),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF8C660),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Text("Start Quiz",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: Colors.black)),
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
