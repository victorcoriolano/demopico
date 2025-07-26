import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/editable_detail_row.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final UserM user;
  const EditProfilePage({ super.key, required this.user });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
   // Mock user data
  String _userName = 'Akhil newman';
  String _userPhone = '+91 99951 80585';
  String _userEmail = 'akhilnew@gmail.com';
  final String _userPassword = '**********'; // Representing a masked password

  // Controllers for editing
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  // States for AnimatedCrossFade
  bool _isEditingName = false;
  bool _isEditingPhone = false;
  bool _isEditingEmail = false;
  bool _isEditingPassword = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _userName);
    _phoneController = TextEditingController(text: _userPhone);
    _emailController = TextEditingController(text: _userEmail);
    _passwordController = TextEditingController(text: _userPassword); // Display masked initially
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleEditState(String field) {
    setState(() {
      switch (field) {
        case 'name':
          _isEditingName = !_isEditingName;
          if (!_isEditingName) _userName = _nameController.text;
          break;
        case 'phone':
          _isEditingPhone = !_isEditingPhone;
          if (!_isEditingPhone) _userPhone = _phoneController.text;
          break;
        case 'email':
          _isEditingEmail = !_isEditingEmail;
          if (!_isEditingEmail) _userEmail = _emailController.text;
          break;
        case 'password':
          _isEditingPassword = !_isEditingPassword;
          // For password, we might not update directly from text field due to masking
          // A dialog or separate screen might be better for password changes
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back button press
          },
        ),
        elevation: 0, // No shadow
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: widget.user.pictureUrl != null 
                        ? NetworkImage(widget.user.pictureUrl!)
                        : AssetImage("assets/images/userPhoto.png") as ImageProvider,
                  ),
                  SizedBox(width: 16),
                  Expanded( // Use Expanded to give ElevatedButton space
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle "Alterar Imagem" button press
                        print('Alterar Imagem button pressed');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, // Button background color
                        foregroundColor: Colors.white,     // Text color
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Alterar Imagem'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'EDITAR DETALHES',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            EditableDetailRow(
              label: 'Nome',
              value: widget.user.name,
              controller: _nameController,
              isEditing: _isEditingName,
              onToggleEdit: () => _toggleEditState('name'),
            ),
            EditableDetailRow(
              label: 'Email',
              value: widget.user.email,
              controller: _emailController,
              isEditing: _isEditingEmail,
              onToggleEdit: () => _toggleEditState('email'),
              keyboardType: TextInputType.emailAddress,
            ),
            EditableDetailRow(
              label: 'Senha',
              value: _userPassword, // TODO PEGAR O PASSWORD 
              controller: _passwordController,
              isEditing: _isEditingPassword,
              onToggleEdit: () => _toggleEditState('password'),
              isPassword: true,
            ),
          ],
        ),
      ),
    );
  }
}