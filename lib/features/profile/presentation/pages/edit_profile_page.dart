import 'package:cached_network_image/cached_network_image.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/editable_custom_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final user = Get.arguments as UserEntity; 

  late TextEditingController _nameController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: user.profileUser.displayName);
    _bioController = TextEditingController(text: user.profileUser.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _updateProfile() {
    // TODO: UPDATE PROFILE FLOW
    // Lógica para salvar as alterações no banco de dados
    debugPrint('Salvando alterações...');
    
    // ...
    Get.snackbar('Sucesso!', 'Perfil atualizado com sucesso!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kAccentColor,
        colorText: Colors.white);
  }

  void _changeEmail() {
    // TODO: CHANGE EMAIL FLOW
    // Lógica complexa para alterar o e-mail:
    // 1. Mostrar um modal ou nova tela para o usuário confirmar a ação.
    // 2. Enviar um e-mail de validação para o novo endereço.
    // 3. Exibir uma mensagem de sucesso ou erro.
    debugPrint('Iniciando fluxo de alteração de e-mail...');
    Get.snackbar(
      'Atenção',
      'Um link de validação foi enviado para seu e-mail. Por favor, verifique sua caixa de entrada.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blueAccent,
      colorText: Colors.white,
    );
  }

  void _handleChangePassword() {
    // TODO: CHANGE PASSWORD FLOW
    // Lógica complexa para alterar a senha:
    // 1. Mostrar um modal ou nova tela para o usuário inserir a senha atual e a nova senha.
    // 2. Validar a senha atual.
    // 3. Atualizar a senha no banco de dados.
    // 4. Exibir uma mensagem de sucesso ou erro.
    debugPrint('Iniciando fluxo de alteração de senha...');
    Get.snackbar(
      'Atenção',
      'Um link para redefinir sua senha foi enviado para seu e-mail. Por favor, verifique sua caixa de entrada.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blueAccent,
      colorText: Colors.white,
    );
  }

  void _changeProfilePicture() {
    // TODO: CHANGE PROFILE PICTURE FLOW
    // Lógica para abrir a galeria de fotos ou câmera
    debugPrint('Abrindo seletor de imagens...');
    // Implementar lógica de ImagePicker aqui
  }

  void _changeBackgroundPicture() {
    // TODO: CHANGE BACKGROUND PICTURE FLOW
    // Lógica para abrir a galeria de fotos ou câmera
    debugPrint('Abrindo seletor de imagens para o fundo...');
    // Implementar lógica de ImagePicker aqui
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kBlack,),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: kAccentColor),
            onPressed: _updateProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  margin  : const EdgeInsets.all(16),
                  height: 200,
                  decoration: BoxDecoration(
                    image: user.profileUser.backgroundPicture == null ? null : 
                    DecorationImage(
                      image: CachedNetworkImageProvider(user.profileUser.backgroundPicture!, errorListener: (erro) => Icons.error,),
                      fit: BoxFit.cover,
                    ),
                    color: kRedAccent,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 17,
                  child: IconButton(
                    icon: const Icon(Icons.photo_camera, color: kWhite, size: 28),
                    onPressed: _changeBackgroundPicture,
                  ),
                ),
                // Foto de Perfil
                Positioned(
                  bottom: -50,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: kWhite,
                        backgroundImage: user.profileUser.avatar == null 
                          ? AssetImage("assets/images/userPhoto.png") 
                          : CachedNetworkImageProvider(user.profileUser.avatar!),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: kRed,
                          radius: 20,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt, color: kWhite, size: 20),
                            onPressed: _changeProfilePicture,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text('Editar Perfil',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: kRed)),
                  ),
                  const SizedBox(height: 30),
                  EditableCustomField(
                    label: 'Nome',
                    controller: _nameController,
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 20),
                  EditableCustomField(
                    label: 'Bio',
                    controller: _bioController,
                    icon: Icons.description_outlined,
                    isMultiline: true,
                  ),
                  const SizedBox(height: 20),
                  const Text('E-mail',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: kRed)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.email_outlined,
                          color: kRed, size: 24),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(user.email.value,
                            style: const TextStyle(fontSize: 16)),
                      ),
                      TextButton(
                        onPressed: _changeEmail,
                        child: const Text('Alterar E-mail',
                            style: TextStyle(color: kRed)),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.password, color: kWhite),
                      onPressed: _handleChangePassword,
                      label: const Text('Alterar Senha',
                          style: TextStyle(color: kWhite)),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider<Object>? getPfp() {
    if(user.avatar == null){
      return AssetImage("assets/images/userPhoto.png");
    }
    return CachedNetworkImageProvider(user.avatar!);
  }

}