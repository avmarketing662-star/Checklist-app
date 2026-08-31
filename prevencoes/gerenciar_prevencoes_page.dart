import 'package:flutter/material.dart';

import '../models/models.dart';
import 'editar_prevencao_page.dart';

// ============================================================
// GERENCIAR PREVENÇÕES
// ============================================================

class GerenciarPrevencoesPage extends StatefulWidget {
  final List<Prevencao> prevencoes;
  final VoidCallback onAtualizar;

  const GerenciarPrevencoesPage({
    super.key,
    required this.prevencoes,
    required this.onAtualizar,
  });

  @override
  State<GerenciarPrevencoesPage> createState() =>
      _GerenciarPrevencoesPageState();
}

class _GerenciarPrevencoesPageState
    extends State<GerenciarPrevencoesPage> {

  // ==========================================================
  // NOVA PREVENÇÃO
  // ==========================================================

  void novaPrevencao() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditarPrevencaoPage(),
      ),
    ).then((resultado) {
      if (resultado is Prevencao) {
        setState(() {
          widget.prevencoes.add(resultado);
        });

        widget.onAtualizar();
      }
    });
  }

  // ==========================================================
  // EDITAR PREVENÇÃO
  // ==========================================================

  void editarPrevencao(
    Prevencao prevencao,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarPrevencaoPage(
          prevencao: prevencao,
        ),
      ),
    ).then((resultado) {
      if (resultado is Prevencao) {
        setState(() {});
        widget.onAtualizar();
      }
    });
  }

  // ==========================================================
  // EXCLUIR PREVENÇÃO
  // ==========================================================

  void excluirPrevencao(
    Prevencao prevencao,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Excluir prevenção?',
          ),

          content: Text(
            'A prevenção "${prevencao.titulo}" será excluída.',
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
                setState(() {
                  widget.prevencoes.remove(prevencao);
                });

                widget.onAtualizar();

                Navigator.pop(dialogContext);
              },

              child: const Text(
                'Excluir',
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        title: const Text(
          'Gerenciar Prevenções',
        ),
      ),

      // ========================================================
      // BOTÃO NOVA PREVENÇÃO
      // ========================================================

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: novaPrevencao,

        icon: const Icon(
          Icons.add,
        ),

        label: const Text(
          'Nova',
        ),
      ),

      // ========================================================
      // LISTA
      // ========================================================

      body: widget.prevencoes.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma prevenção cadastrada.',
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),

              itemCount: widget.prevencoes.length,

              itemBuilder: (context, index) {
                final prevencao =
                    widget.prevencoes[index];

                // ==================================================
                // CARD
                // ==================================================

                return Card(
                  margin: const EdgeInsets.only(
                    bottom: 12,
                  ),

                  clipBehavior:
                      Clip.antiAlias,

                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),

                    // ==============================================
                    // ÍCONE
                    // ==============================================

                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.shield,
                      ),
                    ),

                    // ==============================================
                    // TÍTULO
                    // ==============================================

                    title: Text(
                      prevencao.titulo,

                      maxLines: 1,

                      overflow:
                          TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    // ==============================================
                    // QUANTIDADE DE ETAPAS
                    // ==============================================

                    subtitle: Text(
                      '${prevencao.etapas.length} etapa(s)',
                    ),

                    // ==============================================
                    // MENU
                    // ==============================================

                    trailing:
                        PopupMenuButton<String>(
                      padding:
                          EdgeInsets.zero,

                      onSelected: (valor) {
                        if (valor == 'editar') {
                          editarPrevencao(
                            prevencao,
                          );
                        }

                        if (valor == 'excluir') {
                          excluirPrevencao(
                            prevencao,
                          );
                        }
                      },

                      itemBuilder:
                          (context) => const [

                        // ========================================
                        // EDITAR
                        // ========================================

                        PopupMenuItem<String>(
                          value: 'editar',

                          child: Row(
                            mainAxisSize:
                                MainAxisSize.min,

                            children: [
                              Icon(
                                Icons.edit,
                              ),

                              SizedBox(
                                width: 10,
                              ),

                              Text(
                                'Editar',
                              ),
                            ],
                          ),
                        ),

                        // ========================================
                        // EXCLUIR
                        // ========================================

                        PopupMenuItem<String>(
                          value: 'excluir',

                          child: Row(
                            mainAxisSize:
                                MainAxisSize.min,

                            children: [
                              Icon(
                                Icons.delete,
                              ),

                              SizedBox(
                                width: 10,
                              ),

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