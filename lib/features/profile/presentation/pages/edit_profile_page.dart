import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/editable_detail_row.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({ super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final UserM user = Get.arguments as UserM;

  final String _userPassword = '**********'; // Representing a masked password

  // Controllers for editing
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  // States for AnimatedCrossFade
  bool _isEditingName = false;
  bool _isEditingEmail = false;
  bool _isEditingPassword = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    _passwordController = TextEditingController(text: _userPassword); 
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void toggleEditState(String field) {
    setState(() {
      //TODO : IMPLEMENTAR LÓGICA DE ATUALIZAR NA BASE DE DADOS
      switch (field) {
        case 'name':
          _isEditingName = !_isEditingName;
          if (!_isEditingName) user.name = _nameController.text;
          break;
        case 'email':
          _isEditingEmail = !_isEditingEmail;
          if (!_isEditingEmail) user.email = _emailController.text;
          break;
        case 'password':
          _isEditingPassword = !_isEditingPassword;
          
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: () {
            Get.back();
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
                    backgroundImage: user.pictureUrl != null 
                        ? NetworkImage(user.pictureUrl!)
                        : AssetImage("assets/images/userPhoto.png") as ImageProvider,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Handle "Alterar Imagem" button press
                        debugPrint('Alterar Imagem button pressed');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kRed, // Button background color
                        foregroundColor: kWhite,     // Text color
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
              value: user.name,
              controller: _nameController,
              isEditing: _isEditingName,
              onToggleEdit: () => toggleEditState('name'),
            ),
            EditableDetailRow(
              label: 'Email',
              value: user.email,
              controller: _emailController,
              isEditing: _isEditingEmail,
              onToggleEdit: () => toggleEditState('email'),
              keyboardType: TextInputType.emailAddress,
            ),
            EditableDetailRow(
              label: 'Senha',
              value: _userPassword, // TODO PEGAR O PASSWORD 
              controller: _passwordController,
              isEditing: _isEditingPassword,
              onToggleEdit: () => toggleEditState('password'),
              isPassword: true,
            ),
          ],
        ),
      ),
    );
  }
}