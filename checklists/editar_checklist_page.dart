import 'package:flutter/material.dart';

import '../models/models.dart';

// ============================================================
// EDITAR CHECKLIST
// ============================================================

class EditarChecklistPage
    extends StatefulWidget {

  final List<String> categorias;
  final Checklist? checklist;

  const EditarChecklistPage({
    super.key,
    required this.categorias,
    this.checklist,
  });

  @override
  State<EditarChecklistPage>
      createState() =>
          _EditarChecklistPageState();
}

class _EditarChecklistPageState
    extends State<
        EditarChecklistPage> {

  late TextEditingController
      nomeController;

  late String categoriaSelecionada;

  bool usaHorario = false;

  TimeOfDay? horarioInicio;
  TimeOfDay? horarioFim;

  late List<Tarefa> tarefas;


@override
void initState() {
  super.initState();

  final checklist = widget.checklist;

  nomeController = TextEditingController(
    text: checklist?.nome ?? '',
  );

  // ---------------------------------------------
  // CATEGORIA
  // ---------------------------------------------

  if (checklist != null &&
      widget.categorias.contains(checklist.categoria)) {
    categoriaSelecionada = checklist.categoria;
  } else if (widget.categorias.isNotEmpty) {
    categoriaSelecionada = widget.categorias.first;
  } else {
    categoriaSelecionada = '';
  }

  // ---------------------------------------------
  // HORÁRIO
  // ---------------------------------------------

  usaHorario = checklist?.usaHorario ?? false;

  horarioInicio = checklist?.horarioInicio;
  horarioFim = checklist?.horarioFim;

  // ---------------------------------------------
  // TAREFAS
  // ---------------------------------------------

  tarefas = checklist == null
      ? []
      : checklist.tarefas
          .map(
            (tarefa) => Tarefa(
              id: tarefa.id,
              descricao: tarefa.descricao,
            ),
          )
          .toList();
}


  @override
  void dispose() {
    nomeController.dispose();
    super.dispose();
  }

  Future<void> escolherHorario(
    bool inicio,
  ) async {
    final horario =
        await showTimePicker(
      context: context,
      initialTime:
          inicio
              ? horarioInicio ??
                  const TimeOfDay(
                    hour: 8,
                    minute: 0,
                  )
              : horarioFim ??
                  const TimeOfDay(
                    hour: 9,
                    minute: 0,
                  ),
    );

    if (horario == null) {
      return;
    }

    setState(() {
      if (inicio) {
        horarioInicio =
            horario;
      } else {
        horarioFim =
            horario;
      }
    });
  }

  void adicionarTarefa() {
    final controller =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Nova tarefa',
          ),
          content:
              TextField(
            controller:
                controller,
            autofocus: true,
            decoration:
                const InputDecoration(
              labelText:
                  'Descrição da tarefa',
              border:
                  OutlineInputBorder(),
            ),
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
                final texto =
                    controller.text
                        .trim();

                if (texto.isEmpty) {
                  return;
                }

                setState(() {
                  tarefas.add(
                    Tarefa(
                      id: DateTime
                          .now()
                          .microsecondsSinceEpoch
                          .toString(),
                      descricao:
                          texto,
                    ),
                  );
                });

                Navigator.pop(
                  context,
                );
              },
              child:
                  const Text(
                'Adicionar',
              ),
            ),
          ],
        );
      },
    );
  }

  void editarTarefa(
    int index,
  ) {
    final controller =
        TextEditingController(
      text:
          tarefas[index]
              .descricao,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Editar tarefa',
          ),
          content:
              TextField(
            controller:
                controller,
            autofocus: true,
            decoration:
                const InputDecoration(
              labelText:
                  'Descrição',
              border:
                  OutlineInputBorder(),
            ),
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
                final texto =
                    controller.text
                        .trim();

                if (texto.isEmpty) {
                  return;
                }

                setState(() {
                  tarefas[index]
                          .descricao =
                      texto;
                });

                Navigator.pop(
                  context,
                );
              },
              child:
                  const Text(
                'Salvar',
              ),
            ),
          ],
        );
      },
    );
  }

  void excluirTarefa(
    int index,
  ) {
    setState(() {
      tarefas.removeAt(index);
    });
  }

  void salvar() {
    final nome =
        nomeController.text.trim();

    if (nome.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Digite o nome do checklist.',
          ),
        ),
      );

      return;
    }

    if (usaHorario &&
        (horarioInicio == null ||
            horarioFim == null)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Escolha o horário inicial e final.',
          ),
        ),
      );

      return;
    }

    if (widget.checklist != null) {
      final checklist =
          widget.checklist!;

      checklist.nome = nome;
      checklist.categoria =
          categoriaSelecionada;
      checklist.usaHorario =
          usaHorario;
      checklist.horarioInicio =
          usaHorario
              ? horarioInicio
              : null;
      checklist.horarioFim =
          usaHorario
              ? horarioFim
              : null;
      checklist.tarefas =
          tarefas;

      Navigator.pop(
        context,
        checklist,
      );

      return;
    }

    final novo =
        Checklist(
      id: DateTime.now()
          .microsecondsSinceEpoch
          .toString(),
      nome: nome,
      categoria:
          categoriaSelecionada,
      usaHorario:
          usaHorario,
      horarioInicio:
          usaHorario
              ? horarioInicio
              : null,
      horarioFim:
          usaHorario
              ? horarioFim
              : null,
      tarefas: tarefas,
    );

    Navigator.pop(
      context,
      novo,
    );
  }

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


@override
Widget build(BuildContext context) {
  final bool editando = widget.checklist != null;

  return Scaffold(
    appBar: AppBar(
      title: Text(
        editando
            ? 'Editar Checklist'
            : 'Novo Checklist',
      ),
    ),

    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          // ==================================================
          // NOME
          // ==================================================

          TextField(
            controller: nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome do checklist',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          // ==================================================
          // CATEGORIA
          // ==================================================

          DropdownButtonFormField<String>(
            value: widget.categorias.contains(
              categoriaSelecionada,
            )
                ? categoriaSelecionada
                : null,

            decoration: const InputDecoration(
              labelText: 'Categoria',
              border: OutlineInputBorder(),
            ),

            items: widget.categorias.isEmpty
                ? null
                : widget.categorias.map(
                    (categoria) {
                      return DropdownMenuItem<String>(
                        value: categoria,
                        child: Text(
                          categoria,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ).toList(),

            onChanged: widget.categorias.isEmpty
                ? null
                : (valor) {
                    if (valor == null) {
                      return;
                    }

                    setState(() {
                      categoriaSelecionada = valor;
                    });
                  },
          ),

          const SizedBox(height: 10),

          // ==================================================
          // HORÁRIO
          // ==================================================

          SwitchListTile(
            contentPadding: EdgeInsets.zero,

            title: const Text(
              'Utilizar horário',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            subtitle: Text(
              usaHorario
                  ? 'Este checklist possui horário definido'
                  : 'Este checklist não possui horário',
            ),

            value: usaHorario,

            onChanged: (valor) {
              setState(() {
                usaHorario = valor;

                if (!valor) {
                  horarioInicio = null;
                  horarioFim = null;
                }
              });
            },
          ),

          // ==================================================
          // HORÁRIOS
          // ==================================================

          if (usaHorario)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),

                child: Column(
                  children: [

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          escolherHorario(true);
                        },

                        icon: const Icon(
                          Icons.access_time,
                        ),

                        label: Text(
                          horarioInicio == null
                              ? 'Selecionar horário de início'
                              : 'Início: ${formatarHorario(horarioInicio!)}',
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          escolherHorario(false);
                        },

                        icon: const Icon(
                          Icons.access_time,
                        ),

                        label: Text(
                          horarioFim == null
                              ? 'Selecionar horário de fim'
                              : 'Fim: ${formatarHorario(horarioFim!)}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 24),

          // ==================================================
          // TAREFAS
          // ==================================================

 Wrap(
  alignment: WrapAlignment.spaceBetween,
  crossAxisAlignment: WrapCrossAlignment.center,
  spacing: 10,
  runSpacing: 10,
  children: [
    const Text(
      'Tarefas',
      style: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
      ),
    ),

    FilledButton.icon(
      onPressed: adicionarTarefa,
      icon: const Icon(Icons.add),
      label: const Text('Adicionar'),
    ),
  ],
),
          const SizedBox(height: 10),

          // ==================================================
          // NENHUMA TAREFA
          // ==================================================

          if (tarefas.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(20),

                child: Center(
                  child: Text(
                    'Nenhuma tarefa adicionada.',
                  ),
                ),
              ),
            ),

          // ==================================================
          // LISTA DE TAREFAS
          // ==================================================

          ...List.generate(
            tarefas.length,
            (index) {

              final tarefa = tarefas[index];


    return Card(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),

      child: Material(
        color: Colors.transparent,

        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),

          leading: CircleAvatar(
            child: Text(
              '${index + 1}',
            ),
          ),

          title: Text(
            tarefa.descricao,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,

            children: [
              IconButton(
                tooltip: 'Editar',

                onPressed: () {
                  editarTarefa(index);
                },

                icon: const Icon(
                  Icons.edit,
                ),
              ),

              IconButton(
                tooltip: 'Excluir',

                onPressed: () {
                  excluirTarefa(index);
                },

                icon: const Icon(
                  Icons.delete,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
),
          const SizedBox(height: 20),

          // ==================================================
          // SALVAR
          // ==================================================

          SizedBox(
            width: double.infinity,
            height: 52,

            child: FilledButton.icon(
              onPressed: salvar,

              icon: const Icon(
                Icons.save,
              ),

              label: Text(
                editando
                    ? 'Salvar alterações'
                    : 'Criar checklist',
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
}
