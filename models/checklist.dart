import 'package:flutter/material.dart';

import 'tarefa.dart';

// ============================================================
// MODELO - CHECKLIST
// ============================================================

class Checklist {
  String id;
  String nome;
  String categoria;
  bool usaHorario;
  TimeOfDay? horarioInicio;
  TimeOfDay? horarioFim;
  List<Tarefa> tarefas;

  Checklist({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.usaHorario,
    this.horarioInicio,
    this.horarioFim,
    required this.tarefas,
  });
}
