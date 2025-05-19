import 'package:demopico/core/common/denunciar/denunciar_service_firebase.dart';
import 'package:demopico/core/common/denunciar/denuncia_model.dart';
import 'package:flutter/material.dart';

class DenunciaDialog extends StatefulWidget {
  final String? idUser;
  final TypePublication typePublication;
  final String idPub;

  const DenunciaDialog({
    super.key,
    required this.idUser,
    required this.typePublication,
    required this.idPub,
  });

  @override
  State<DenunciaDialog> createState() => _DenunciaDialogState();
}

class _DenunciaDialogState extends State<DenunciaDialog> {
  final List<String> _selectedTypes = [];
  final TextEditingController _reasonController = TextEditingController();
  final _denunciarService = DenunciarServiceFirebase();
  bool _isSubmitting = false;

  // Opções de tipos de denúncia
  final List<String> _denunciaTypes = [
    'Spam',
    'Nudez',
    'Violência',
    'Atos ilegais',
    'Discurso de Ódio',
    'Suicídio ou autolesão',
    'Fraude',
    'Outra coisa',
  ];

  Future<void> _submitDenuncia() async {
    if (_selectedTypes.isEmpty || _reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos antes de enviar!')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final denuncia = DenunciaModel(
        type: _selectedTypes,
        content: _reasonController.text,
        idUser: widget.idUser ?? "Anônimo",
        typePublication: widget.typePublication,
        idPub: widget.idPub,
      );

      await _denunciarService.salvarDenuncia(denuncia);
      if (!mounted) return;
        Navigator.of(context).pop(); // Fecha o dialog após sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Denúncia enviada com sucesso!')),
        );
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao enviar denúncia. Tente novamente.')),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tipo de Denúncia'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Escolha uma definição para o problema identificado:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              children: _denunciaTypes.map((type) {
                final isSelected = _selectedTypes.contains(type);
                return FilterChip(
                  label: Text(type),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedTypes.add(type);
                      } else {
                        _selectedTypes.remove(type);
                      }
                    });
                  },
                  selectedColor: Colors.red,
                  checkmarkColor: Colors.white,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Razão',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _reasonController,
              decoration: const InputDecoration(
                labelText: 'Escreva aqui...',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            const Text(
              'A sua denúncia é anônima, a não ser que reporte plágio ou roubo de propriedade intelectual. Nosso time vai analisar o caso e enviar uma conclusão para você via notificações.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submitDenuncia,
          child: _isSubmitting
              ? const CircularProgressIndicator()
              : const Text('Enviar'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }
}
