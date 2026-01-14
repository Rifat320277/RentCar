import 'package:flutter/material.dart';
import 'signupage.dart'; 
import 'home.dart';   

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(), 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  
                  const Icon(
                    Icons.directions_car_filled,
                    size: 60,
                    color: Color(0xFF1E3C72),
                  ),
                  const Text(
                    "RentCar",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3C72),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // -------------------

                  // Input Email dengan Animasi Labelr
                  _buildTextField("Email", Icons.email_outlined, false),
                  const SizedBox(height: 15),
                  
                  // Input Password dengan Animasi Label
                  _buildTextField("Password", Icons.lock_outline, true),
                  
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {}, 
                      child: const Text("Forgot Password?")
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Tombol Log In
                  _buildButton("Log In", Colors.orange[700]!, () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  }),
                  
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignupPage()),
                          );
                        }, 
                        child: const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Header dengan Gambar dan Gradasi
  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 300,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50), 
              bottomRight: Radius.circular(50)
            ),
            image: DecorationImage(
              image: AssetImage('assets/car_bg.jpg'), 
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50), 
              bottomRight: Radius.circular(50)
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            ),
          ),
        ),
        const Positioned(
          bottom: 30, left: 30,
          child: Text(
            "Find Your\nPerfect Car",
            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // Widget TextField dengan Animasi Floating Label
  Widget _buildTextField(String label, IconData icon, bool isPassword) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label, // Menggunakan labelText agar teks pindah ke atas
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: const Color(0xFF1E3C72)),
        filled: true,
        fillColor: Colors.grey[100],
        floatingLabelBehavior: FloatingLabelBehavior.auto, // Animasi otomatis ke atas
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15), 
          borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF1E3C72), width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      ),
    );
  }

  // Widget Tombol Reusable
  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color, 
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}