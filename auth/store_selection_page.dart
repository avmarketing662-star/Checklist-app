import 'package:flutter/material.dart';

import 'usuario_app.dart';
import '../home/home_page.dart';
import 'login_page.dart';
// SELEÇÃO DE LOJA PARA ADMINISTRADOR
// ============================================================

class StoreSelectionPage extends StatelessWidget {
  final UsuarioApp usuario;

  const StoreSelectionPage({
    super.key,
    required this.usuario,
  });

  void selecionarLoja(BuildContext context, String loja) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(
          usuario: usuario,
          lojaSelecionada: loja,
        ),
      ),
    );
  }

  void sair(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
      (route) => false,
    );
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF5F7FB),

    appBar: AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 20,
      title: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF3FF),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.admin_panel_settings_rounded,
              color: Color(0xFF0757B8),
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Avenida',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Painel administrativo',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF667085),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          tooltip: 'Sair',
          onPressed: () => sair(context),
          icon: const Icon(
            Icons.logout_rounded,
          ),
        ),
        const SizedBox(width: 8),
      ],
    ),

    body: ListView(
      padding: const EdgeInsets.fromLTRB(
        20,
        16,
        20,
        30,
      ),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF063B7A),
                Color(0xFF0757B8),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.14),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.manage_accounts_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Olá, administrador',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      usuario.usuario,
                      style: TextStyle(
                        color: Colors.white.withOpacity(.75),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),

        const Text(
          'Escolha uma unidade',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF172033),
          ),
        ),

        const SizedBox(height: 6),

        Text(
          'Selecione a loja que deseja visualizar.',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 20),

        ...lojasApp.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final loja = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child:
               Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => selecionarLoja(
                    context,
                    loja,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFE4E9F0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF3FF),
                            borderRadius:
                                BorderRadius.circular(17),
                          ),
                          child: const Icon(
                            Icons.storefront_rounded,
                            color: Color(0xFF0757B8),
                            size: 28,
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                loja,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF172033),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Unidade ${index + 1} • Acessar operação',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F6FA),
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 19,
                            color: Color(0xFF0757B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}
}

