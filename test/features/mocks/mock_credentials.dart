import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/location_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/vulgo_vo.dart';

final EmailCredentialsSignIn userCredentialsSignInEmail = EmailCredentialsSignIn(
    identifier: EmailVO("email@gmail.com"),  senha: PasswordVo("senhad32ddfkdo"));

final VulgoCredentialsSignIn vulgoCredentialsSignIn = VulgoCredentialsSignIn(
    vulgo: VulgoVo("vulgo"), password: PasswordVo("senhad32ddfkdo"));

final NormalUserCredentialsSignUp normalUserCredentialsSignUp = NormalUserCredentialsSignUp(
     vulgo: VulgoVo("vulgo"), password: PasswordVo("senhad32ddfkdo"),email: EmailVO("email@gmail.com"),avatar: "avatar", location: LocationVo.empty());
