
// ============================================================
// MODELO - PROCEDIMENTO DO FLUXOGRAMA
// ============================================================

class ProcedimentoFluxograma {
  String id;
  String descricao;
  String? horario;

  ProcedimentoFluxograma({
    required this.id,
    required this.descricao,
    this.horario,
  });
}
