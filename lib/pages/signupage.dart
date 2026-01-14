import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  
  final TextEditingController _ageController = TextEditingController();
  
  
  String? _ageErrorText;
  bool _isUnderage = false;

  void _validateAge(String value) {
    if (value.isEmpty) {
      setState(() {
        _ageErrorText = null;
        _isUnderage = false;
      });
      return;
    }

    int? age = int.tryParse(value);

    setState(() {
      if (age == null) {
        _ageErrorText = "Masukkan angka yang valid";
        _isUnderage = true;
      } else if (age < 17) {
        _ageErrorText = "Maaf, umur minimal penyewa adalah 17 tahun";
        _isUnderage = true;
      } else {
        _ageErrorText = null;
        _isUnderage = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Daftar Penyewa"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Lengkapi Data Diri",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              _buildInputField("Nama Lengkap", Icons.person_outline),
              const SizedBox(height: 15),
              _buildInputField("Alamat Lengkap", Icons.home_outlined),
              const SizedBox(height: 15),

              
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                onChanged: _validateAge, 
                decoration: InputDecoration(
                  labelText: "Umur",
                  errorText: _ageErrorText, 
                  prefixIcon: const Icon(Icons.calendar_today_outlined),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 20),

              
              Opacity(
                opacity: _isUnderage ? 0.5 : 1.0,
                child: AbsorbPointer(
                  absorbing: _isUnderage, 
                  child: _buildVerificationCard(),
                ),
              ),

              const SizedBox(height: 40),

              
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isUnderage ? null : () {
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3C72),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    "Selesaikan Pendaftaran",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildVerificationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          const Icon(Icons.camera_front, size: 40, color: Color(0xFF1E3C72)),
          const SizedBox(height: 10),
          const Text("Verifikasi Identitas", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Text("Ambil foto SIM/KTP untuk keamanan sewa", textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
          const SizedBox(height: 15),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt),
            label: const Text("Buka Kamera"),
          )
        ],
      ),
    );
  }
}