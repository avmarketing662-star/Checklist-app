
// ============================================================
// AUTENTICAÇÃO / USUÁRIOS
// ============================================================

class UsuarioApp {
  final String usuario;
  final String senha;
  final bool administrador;
  final String? loja;

  const UsuarioApp({
    required this.usuario,
    required this.senha,
    required this.administrador,
    this.loja,
  });
}

// ============================================================
// USUÁRIOS DE EXEMPLO
//
// IMPORTANTE: estes dados são locais apenas para esta versão do
// aplicativo. Troque os usuários e senhas pelos dados reais.
// ============================================================

const List<UsuarioApp> usuariosApp = [
  UsuarioApp(
    usuario: 'admin',
    senha: 'admin123',
    administrador: true,
  ),
  UsuarioApp(
    usuario: 'camanducaia',
    senha: '123456',
    administrador: false,
    loja: 'Camanducaia',
  ),
  UsuarioApp(
    usuario: 'itapeva',
    senha: '123456',
    administrador: false,
    loja: 'Itapeva',
  ),
  UsuarioApp(
    usuario: 'extrema',
    senha: '123456',
    administrador: false,
    loja: 'Extrema',
  ),
  UsuarioApp(
    usuario: 'cambui',
    senha: '123456',
    administrador: false,
    loja: 'Cambuí',
  ),
];

const List<String> lojasApp = [
  'Camanducaia',
  'Itapeva',
  'Extrema',
  'Cambuí',
];

UsuarioApp? autenticarUsuario(String usuario, String senha) {
  final login = usuario.trim().toLowerCase();
  final senhaInformada = senha.trim();

  for (final item in usuariosApp) {
    if (item.usuario.toLowerCase() == login &&
        item.senha == senhaInformada) {
      return item;
    }
  }

  return null;
}
