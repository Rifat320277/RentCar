import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Jangan lupa tambah di pubspec.yaml

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _ageController = TextEditingController();
  
  String? _ageErrorText;
  bool _isUnderage = false;
  String _fileName = "Belum ada file terpilih";
  PlatformFile? _pickedFile;

  // Fungsi pilih file (SIM/KTP)
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        _pickedFile = result.files.first;
        _fileName = _pickedFile!.name;
      });
    }
  }

  void _validateAge(String value) {
    if (value.isEmpty) {
      setState(() { _ageErrorText = null; _isUnderage = false; });
      return;
    }
    int? age = int.tryParse(value);
    setState(() {
      if (age == null) {
        _ageErrorText = "Masukkan angka valid";
        _isUnderage = true;
      } else if (age < 17) {
        _ageErrorText = "Umur minimal 17 tahun";
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
      backgroundColor: const Color(0xFFF8FAFC), // Background abu-abu sangat muda (Slate)
      appBar: AppBar(
        title: const Text("Create Account", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF1E3C72),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Personal Information",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF1E3C72)),
              ),
              const Text("Enter your details to start the journey", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 25),

              // Form Pengisian
              _buildInputField("Full Name", Icons.person_outline),
              const SizedBox(height: 15),
              _buildInputField("Home Address", Icons.location_on_outlined),
              const SizedBox(height: 15),
              
              // Input Umur dengan Validasi
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                onChanged: _validateAge,
                decoration: _inputDecoration("Age", Icons.calendar_today_outlined, error: _ageErrorText),
              ),
              const SizedBox(height: 15),
              
              _buildInputField("Email Address", Icons.email_outlined),
              const SizedBox(height: 15),
              _buildInputField("Password", Icons.lock_outline, isPassword: true),
              
              const SizedBox(height: 30),
              const Divider(height: 1, thickness: 1),
              const SizedBox(height: 30),

              // Bagian Upload File SIM/KTP
              const Text(
                "Identity Verification",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E3C72)),
              ),
              const SizedBox(height: 15),
              _buildUploadCard(),

              const SizedBox(height: 40),

              // Tombol Submit
              _buildSubmitButton(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Dekorasi Input
  InputDecoration _inputDecoration(String label, IconData icon, {String? error}) {
    return InputDecoration(
      labelText: label,
      errorText: error,
      prefixIcon: Icon(icon, color: const Color(0xFF1E3C72)),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFF1E3C72), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }

  Widget _buildInputField(String label, IconData icon, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: _inputDecoration(label, icon),
    );
  }

  // Desain Kartu Upload File yang Diperbagus
  Widget _buildUploadCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _pickedFile != null ? Colors.green.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _pickedFile != null ? Colors.green.shade300 : Colors.grey.shade200,
          style: _pickedFile != null ? BorderStyle.solid : BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Icon(
            _pickedFile != null ? Icons.verified_user : Icons.cloud_upload_outlined,
            size: 40,
            color: _pickedFile != null ? Colors.green : const Color(0xFF1E3C72),
          ),
          const SizedBox(height: 10),
          Text(
            _pickedFile != null ? "Document Attached" : "Upload SIM or KTP",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(_fileName, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 15),
          OutlinedButton.icon(
            onPressed: _pickFile,
            icon: const Icon(Icons.file_upload_outlined),
            label: Text(_pickedFile != null ? "Change File" : "Choose File"),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF1E3C72),
              side: const BorderSide(color: Color(0xFF1E3C72)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    bool isFormValid = !_isUnderage && _pickedFile != null && _ageController.text.isNotEmpty;

    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: isFormValid ? () {
          // Aksi Daftar
        } : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E3C72),
          disabledBackgroundColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: isFormValid ? 5 : 0,
        ),
        child: const Text(
          "Complete Registration",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}