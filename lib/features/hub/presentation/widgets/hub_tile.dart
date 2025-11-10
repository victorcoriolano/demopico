import 'package:flutter/material.dart';

class HubTile extends StatefulWidget {
  final String userName;
  final String text;
  final bool? isDonation;
  final bool? isEvent;
  const HubTile(
      {super.key,
      required this.userName,
      required this.text,
      this.isDonation,
      this.isEvent});

  @override
  State<HubTile> createState() => _HubTileState();
}

class _HubTileState extends State<HubTile> {
  bool? _isDonation;
  bool? _isEvent;

  void _checkPostType() {
    if (widget.isDonation != null) {
      _isDonation = widget.isDonation ?? false;
      _isEvent = !widget.isDonation!;
    }
    if (widget.isEvent != null) {
      _isEvent = widget.isEvent ?? false;
      _isDonation = !widget.isEvent!;
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkPostType();
    String userName = widget.userName;
    String text = widget.text;
    return Container(
        padding: const EdgeInsets.all(17.0),
        width: 300,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Ícone e nome do usuário
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Expanded(
                    flex: 1,
                    child: Center(
                      child: CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.person),
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: SizedBox(
                      width: 80,
                      child: Text(
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        userName,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Texto do post
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(text,
                  softWrap: true,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 16)),
            )),
            // Ícone de bandeira
            const Icon(Icons.flag),
            // Ícone de donação
            if (_isDonation ?? false) const Icon(Icons.pest_control_rodent),
            if (_isEvent ?? false) const Icon(Icons.event),
          ],
        ));
  }
}
