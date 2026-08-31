
import 'package:flutter/material.dart';

import '../models/models.dart';

// ============================================================
// EDITAR / CRIAR PREVENÇÃO
// ============================================================

class EditarPrevencaoPage extends StatefulWidget {
  final Prevencao? prevencao;

  const EditarPrevencaoPage({
    super.key,
    this.prevencao,
  });

  @override
  State<EditarPrevencaoPage> createState() =>
      _EditarPrevencaoPageState();
}

class _EditarPrevencaoPageState
    extends State<EditarPrevencaoPage> {

  late TextEditingController tituloController;
  late TextEditingController descricaoController;

  late List<EtapaPrevencao> etapas;

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void initState() {
    super.initState();

    final prevencao = widget.prevencao;

    tituloController = TextEditingController(
      text: prevencao?.titulo ?? '',
    );

    descricaoController = TextEditingController(
      text: prevencao?.descricao ?? '',
    );

    etapas = prevencao == null
        ? []
        : prevencao.etapas
            .map(
              (etapa) => EtapaPrevencao(
                id: etapa.id,
                ordem: etapa.ordem,
                descricao: etapa.descricao,
              ),
            )
            .toList();
  }

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    tituloController.dispose();
    descricaoController.dispose();

    super.dispose();
  }

  // ==========================================================
  // ADICIONAR ETAPA
  // ==========================================================

  void adicionarEtapa() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Nova etapa',
          ),

          content: TextField(
            controller: controller,
            autofocus: true,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'O que deve ser feito?',
              hintText:
                  'Descreva a ação desta etapa...',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancelar',
              ),
            ),

            FilledButton(
              onPressed: () {
                final texto =
                    controller.text.trim();

                if (texto.isEmpty) {
                  return;
                }

                setState(() {
                  etapas.add(
                    EtapaPrevencao(
                      id: DateTime.now()
                          .microsecondsSinceEpoch
                          .toString(),
                      ordem: etapas.length + 1,
                      descricao: texto,
                    ),
                  );
                });

                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Adicionar',
              ),
            ),
          ],
        );
      },
    ).then((_) {
      controller.dispose();
    });
  }

  // ==========================================================
  // EDITAR ETAPA
  // ==========================================================

  void editarEtapa(int index) {
    final controller = TextEditingController(
      text: etapas[index].descricao,
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Editar etapa',
          ),

          content: TextField(
            controller: controller,
            autofocus: true,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Descrição',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancelar',
              ),
            ),

            FilledButton(
              onPressed: () {
                final texto =
                    controller.text.trim();

                if (texto.isEmpty) {
                  return;
                }

                setState(() {
                  etapas[index].descricao = texto;
                });

                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Salvar',
              ),
            ),
          ],
        );
      },
    ).then((_) {
      controller.dispose();
    });
  }

  // ==========================================================
  // EXCLUIR ETAPA
  // ==========================================================

  void excluirEtapa(int index) {
    setState(() {
      etapas.removeAt(index);

      _atualizarOrdem();
    });
  }

  // ==========================================================
  // MOVER PARA CIMA
  // ==========================================================

  void moverParaCima(int index) {
    if (index <= 0) {
      return;
    }

    setState(() {
      final temp = etapas[index];

      etapas[index] = etapas[index - 1];
      etapas[index - 1] = temp;

      _atualizarOrdem();
    });
  }

  // ==========================================================
  // MOVER PARA BAIXO
  // ==========================================================

  void moverParaBaixo(int index) {
    if (index >= etapas.length - 1) {
      return;
    }

    setState(() {
      final temp = etapas[index];

      etapas[index] = etapas[index + 1];
      etapas[index + 1] = temp;

      _atualizarOrdem();
    });
  }

  // ==========================================================
  // ATUALIZAR ORDEM
  // ==========================================================

  void _atualizarOrdem() {
    for (int i = 0; i < etapas.length; i++) {
      etapas[i].ordem = i + 1;
    }
  }

  // ==========================================================
  // SALVAR
  // ==========================================================

  void salvar() {
    final titulo =
        tituloController.text.trim();

    final descricao =
        descricaoController.text.trim();

    // --------------------------------------------------------
    // VALIDAR TÍTULO
    // --------------------------------------------------------

    if (titulo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Digite o título da prevenção.',
          ),
        ),
      );

      return;
    }

    // --------------------------------------------------------
    // VALIDAR ETAPAS
    // --------------------------------------------------------

    if (etapas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Adicione pelo menos uma etapa.',
          ),
        ),
      );

      return;
    }

    _atualizarOrdem();

    // --------------------------------------------------------
    // EDITAR
    // --------------------------------------------------------

    if (widget.prevencao != null) {
      final prevencao = widget.prevencao!;

      prevencao.titulo = titulo;
      prevencao.descricao = descricao;
      prevencao.etapas = etapas;

      Navigator.pop(
        context,
        prevencao,
      );

      return;
    }

    // --------------------------------------------------------
    // NOVA
    // --------------------------------------------------------

    final nova = Prevencao(
      id: DateTime.now()
          .microsecondsSinceEpoch
          .toString(),
      titulo: titulo,
      descricao: descricao,
      etapas: etapas,
    );

    Navigator.pop(
      context,
      nova,
    );
  }

  // ==========================================================
  // ITEM DO MENU
  // ==========================================================

  Widget _itemMenu(
    IconData icone,
    String texto,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icone,
          size: 20,
        ),

        const SizedBox(
          width: 10,
        ),

        Text(
          texto,
        ),
      ],
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final bool editando =
        widget.prevencao != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          editando
              ? 'Editar Prevenção'
              : 'Nova Prevenção',
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [

            // ==================================================
            // TÍTULO
            // ==================================================

            TextField(
              controller: tituloController,
              textInputAction:
                  TextInputAction.next,

              decoration: const InputDecoration(
                labelText:
                    'Título da prevenção',

                hintText:
                    'Ex.: Cheiro de gás',

                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // ==================================================
            // DESCRIÇÃO
            // ==================================================

            TextField(
              controller:
                  descricaoController,

              maxLines: 4,

              decoration:
                  const InputDecoration(
                labelText:
                    'Descrição',

                hintText:
                    'Explique brevemente quando este procedimento deve ser utilizado.',

                border:
                    OutlineInputBorder(),

                alignLabelWithHint:
                    true,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            // ==================================================
            // ETAPAS
            // ==================================================

            Wrap(
              alignment:
                  WrapAlignment.spaceBetween,

              crossAxisAlignment:
                  WrapCrossAlignment.center,

              spacing: 10,

              runSpacing: 10,

              children: [

                const Text(
                  'Etapas do procedimento',

                  style: TextStyle(
                    fontSize: 21,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                FilledButton.icon(
                  onPressed:
                      adicionarEtapa,

                  icon: const Icon(
                    Icons.add,
                  ),

                  label: const Text(
                    'Adicionar',
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            // ==================================================
            // NENHUMA ETAPA
            // ==================================================

            if (etapas.isEmpty)
              const Card(
                child: Padding(
                  padding:
                      EdgeInsets.all(20),

                  child: Center(
                    child: Text(
                      'Nenhuma etapa adicionada.',
                      textAlign:
                          TextAlign.center,
                    ),
                  ),
                ),
              ),

            // ==================================================
            // LISTA DE ETAPAS
            // ==================================================

            if (etapas.isNotEmpty)
              ...List.generate(
                etapas.length,
                (index) {
                  final etapa =
                      etapas[index];

                  return Card(
                    margin:
                        const EdgeInsets.only(
                      bottom: 10,
                    ),

                    child: Padding(
                      padding:
                          const EdgeInsets.all(
                        12,
                      ),

                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          // ==================================
                          // NÚMERO
                          // ==================================

                          CircleAvatar(
                            radius: 20,

                            child: Text(
                              '${index + 1}',
                            ),
                          ),

                          const SizedBox(
                            width: 12,
                          ),

                          // ==================================
                          // DESCRIÇÃO
                          // ==================================

                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(
                                top: 4,
                              ),

                              child: Text(
                                etapa.descricao,

                                maxLines: 3,

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 4,
                          ),

                          // ==================================
                          // MENU
                          // ==================================

                          PopupMenuButton<String>(
                            padding:
                                EdgeInsets.zero,

                            tooltip:
                                'Opções da etapa',

                            onSelected:
                                (valor) {
                              switch (valor) {
                                case 'editar':
                                  editarEtapa(
                                    index,
                                  );
                                  break;

                                case 'cima':
                                  moverParaCima(
                                    index,
                                  );
                                  break;

                                case 'baixo':
                                  moverParaBaixo(
                                    index,
                                  );
                                  break;

                                case 'excluir':
                                  excluirEtapa(
                                    index,
                                  );
                                  break;
                              }
                            },

                            itemBuilder:
                                (context) => [

                              PopupMenuItem<String>(
                                value:
                                    'editar',

                                child:
                                    _itemMenu(
                                  Icons.edit,
                                  'Editar',
                                ),
                              ),

                              PopupMenuItem<String>(
                                value:
                                    'cima',

                                child:
                                    _itemMenu(
                                  Icons
                                      .arrow_upward,
                                  'Mover para cima',
                                ),
                              ),

                              PopupMenuItem<String>(
                                value:
                                    'baixo',

                                child:
                                    _itemMenu(
                                  Icons
                                      .arrow_downward,
                                  'Mover para baixo',
                                ),
                              ),

                              PopupMenuItem<String>(
                                value:
                                    'excluir',

                                child:
                                    _itemMenu(
                                  Icons.delete,
                                  'Excluir',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

            const SizedBox(
              height: 20,
            ),

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
                      : 'Criar prevenção',
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

