import 'package:barna_chat/feature_auth/ui/componentes/textfield_custom.dart';
import 'package:flutter/material.dart';

class TipoContaDropdownButton extends StatefulWidget {
  final Function(String) onChanged; // Callback para notificar a seleção

  const TipoContaDropdownButton({super.key, required this.onChanged});

  @override
  State<TipoContaDropdownButton> createState() => _TipoContaDropdownButtonState();
}

class _TipoContaDropdownButtonState extends State<TipoContaDropdownButton> {
  String? _selectedValue; // Valor selecionado

  final List<DropdownMenuItem<String>> _items = [
    const DropdownMenuItem(
      value: 'coletivo',
      child: Text('Coletivo', style: TextStyle(color: Colors.white),),
      
    ),
    const DropdownMenuItem(
      value: 'proprio',
      child: Text('Próprio' , style: TextStyle(color: Colors.white),),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: customTextField("Tipo de conta"),
      dropdownColor: const Color.fromARGB(255, 139, 0, 0),
      value: _selectedValue,
      items: _items,
      onChanged: (String? newValue) {
        setState(() {
          _selectedValue = newValue;
        });
        widget.onChanged(newValue!); // Notifica a escolha para o pai
      },
    );
  }
}