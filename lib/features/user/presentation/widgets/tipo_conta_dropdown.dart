import 'package:demopico/features/user/presentation/widgets/textfield_decoration.dart';
import 'package:flutter/material.dart';

class TipoContaDropdownButton extends StatefulWidget {
  final Function(String) onChanged; // Callback para notificar a seleção
  final String? Function(String?)? validator;

  const TipoContaDropdownButton({super.key, required this.onChanged, required this.validator});

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
      decoration: customTextFieldDecoration("Tipo de conta"),
      dropdownColor: const Color.fromARGB(255, 139, 0, 0),
      initialValue: _selectedValue,
      items: _items,
      validator: widget.validator,
      onChanged: (String? newValue) {
        setState(() {
          _selectedValue = newValue;
        });
        widget.onChanged(newValue!); // Notifica a escolha para o pai
      },
    );
  }
}