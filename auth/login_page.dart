import 'package:flutter/material.dart';

import 'usuario_app.dart';
import 'store_selection_page.dart';
import '../home/home_page.dart';

// ============================================================
// LOGIN
// ============================================================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usuarioController = TextEditingController();
  final senhaController = TextEditingController();

  bool ocultarSenha = true;
  bool entrando = false;

  @override
  void dispose() {
    usuarioController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  void entrar() {
    if (entrando) return;

    final usuario = usuarioController.text.trim();
    final senha = senhaController.text;

    if (usuario.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Informe o usuário e a senha.'),
        ),
      );
      return;
    }

    final usuarioAutenticado = autenticarUsuario(usuario, senha);

    if (usuarioAutenticado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário ou senha inválidos.'),
        ),
      );
      return;
    }

    setState(() {
      entrando = true;
    });

    if (usuarioAutenticado.administrador) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => StoreSelectionPage(
            usuario: usuarioAutenticado,
          ),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(
          usuario: usuarioAutenticado,
          lojaSelecionada: usuarioAutenticado.loja!,
        ),
      ),
    );
  }

@override
Widget build(BuildContext context) {

  return Scaffold(
    body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF063B7A),
            Color(0xFF0757B8),
            Color(0xFF0B6ED1),
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 440,
              ),
              child: Column(
                children: [
                  // LOGO
                  Container(
                    width: 92,
                    height: 92,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.18),
                          blurRadius: 30,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.storefront_rounded,
                      size: 48,
                      color: Color(0xFF0757B8),
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'AVENIDA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Gestão e operações',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.78),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 34),

                  // CARD LOGIN
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.18),
                          blurRadius: 40,
                          offset: const Offset(0, 18),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bem-vindo!',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF172033),
                          ),
                        ),

                        const SizedBox(height: 7),

                        Text(
                          'Entre com seu usuário para acessar o sistema.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 28),

                        const Text(
                          'USUÁRIO',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: .8,
                            color: Color(0xFF667085),
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextField(
                          controller: usuarioController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'Digite seu usuário',
                            prefixIcon: Icon(
                              Icons.person_outline_rounded,
                            ),
                          ),
                          onSubmitted: (_) {
                            FocusScope.of(context).nextFocus();
                          },
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'SENHA',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: .8,
                            color: Color(0xFF667085),
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextField(
                          controller: senhaController,
                          obscureText: ocultarSenha,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: 'Digite sua senha',
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  ocultarSenha = !ocultarSenha;
                                });
                              },
                              icon: Icon(
                                ocultarSenha
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                          onSubmitted: (_) => entrar(),
                        ),

                        const SizedBox(height: 28),

                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: entrando ? null : entrar,
                            child: AnimatedSwitcher(
                              duration: const Duration(
                                milliseconds: 200,
                              ),
                              child: entrando
                                  ? const SizedBox(
                                      key: ValueKey('loading'),
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Row(
                                      key: ValueKey('login'),
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.login_rounded,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Entrar no sistema',
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified_user_outlined,
                              size: 15,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Acesso protegido',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Supermercado Avenida • Sistema interno',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.60),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}

