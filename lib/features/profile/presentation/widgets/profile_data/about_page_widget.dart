import 'package:demopico/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Sobre'),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          color: const Color.fromARGB(255, 139, 0, 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 80),
                // SOBRE NO TOPO
                const Column(
                  children: [
                    Text(
                      'Sobre',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Desenvolvido em 2024 - MOMENTO",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Aplicativo de Geomídia para localização de pontos de interesse.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                // EQUIPE NO MEIO
                const Column(
                  children: [
                    Text(
                      'Equipe de Desenvolvedores',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Gabriel Pires, Arthur Selingin, Enzo Hiroshi, Victor Coriolano',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                // CONTATO E RODAPÉ
                Column(
                  children: [
                    const Text(
                      'Contato',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Email: picoskatepico@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 36),
                    Divider(color: Colors.blueGrey.shade200),
                    const SizedBox(height: 12),
                    const Text(
                      '© 2024 Todos os Direitos Reservados.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
