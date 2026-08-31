import 'procedimento_fluxograma.dart';

// ============================================================
// MODELO - SETOR DO FLUXOGRAMA
// ============================================================

class SetorFluxograma {
  String id;
  String nome;
  String descricao;
  List<ProcedimentoFluxograma> procedimentos;

  SetorFluxograma({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.procedimentos,
  });
}
