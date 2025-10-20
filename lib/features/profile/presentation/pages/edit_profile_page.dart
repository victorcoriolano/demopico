import 'package:cached_network_image/cached_network_image.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/features/mapa/presentation/widgets/spot_info_widgets/custom_buttons.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/editable_custom_field.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:demopico/features/user/presentation/widgets/form_validator.dart';
import 'package:demopico/features/user/presentation/widgets/textfield_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> with Validators {
  UserEntity user = Get.arguments as UserEntity;
  FileModel newBackGround = NullFileModel();
  FileModel newAvatar = NullFileModel();

  late TextEditingController _nameController;
  late TextEditingController _bioController;
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
    _passwordController1.dispose();
    _passwordController2.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _updateProfile() {
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
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [Text("Insira sua nova senha"), Divider()],
            ),
            content: Padding(
              padding: EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: SizedBox(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: customTextField(
                            "Adicione sua nova senha", kLightGrey),
                        controller: _passwordController1,
                        validator: (value) => combineValidators([
                          () => isNotEmpty(value),
                          () => isValidPassword(value),
                        ]),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        decoration:
                            customTextField("Confirme a sua senha", kLightGrey),
                        controller: _passwordController2,
                        validator: (value) => combineValidators([
                          () => isNotEmpty(value),
                          () => isValidPassword(value),
                          () => checkPassword(value, _passwordController1.text),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Cancelar")),
              CustomElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final newPassword =
                            PasswordVo(_passwordController1.text);
                        await context
                            .read<AuthViewModelAccount>()
                            .changePasswordFlow(newPassword);
                      } on Failure catch (e) {
                        FailureServer.showError(e);
                      }
                    }
                  },
                  textButton: "OK")
            ],
          );
        });
  }

  void _changeProfilePicture(bool isBackGround) async {
    // TODO: CHANGE PROFILE PICTURE FLOW
    debugPrint("Alterar foto do avatar");
    final vm = context.read<AuthViewModelAccount>();
    final selectedFile = await vm.selectNewImage(isBackGround);
    if (mounted && selectedFile is! NullFileModel) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<AuthViewModelAccount>(
              builder: (context, vmAccount, child) {
            return AlertDialog(
              title: const Text('Confirme a Imagem'),
              content: Image.memory(selectedFile.bytes),
              actions: <Widget>[
                TextButton(
                  child: const Text('CANCELAR'),
                  onPressed: () {
                    Get.back();
                  },
                ),
                TextButton(
                  child: const Text('Confirmar'),
                  onPressed: () async {
                    if (isBackGround) {
                      //final userUpdated = await vm.uploadBackGroundImage(selectedFile);
                      //debugPrint("UserUpdated: $userUpdated - profile: ${userUpdated.profileUser.backgroundPicture}");
                      setState(() {
                        newBackGround = vmAccount.backgroundImage;
                      });
                    } else {
                      //final userUpdated = await vm.uploadFileProfile(selectedFile);
                      setState(() {
                        newAvatar = vmAccount.avatar;
                      });
                    }
                    Get.back();
                  },
                ),
              ],
            );
          });
        },
      );
    }
  }

  void confirmDiscardingChanges(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Deseja descartar as alterações?"),
          actions: [
            TextButton(
                  child: const Text('CANCELAR'),
                  onPressed: () {
                    Get.back();
                  },
                ),
                TextButton(
                  child: const Text('Confirmar'),
                  onPressed: () async {
                    Get.back();
                    Get.back();
                  },
                ),
          ],
        );
      },
    );
  }

  bool get wasChanged {
    return newAvatar is! NullFileModel 
      || newBackGround is! NullFileModel 
      || _nameController.text != user.displayName.value 
      || _bioController.text != user.profileUser.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kBlack,
          ),
          onPressed: () => wasChanged ? confirmDiscardingChanges() : Get.back(),
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
            SizedBox(
              height: 270.0,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      height: 200,
                      decoration: BoxDecoration(
                        image: newBackGround is NullFileModel
                            ? user.profileUser.backgroundPicture == null
                                ? null
                                : DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      user.profileUser.backgroundPicture!,
                                      errorListener: (erro) => Icons.error,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                            : DecorationImage(
                                image: MemoryImage(newBackGround.bytes)),
                        color: kRedAccent,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 17,
                    child: IconButton(
                      icon: const Icon(Icons.photo_camera,
                          color: kRed, size: 28, ),
                      onPressed: () => _changeProfilePicture(true),
                    ),
                  ),
                  // Foto de Perfil
                  Positioned(
                    bottom: 20,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: kWhite,
                          backgroundImage: newAvatar is NullFileModel
                              ? user.profileUser.avatar == null
                                  ? AssetImage("assets/images/userPhoto.png")
                                  : CachedNetworkImageProvider(
                                      user.profileUser.avatar!)
                              : MemoryImage(newAvatar.bytes),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            backgroundColor: kRed,
                            radius: 20,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt,
                                  color: kWhite, size: 20),
                              onPressed: () => _changeProfilePicture(false),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                      const Icon(Icons.email_outlined, color: kRed, size: 24),
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
}
