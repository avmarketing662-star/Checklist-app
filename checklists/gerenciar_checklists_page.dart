import 'package:flutter/material.dart';

import '../models/models.dart';
import 'editar_checklist_page.dart';

// ============================================================
// GERENCIAR CHECKLISTS
// ============================================================

class GerenciarChecklistsPage
    extends StatefulWidget {

  final List<Checklist> checklists;
  final List<String> categorias;
  final VoidCallback onAtualizar;

  const GerenciarChecklistsPage({
    super.key,
    required this.checklists,
    required this.categorias,
    required this.onAtualizar,
  });

  @override
  State<GerenciarChecklistsPage>
      createState() =>
          _GerenciarChecklistsPageState();
}

class _GerenciarChecklistsPageState
    extends State<
        GerenciarChecklistsPage> {

  String formatarHorario(
    TimeOfDay horario,
  ) {
    final hora =
        horario.hour
            .toString()
            .padLeft(2, '0');

    final minuto =
        horario.minute
            .toString()
            .padLeft(2, '0');

    return '$hora:$minuto';
  }

  void novoChecklist() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditarChecklistPage(
          categorias:
              widget.categorias,
        ),
      ),
    ).then((resultado) {
      if (resultado is Checklist) {
        setState(() {
          widget.checklists
              .add(resultado);
        });

        widget.onAtualizar();
      }
    });
  }

  void editarChecklist(
    Checklist checklist,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditarChecklistPage(
          categorias:
              widget.categorias,
          checklist: checklist,
        ),
      ),
    ).then((resultado) {
      if (resultado is Checklist) {
        setState(() {});
        widget.onAtualizar();
      }
    });
  }

  void excluirChecklist(
    Checklist checklist,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Excluir checklist?',
          ),
          content: Text(
            'O checklist "${checklist.nome}" será excluído.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              child:
                  const Text(
                'Cancelar',
              ),
            ),
            FilledButton(
              onPressed: () {
                setState(() {
                  widget.checklists
                      .remove(
                    checklist,
                  );
                });

                widget.onAtualizar();

                Navigator.pop(
                  context,
                );
              },
              child:
                  const Text(
                'Excluir',
              ),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gerenciar Checklists',
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: novoChecklist,
        icon: const Icon(
          Icons.add,
        ),
        label: const Text(
          'Novo',
        ),
      ),

      body: widget.checklists.isEmpty
          ? const Center(
              child: Text(
                'Nenhum checklist cadastrado.',
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),

              itemCount: widget.checklists.length,

              itemBuilder: (context, index) {
                final checklist =
                    widget.checklists[index];

                return Card(
                  margin: const EdgeInsets.only(
                    bottom: 12,
                  ),

                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),

                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.checklist,
                      ),
                    ),

                    title: Text(
                      checklist.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 4),

                        Text(
                          checklist.categoria,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        if (checklist.usaHorario &&
                            checklist.horarioInicio != null &&
                            checklist.horarioFim != null)
                          Text(
                            '${formatarHorario(checklist.horarioInicio!)} → '
                            '${formatarHorario(checklist.horarioFim!)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        else
                          const Text(
                            'Sem horário',
                          ),

                        Text(
                          '${checklist.tarefas.length} tarefa(s)',
                        ),
                      ],
                    ),

                    trailing: PopupMenuButton<String>(
                      onSelected: (valor) {
                        if (valor == 'editar') {
                          editarChecklist(checklist);
                        }

                        if (valor == 'excluir') {
                          excluirChecklist(checklist);
                        }
                      },

                      itemBuilder: (context) => const [
                        PopupMenuItem<String>(
                          value: 'editar',
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.edit,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Editar',
                              ),
                            ],
                          ),
                        ),

                        PopupMenuItem<String>(
                          value: 'excluir',
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.delete,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Excluir',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
        }