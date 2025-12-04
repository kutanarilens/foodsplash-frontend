import 'package:flutter/material.dart';
import 'package:foodsplash/layout/data/api_services.dart';

class UbahProfilPage extends StatefulWidget {
  final String? initialName;
  final String? initialBio;
  final String? initialGender;
  final String? initialEmail;

  const UbahProfilPage({
    super.key,
    this.initialName,
    this.initialBio,
    this.initialGender,
    this.initialEmail,
  });

  @override
  State<UbahProfilPage> createState() => _UbahProfilPageState();
}

class _UbahProfilPageState extends State<UbahProfilPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _genderController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.initialName ?? ApiServices.username,
    );
    _bioController = TextEditingController(text: widget.initialBio ?? '');
    _genderController = TextEditingController(
      text: widget.initialGender ?? 'Laki-Laki',
    );
    _emailController = TextEditingController(
      text: widget.initialEmail ?? ApiServices.userEmail,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Widget _buildProfileInput({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    VoidCallback? onTap,
    IconData? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 16, color: Colors.black),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            suffixIcon: suffixIcon != null ? Icon(suffixIcon, size: 20) : null,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 20,
              minHeight: 20,
            ),
          ),
        ),
      ],
    );
  }

  void _selectGender(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: const Text('Laki-Laki'),
                onTap: () {
                  _genderController.text = 'Laki-Laki';
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Perempuan'),
                onTap: () {
                  _genderController.text = 'Perempuan';
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Fungsi untuk menyimpan perubahan profil
  void _submitUpdate() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Panggil API service untuk update profil
      // ASUMSI: Anda memiliki fungsi ApiServices.updateProfile
      final result = await ApiServices.updateProfile(
        name: _nameController.text,
        bio: _bioController.text,
        gender: _genderController.text,
        email: _emailController.text,
        birthDate: null,
        phone: '',
      );

      if (result["status"] == "success" && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil berhasil diperbarui!')),
        );
        Navigator.pop(
          context,
          true,
        ); // Kembali ke halaman sebelumnya (AkunPage)
      } else if (mounted) {
        setState(() {
          _errorMessage = result["message"] ?? "Update profil gagal.";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = "Terjadi Kesalahan: ${e.toString()}";
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Ubah Profil",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _submitUpdate,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    "SIMPAN",
                    style: TextStyle(
                      color: Color.fromARGB(255, 25, 118, 210),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // --- Bagian Foto Profil ---
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        "Pasang foto yang oke bossQ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Tambah Foto",
                        style: TextStyle(fontSize: 14, color: Colors.lightBlue),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 30, thickness: 1, color: Color(0xFFE0E0E0)),

              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              // --- Field Input ---
              _buildProfileInput(label: 'Nama', controller: _nameController),

              _buildProfileInput(label: 'Bio', controller: _bioController),

              _buildProfileInput(
                label: 'Jenis Kelamin',
                controller: _genderController,
                readOnly: true,
                suffixIcon: Icons.arrow_drop_down,
                onTap: () => _selectGender(context),
              ),

              // Nomor Handphone (Diasumsikan hanya bagian angkanya)
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Prefix (+62)
                  Container(
                    width: 60,
                    padding: const EdgeInsets.only(bottom: 8),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 15),

              _buildProfileInput(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
