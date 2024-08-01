import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:score_keeper/pages/games_page.dart';
import 'package:score_keeper/pages/history_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
              bodyColor: Color.fromARGB(255, 22, 16, 16),
              displayColor: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, // Button color
            foregroundColor: Colors.white, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 30, vertical: 15), // Button padding
            textStyle: const TextStyle(fontSize: 18), // Button text size
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score Keeper', style: GoogleFonts.poppins()),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpeg'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                context,
                icon: Icons.people,
                label: 'Choose Game',
                destination: const GamesPage(),
              ),
              const SizedBox(height: 20), // Space between buttons
              _buildButton(
                context,
                icon: Icons.history,
                label: 'History',
                destination: const HistoryPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required IconData icon,
      required String label,
      required Widget destination}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.deepPurple),
          title: Text(label,
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          },
        ),
      ),
    );
  }
}
