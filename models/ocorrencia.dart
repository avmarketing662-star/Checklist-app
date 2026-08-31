
// ============================================================
// MODELO - OCORRÊNCIA
// ============================================================

class Ocorrencia {
  String id;
  String numero;
  String titulo;
  String descricao;
  String loja;
  String setor;

  String status;

  String? responsavelManutencao;
  String? solucao;

  DateTime dataAbertura;
  DateTime? dataConclusao;

  Ocorrencia({
    required this.id,
    required this.numero,
    required this.titulo,
    required this.descricao,
    required this.loja,
    required this.setor,
    required this.status,
    this.responsavelManutencao,
    this.solucao,
    required this.dataAbertura,
    this.dataConclusao,
  });
}
