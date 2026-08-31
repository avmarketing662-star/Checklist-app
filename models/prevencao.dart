import 'etapa_prevencao.dart';

// ============================================================
// MODELO - PREVENÇÃO
// ============================================================

class Prevencao {
  String id;
  String titulo;
  String descricao;
  List<EtapaPrevencao> etapas;

  Prevencao({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.etapas,
  });
}
