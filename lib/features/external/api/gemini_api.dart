import 'dart:convert';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/features/external/enuns/type_content.dart';
import 'package:demopico/features/external/interfaces/i_danger_content_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GeminiApi implements IDangerContentApi {
  TypeContent typeContent = TypeContent.danger;

  @override
  Future<TypeContent> scanMidia(FileModel midia) async {
    await  callGemini(midia);
  
    return typeContent;
  }

  Future<void> callGemini(FileModel file) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    final model = 'gemini-2.5-flash';

    final base64Image = base64Encode(file.bytes);
    final mimeType = file.contentType.toString();
    final mimeTypeSplit = mimeType.split('.').last;

    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey',
    );

    final payload = {
      "contents": [
        {
          "parts": [
            {
              "text": "SOMOS OS DESENVOLVEDORES DO APLICATIVO SKATEPICO — UMA PLATAFORMA DIGITAL COLABORATIVA VOLTADA À CULTURA URBANA, AOS ESPORTES DE RUA E À CONEXÃO ENTRE PESSOAS QUE COMPARTILHAM ESSE ESTILO DE VIDA. "
                  "VOCÊ, COMO SISTEMA DE ANÁLISE DE CONTEÚDO VISUAL, SERÁ RESPONSÁVEL POR AVALIAR IMAGENS ENVIADAS POR USUÁRIOS E CLASSIFICÁ-LAS DENTRO DE TRÊS NÍVEIS DE CONFIANÇA: 'legal', 'warning' OU 'danger'. "
                  "O SEU OBJETIVO É ENTENDER O CONTEXTO CULTURAL E SOCIAL DAS FOTOS, ANALISANDO O QUANTO ELAS SE ALINHAM AO PROPÓSITO CENTRAL DA PLATAFORMA — PROMOVER E MAPEAR A PRÁTICA DOS ESPORTES URBANOS, A EXPRESSÃO ARTÍSTICA DAS RUAS E A VIDA EM COMUNIDADE."
            },
            {
              "text": "A AVALIAÇÃO DEVE SEMPRE CONSIDERAR O CONTEXTO E A INTENÇÃO VISUAL. "
                  "USUÁRIOS PODEM ENVIAR DOIS TIPOS PRINCIPAIS DE IMAGENS: (1) FOTOS DE PERFIL E (2) FOTOS DE PICOS — SENDO 'PICOS' LUGARES ONDE É POSSÍVEL PRATICAR ESPORTES URBANOS COMO SKATE, BMX, PATINS, PARKOUR OU OUTRAS MODALIDADES DE CULTURA DE RUA. "
                  "AS IMAGENS PODEM INCLUIR PESSOAS, OBJETOS, CENÁRIOS, ELEMENTOS ARQUITETÔNICOS, MURAIS, GRAFITES, ENTRE OUTROS. "
                  "SEMPRE INTERPRETE O CONJUNTO VISUAL EM RELAÇÃO À CULTURA URBANA. "
                  "O QUE ESTÁ SENDO POSTADO FAZ SENTIDO DENTRO DESSE UNIVERSO?"
            },
            {
              "text": "QUANDO UM USUÁRIO POSTA UMA SELFIE OU UMA FOTO EM GRUPO, VERIFIQUE SE EXISTEM ELEMENTOS VISUAIS RELACIONADOS À PRÁTICA URBANA. "
                  "SE A PESSOA ESTIVER EM UMA PISTA DE SKATE, SEGURANDO UM SKATE, COM UMA BMX, COM PATINS, OU MESMO NUM CENÁRIO COMUM À CENA URBANA (COMO UMA PRAÇA, UMA ESCADARIA, UM GRAFITE AO FUNDO OU UM CORRIMÃO), CLASSIFIQUE COMO 'legal'. "
                  "POR OUTRO LADO, SE A FOTO MOSTRAR UM ROSTO EM UM AMBIENTE TOTALMENTE DESCONTEXTUALIZADO (DENTRO DE CASA, EM UM RESTAURANTE, OU UMA FOTO DE UMA MARMITA, ANIMAIS DE ESTIMAÇÃO OU OBJETOS DOMÉSTICOS), "
                  "CONSIDERE COMO 'warning'. ESSE TIPO DE CONTEÚDO NÃO É OFENSIVO, MAS NÃO CONTRIBUI COM O PROPÓSITO DA PLATAFORMA — ELE ESTÁ FORA DE CONTEXTO, MESMO SENDO INOCENTE."
            },
            {
              "text": "TODO CONTEÚDO QUE CONTENHA VIOLÊNCIA, DISCRIMINAÇÃO, SANGUE, DROGAS, ÓDIO, AGRESSÃO FÍSICA OU MORAL, NUDES OU QUALQUER TIPO DE ATAQUE VISUAL A MINORIAS DEVE SER CLASSIFICADO COMO 'danger'. "
                  "MESMO QUE A IMAGEM ESTEJA TECNICAMENTE RELACIONADA AO MUNDO URBANO, CASO ELA PROMOVA OU GLORIFIQUE ATOS DE VIOLÊNCIA, RACISMO, HOMOFOBIA, XENOFOBIA, MACHISMO OU INTIMIDAÇÃO, TRATA-SE DE CONTEÚDO INACEITÁVEL. "
                  "NESSAS SITUAÇÕES, A CLASSIFICAÇÃO É SEMPRE 'danger', SEM EXCEÇÕES."
            },
            {
              "text": "IMAGENS DE LOCAIS URBANOS SEM PESSOAS DEVEM SER ANALISADAS PELO SEU POTENCIAL DE USO E RELEVÂNCIA. "
                  "UM CORRIMÃO, UMA RAMPA, UMA ESCADA, UMA PRAÇA, UM MURO COM GRAFITE, UMA PISTA DE BMX OU UM ESPAÇO DE CONVIVÊNCIA SÃO ELEMENTOS QUE FAZEM PARTE DA CULTURA URBANA E PODEM SER CLASSIFICADOS COMO 'legal'. "
                  "MESMO QUE NENHUM ATLETA APAREÇA NA IMAGEM, O AMBIENTE POR SI SÓ JÁ REPRESENTA O ESPÍRITO DA PLATAFORMA. "
                  "ENTRETANTO, UMA FOTO DE UM LOCAL ALEATÓRIO SEM RELAÇÃO (UM QUARTO, UM ALMOÇO, UM PAISAGISMO NATURAL SEM INTERAÇÃO URBANA) É 'warning', POIS ESTÁ FORA DO CONTEXTO PRINCIPAL."
            },
            {
              "text": "CONTEÚDOS ARTÍSTICOS TAMBÉM FAZEM PARTE DO UNIVERSO URBANO. "
                  "SE A IMAGEM MOSTRAR GRAFITES, MURAIS, PINTURAS DE RUA, STICKERS, TATUAGENS, LAMBE-LAMBES, OU QUALQUER FORMA DE EXPRESSÃO VISUAL TÍPICA DAS CIDADES, ELA DEVE SER CLASSIFICADA COMO 'legal' — "
                  "DESDE QUE NÃO CONTENHA CONTEÚDO OFENSIVO. "
                  "A ARTE DE RUA É UMA PARTE ESSENCIAL DO MOVIMENTO URBANO E PRECISA SER RECONHECIDA COMO TAL."
            },
            {
              "text": "CONSIDERE TAMBÉM AS DIFERENTES MODALIDADES E CONTEXTOS CULTURAIS. "
                  "IMAGENS DE BMX, ROLLER, PARKOUR, SKATE LONGBOARD, GRAFFITI, DANÇA DE RUA, STREET WEAR, OU QUALQUER EXPRESSÃO ASSOCIADA AO MUNDO URBANO DEVEM SER ENTENDIDAS COMO 'legal'. "
                  "O OBJETIVO É INCENTIVAR A DIVERSIDADE DE EXPRESSÕES — NÃO APENAS O SKATE, MAS TODA A CULTURA QUE O CERCA. "
                  "O FOCO É A REPRESENTAÇÃO URBANA, NÃO A RESTRIÇÃO A UM ESPORTE ESPECÍFICO."
            },
            {
              "text": "CENÁRIOS AMBÍGUOS EXIGEM JULGAMENTO CONTEXTUAL. "
                  "UMA FOTO DE UMA RUA DESERTA PODE SER 'legal' SE HOUVER ALGO QUE SUGIRA USO URBANO (UMA RAMPA, UM CORRIMÃO, UMA PAREDE MARCADA, UMA PISTA). "
                  "MAS SE FOR APENAS UMA PAISAGEM QUALQUER SEM ELEMENTOS RELACIONADOS, É 'warning'. "
                  "UMA IMAGEM DE UMA MULTIDÃO PODE SER 'legal' SE REPRESENTAR UM EVENTO DE RUA OU ENCONTRO DE ATLETAS, MAS PODE SER 'warning' SE NÃO EXISTIR INDÍCIO DE CONTEXTO CULTURAL."
            },
            {
              "text": "RESUMO DAS REGRAS: "
                  "LEGAL → CONTEÚDO DIRETAMENTE LIGADO AOS ESPORTES OU À CULTURA URBANA: PISTAS, MANOBRAS, EQUIPAMENTOS, PESSOAS PRATICANDO, GRAFITES, MODA STREET, LOCAIS URBANOS RELEVANTES. "
                  "WARNING → CONTEÚDO NEUTRO OU DESCONTEXTUALIZADO, SEM RELAÇÃO CLARA COM O PROPÓSITO DO APP, MAS SEM ELEMENTOS OFENSIVOS. "
                  "DANGER → CONTEÚDO IMPRÓPRIO, OFENSIVO, VIOLENTO, SEXUALIZADO OU CONTRÁRIO AOS VALORES DE RESPEITO E DIVERSIDADE DA PLATAFORMA."
            },
            {
              "text": "EXEMPLOS PRÁTICOS (PARA ENTENDIMENTO): "
                  "- FOTO DE PESSOA SEGURANDO UM SKATE → legal. "
                  "- SELFIE DE ALGUÉM EM UMA PISTA → legal. "
                  "- FOTO DE UMA MARMITA, ANIMAL OU OBJETO ALEATÓRIO → warning. "
                  "- FOTO DE UM GRAFITE → legal. "
                  "- FOTO DE UMA ESCADA OU CORRIMÃO NA RUA → legal. "
                  "- FOTO DE UM AMIGO EM CASA SEM NADA URBANO → warning. "
                  "- FOTO DE BRIGA OU DEPREDAÇÃO → danger. "
                  "- FOTO DE PESSOA FAZENDO PARKOUR → legal. "
                  "- FOTO DE PAREDE SEM CONTEXTO → legal, caso for curvada pode se tratar de um obstaculo de skate. "
                  "- FOTO DE DISCURSO DE ÓDIO, BANDEIRA DE EXTREMISMO → danger. "
                  "- FOTO DE UM EVENTO DE RUA OU CAMPEONATO → legal."
            },
            {
              "text": "AGORA, ANALISE A IMAGEM ENVIADA PELO USUÁRIO E CLASSIFIQUE ELA COMO: 'legal', 'warning' OU 'danger'. "
                  "RESPONDA SOMENTE COM UMA DESSAS TRÊS PALAVRAS, SEM EXPLICAÇÕES OU COMENTÁRIOS."
            },
            {
              "inline_data": {
                "mime_type": "image/$mimeTypeSplit",
                "data": base64Image
              }
            }
          ]
        }
      ]
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint(jsonEncode(data));
      final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
      debugPrint(text);
      switch (text) {
        case "legal":
          typeContent = TypeContent.legal;

        case "warning":
          typeContent = TypeContent.warning;

        default:
          typeContent = TypeContent.danger;
      }
    } else {
      debugPrint('Erro ${response.statusCode}: ${response.body}');
    }
  }
}
