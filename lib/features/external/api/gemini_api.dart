import 'dart:convert';
import 'dart:typed_data';
import 'package:demopico/features/external/enuns/type_content.dart';
import 'package:demopico/features/external/interfaces/i_danger_content_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GeminiApi implements IDangerContentApi {
  @override
  TypeContent scanMidia(Uint8List midia) {
    // TODO: implement scanMidia
    throw UnimplementedError();
  }

  Future<void> callGemini() async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    final model = 'gemini-1.5-pro';
    final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent');

    final payload = {
      "contents": [
        {
          "parts": [
            {"text": "Explique rapidamente o que é Dart em 2 frases."}
          ]
        }
      ]
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-goog-api-key': apiKey!,
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // estrutura de retorno segue o exemplo do Quickstart:
      final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
      print('Resposta Gemini: $text');
    } else {
      print('Erro ${response.statusCode}: ${response.body}');
    }
  }
}
