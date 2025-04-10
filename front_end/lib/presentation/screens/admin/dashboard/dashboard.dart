import 'package:flutter/material.dart';
import 'package:front_end/controller/auth/auth_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
                onPressed: () {
                  final authController = AuthController();
                  authController.signOut(context);
                },
                child: const Text('Logout'))),
      ),
    );
  }
}
