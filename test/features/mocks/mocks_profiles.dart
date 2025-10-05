// MOCKS para a classe Profile
import 'package:demopico/features/profile/domain/models/profile_user.dart';

// MOCK 1: Perfil Válido e Completo
// Este perfil tem todos os campos preenchidos corretamente, representando
// um cenário de sucesso.
final Profile mockProfileCompleto = Profile(
  userID: 'user-001-abc',
  displayName: 'Skater_Pro',
  avatar: 'http://example.com/avatar/skater.png',
  description: 'Adoro skate e rock and roll!',
  backgroundPicture: 'http://example.com/background/park.jpg',
  connections: ['user-002', 'user-003'],
  spots: ['spot-001', 'spot-002'],
  posts: ['post-001', 'post-002', 'post-003'],
  profileRule: RuleProfile.owner,
);

// MOCK 2: Perfil Válido com Campos Opcionais Nulos ou Vazios
// Este perfil simula um usuário recém-criado, com apenas os campos obrigatórios.
final Profile mockProfileNovo = Profile(
  userID: 'user-004-def',
  displayName: 'Novo_Skater',
  profileRule: RuleProfile.owner,
  // Os campos 'avatar', 'description', 'backgroundPicture' serão nulos
  // e as listas serão vazias por padrão, como definido no construtor.
);

// MOCK 3: Mock para Simular Dados Inválidos (para uso em testes de validação)
// Este é um mapa que simula um erro comum: falta de um campo obrigatório (userID).
// Você pode usar este mock para testar a validação antes de criar o objeto Profile.
final Map<String, dynamic> mockDadosIncompletos = {
  'displayName': 'UsuarioSemID',
  'avatar': 'http://example.com/avatar/missing.png',
  'profileRule': 'owner',
};

// MOCK 4: Mock para Simular Erro de Tipo (para uso em testes de conversão)
// Este mapa simula um erro onde um campo espera uma String, mas recebe um número.
// O construtor Profile.fromData deve lançar um erro nesse caso.
final Map<String, dynamic> mockDadosComTipoIncorreto = {
  'userID': 'user-005-ghi',
  'displayName': 12345, // ERRO: Espera String, mas é um Int
  'avatar': 'http://example.com/avatar/broken.png',
  'profileRule': 'owner',
};

// MOCK 5: Perfil com Regra de Visualizador
// Este perfil pode ser usado para testar cenários de permissão.
final Profile mockProfileViewer = Profile(
  userID: 'user-006-jkl',
  displayName: 'Visualizador',
  profileRule: RuleProfile.viewer,
);