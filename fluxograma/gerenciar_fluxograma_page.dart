import 'package:flutter/material.dart';

import '../models/models.dart';

// ============================================================
// GERENCIAR FLUXOGRAMA
// ============================================================

class GerenciarFluxogramaPage extends StatefulWidget {
  final List<SetorFluxograma> fluxograma;
  final VoidCallback onAtualizar;

  const GerenciarFluxogramaPage({
    super.key,
    required this.fluxograma,
    required this.onAtualizar,
  });

  @override
  State<GerenciarFluxogramaPage> createState() =>
      _GerenciarFluxogramaPageState();
}

class _GerenciarFluxogramaPageState
    extends State<GerenciarFluxogramaPage> {

  // ==========================================================
  // ADICIONAR / EDITAR SETOR
  // ==========================================================

  void abrirEditorSetor({
    SetorFluxograma? setor,
  }) {
    final nomeController =
        TextEditingController(
      text: setor?.nome ?? '',
    );

    final descricaoController =
        TextEditingController(
      text: setor?.descricao ?? '',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            setor == null
                ? 'Novo setor'
                : 'Editar setor',
          ),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [

                TextField(
                  controller:
                      nomeController,
                  decoration:
                      const InputDecoration(
                    labelText: 'Nome do setor',
                    hintText: 'Ex.: Açougue',
                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                TextField(
                  controller:
                      descricaoController,
                  maxLines: 3,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Descrição',
                    hintText:
                        'Descrição do setor...',
                    border:
                        OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:
                  const Text('Cancelar'),
            ),

            FilledButton(
              onPressed: () {

                final nome =
                    nomeController.text
                        .trim();

                final descricao =
                    descricaoController
                        .text
                        .trim();

                if (nome.isEmpty) {
                  return;
                }

                setState(() {

                  if (setor == null) {

                    widget.fluxograma.add(
                      SetorFluxograma(
                        id: DateTime.now()
                            .microsecondsSinceEpoch
                            .toString(),
                        nome: nome,
                        descricao:
                            descricao,
                        procedimentos: [],
                      ),
                    );

                  } else {

                    setor.nome = nome;
                    setor.descricao =
                        descricao;

                  }

                });

                widget.onAtualizar();

                Navigator.pop(context);
              },
              child:
                  const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // EXCLUIR SETOR
  // ==========================================================

  void excluirSetor(
    SetorFluxograma setor,
  ) {

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(

          title: const Text(
            'Excluir setor?',
          ),

          content: Text(
            'Deseja realmente excluir o setor "${setor.nome}"?',
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:
                  const Text('Cancelar'),
            ),

            FilledButton(
              style:
                  FilledButton.styleFrom(
                backgroundColor:
                    Colors.red,
              ),
              onPressed: () {

                setState(() {
                  widget.fluxograma
                      .remove(setor);
                });

                widget.onAtualizar();

                Navigator.pop(context);
              },
              child:
                  const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // ADICIONAR / EDITAR PROCEDIMENTO
  // ==========================================================

  void abrirEditorProcedimento(
    SetorFluxograma setor, {
    ProcedimentoFluxograma?
        procedimento,
  }) {

    final descricaoController =
        TextEditingController(
      text:
          procedimento?.descricao ??
              '',
    );

    final horarioController =
        TextEditingController(
      text:
          procedimento?.horario ??
              '',
    );

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(

          title: Text(
            procedimento == null
                ? 'Novo procedimento'
                : 'Editar procedimento',
          ),

          content:
              SingleChildScrollView(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [

                TextField(
                  controller:
                      descricaoController,
                  maxLines: 4,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Procedimento',
                    hintText:
                        'Ex.: Fazer limpeza do setor.',
                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                TextField(
                  controller:
                      horarioController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Horário',
                    hintText:
                        'Ex.: 17:00',
                    prefixIcon:
                        Icon(
                      Icons.access_time,
                    ),
                    border:
                        OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:
                  const Text('Cancelar'),
            ),

            FilledButton(
              onPressed: () {

                final descricao =
                    descricaoController
                        .text
                        .trim();

                final horario =
                    horarioController
                        .text
                        .trim();

                if (descricao.isEmpty) {
                  return;
                }

                setState(() {

                  if (procedimento ==
                      null) {

                    setor.procedimentos
                        .add(
                      ProcedimentoFluxograma(
                        id: DateTime.now()
                            .microsecondsSinceEpoch
                            .toString(),
                        descricao:
                            descricao,
                        horario:
                            horario.isEmpty
                                ? null
                                : horario,
                      ),
                    );

                  } else {

                    procedimento
                            .descricao =
                        descricao;

                    procedimento.horario =
                        horario.isEmpty
                            ? null
                            : horario;

                  }

                });

                widget.onAtualizar();

                Navigator.pop(context);
              },
              child:
                  const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // EXCLUIR PROCEDIMENTO
  // ==========================================================

  void excluirProcedimento(
    SetorFluxograma setor,
    ProcedimentoFluxograma
        procedimento,
  ) {

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(

          title: const Text(
            'Excluir procedimento?',
          ),

          content: const Text(
            'Deseja realmente excluir este procedimento?',
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:
                  const Text('Cancelar'),
            ),

            FilledButton(
              style:
                  FilledButton.styleFrom(
                backgroundColor:
                    Colors.red,
              ),
              onPressed: () {

                setState(() {

                  setor.procedimentos
                      .remove(
                    procedimento,
                  );

                });

                widget.onAtualizar();

                Navigator.pop(context);
              },
              child:
                  const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // CARD DO SETOR
  // ==========================================================

  Widget cardSetor(
    SetorFluxograma setor,
  ) {

    return Card(

      margin:
          const EdgeInsets.only(
        bottom: 16,
      ),

      child: ExpansionTile(

        leading:
            const CircleAvatar(
          child: Icon(
            Icons.account_tree,
          ),
        ),

        title: Text(
          setor.nome,
          style:
              const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),

        subtitle: Text(
          '${setor.procedimentos.length} procedimento(s)',
        ),

        children: [

          if (setor.descricao
              .isNotEmpty)

            Padding(
              padding:
                  const EdgeInsets.fromLTRB(
                16,
                0,
                16,
                12,
              ),

              child: Align(
                alignment:
                    Alignment.centerLeft,
                child: Text(
                  setor.descricao,
                  style:
                      const TextStyle(
                    color:
                        Colors.grey,
                  ),
                ),
              ),
            ),

          const Divider(),

          // ==================================================
          // PROCEDIMENTOS
          // ==================================================

          ...setor.procedimentos
              .asMap()
              .entries
              .map(
            (entry) {

              final index =
                  entry.key;

              final procedimento =
                  entry.value;

              return ListTile(

                leading:
                    CircleAvatar(
                  radius: 16,
                  child: Text(
                    '${index + 1}',
                  ),
                ),

                title: Text(
                  procedimento
                      .descricao,
                ),

                subtitle:
                    procedimento
                            .horario
                            ?.isNotEmpty ==
                        true
                    ? Row(
                        children: [
                          const Icon(
                            Icons
                                .access_time,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            procedimento
                                .horario!,
                          ),
                        ],
                      )
                    : null,

                trailing: PopupMenuButton(
                  itemBuilder:
                      (context) => [

                    const PopupMenuItem(
                      value: 'editar',
                      child: Text(
                        'Editar',
                      ),
                    ),

                    const PopupMenuItem(
                      value: 'excluir',
                      child: Text(
                        'Excluir',
                      ),
                    ),
                  ],

                  onSelected:
                      (valor) {

                    if (valor ==
                        'editar') {

                      abrirEditorProcedimento(
                        setor,
                        procedimento:
                            procedimento,
                      );

                    }

                    if (valor ==
                        'excluir') {

                      excluirProcedimento(
                        setor,
                        procedimento,
                      );

                    }
                  },
                ),
              );
            },
          ),

          // ==================================================
          // BOTÃO NOVO PROCEDIMENTO
          // ==================================================

          Padding(
            padding:
                const EdgeInsets.all(
              12,
            ),

            child: SizedBox(
              width:
                  double.infinity,

              child:
                  OutlinedButton.icon(
                onPressed: () {

                  abrirEditorProcedimento(
                    setor,
                  );

                },

                icon:
                    const Icon(
                  Icons.add,
                ),

                label:
                    const Text(
                  'Adicionar procedimento',
                ),
              ),
            ),
          ),

          // ==================================================
          // BOTÕES DO SETOR
          // ==================================================

          Padding(
            padding:
                const EdgeInsets.fromLTRB(
              12,
              0,
              12,
              12,
            ),

            child: Row(
              children: [

                Expanded(
                  child:
                      OutlinedButton.icon(
                    onPressed: () {
                      abrirEditorSetor(
                        setor: setor,
                      );
                    },
                    icon:
                        const Icon(
                      Icons.edit,
                    ),
                    label:
                        const Text(
                      'Editar setor',
                    ),
                  ),
                ),

                const SizedBox(
                  width: 8,
                ),

                IconButton(
                  tooltip:
                      'Excluir setor',
                  color:
                      Colors.red,
                  onPressed: () {
                    excluirSetor(
                      setor,
                    );
                  },
                  icon:
                      const Icon(
                    Icons.delete,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Editar fluxograma',
        ),

      ),

      floatingActionButton:
          FloatingActionButton.extended(

        onPressed: () {
          abrirEditorSetor();
        },

        icon:
            const Icon(
          Icons.add,
        ),

        label:
            const Text(
          'Novo setor',
        ),
      ),

      body: ListView(

        padding:
            const EdgeInsets.all(
          20,
        ),

        children: [

          const Text(
            'Fluxograma',
            style:
                TextStyle(
              fontSize: 28,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 6,
          ),

          const Text(
            'Gerencie os setores e os procedimentos que serão exibidos no fluxograma.',
            style:
                TextStyle(
              color:
                  Colors.grey,
              fontSize: 14,
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          if (widget.fluxograma.isEmpty)

            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(
                  30,
                ),
                child: Column(
                  children: [

                    Icon(
                      Icons
                          .account_tree_outlined,
                      size: 60,
                      color:
                          Colors.grey.shade400,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    const Text(
                      'Nenhum setor cadastrado.',
                      style:
                          TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    const Text(
                      'Adicione o primeiro setor usando o botão abaixo.',
                      textAlign:
                          TextAlign.center,
                      style:
                          TextStyle(
                        color:
                            Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )

          else

            ...widget.fluxograma.map(
              (setor) =>
                  cardSetor(setor),
            ),

          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
