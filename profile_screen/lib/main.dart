import 'package:flutter/material.dart';
import 'package:profile_screen/info_row.dart';
import 'package:profile_screen/profile_header.dart';

import 'data.dart' as data;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('My Profile')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const ProfileHeader(
                name: data.myName,
                university: data.myUniversity,
              ),
              const SizedBox(height: 24),

              for (final fact in data.facts)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InfoRow(label: fact.label, value: fact.value),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
