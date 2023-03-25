import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/loginPage');
                },
                icon: const Icon(Icons.arrow_back)),
            const Center(
                child: Text(
              'Anasayfa',
              style: TextStyle(color: Colors.white),
            )),
          ],
        ),
      ),
    );
  }
}
