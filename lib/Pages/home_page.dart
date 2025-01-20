import 'package:flutter/material.dart';

import 'package:quiz_app/Pages/quiz_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the content vertically
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center the content horizontally
          children: [
            SizedBox(
              width: height * 0.3,
            ),
            Image.asset(
              'assets/images/dribbble_shot.webp',
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: height * 0.3,
            ),
            Container(
              width: width * 0.9,
              color: Colors.lightBlue,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Start Quiz",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
