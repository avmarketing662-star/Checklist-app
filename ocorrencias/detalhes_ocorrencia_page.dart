import 'package:flutter/material.dart';

import '../models/models.dart';

// ============================================================
// DETALHES DA OCORRÊNCIA
// ============================================================

class DetalhesOcorrenciaPage
    extends StatefulWidget {
  final Ocorrencia ocorrencia;

  const DetalhesOcorrenciaPage({
    super.key,
    required this.ocorrencia,
  });

  @override
  State<DetalhesOcorrenciaPage>
      createState() =>
          _DetalhesOcorrenciaPageState();
}

class _DetalhesOcorrenciaPageState
    extends State<DetalhesOcorrenciaPage> {

  late TextEditingController
      responsavelController;

  late TextEditingController
      solucaoController;

  @override
  void initState() {
    super.initState();

    responsavelController =
        TextEditingController(
      text:
          widget.ocorrencia
                  .responsavelManutencao ??
              '',
    );

    solucaoController =
        TextEditingController(
      text:
          widget.ocorrencia.solucao ??
              '',
    );
  }

  @override
  void dispose() {
    responsavelController.dispose();
    solucaoController.dispose();
    super.dispose();
  }

  void concluir() {
    final responsavel =
        responsavelController.text.trim();

    final solucao =
        solucaoController.text.trim();

    if (responsavel.isEmpty ||
        solucao.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Informe o responsável e o que foi feito.',
          ),
        ),
      );
      return;
    }

    setState(() {
      widget.ocorrencia.status =
          'Concluída';

      widget.ocorrencia
              .responsavelManutencao =
          responsavel;

      widget.ocorrencia.solucao =
          solucao;

      widget.ocorrencia
              .dataConclusao =
          DateTime.now();
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Ocorrência concluída!',
        ),
      ),
    );

    Navigator.pop(
      context,
      true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ocorrencia =
        widget.ocorrencia;

    final concluida =
        ocorrencia.status ==
            'Concluída';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ocorrência #${ocorrencia.numero}',
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  ocorrencia.titulo,
                  style:
                      const TextStyle(
                    fontSize: 25,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),

              _statusOcorrenciaDetalhe(
                ocorrencia.status,
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          Card(
            child: Padding(
              padding:
                  const EdgeInsets.all(
                16,
              ),
              child: Column(
                children: [
                  _linhaInfo(
                    Icons.store,
                    'Loja',
                    ocorrencia.loja,
                  ),
                  const Divider(),
                  _linhaInfo(
                    Icons.location_on,
                    'Setor',
                    ocorrencia.setor,
                  ),
                  const Divider(),
                  _linhaInfo(
                    Icons.calendar_today,
                    'Abertura',
                    _formatarDataHora(
                      ocorrencia
                          .dataAbertura,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          const Text(
            'Problema relatado',
            style:
                TextStyle(
              fontSize: 19,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          Card(
            child: Padding(
              padding:
                  const EdgeInsets.all(
                16,
              ),
              child: Text(
                ocorrencia.descricao,
              ),
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          if (!concluida) ...[
            const Text(
              'Atendimento da manutenção',
              style:
                  TextStyle(
                fontSize: 19,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            TextField(
              controller:
                  responsavelController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Responsável pela manutenção',
                prefixIcon:
                    Icon(
                  Icons.person,
                ),
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            TextField(
              controller:
                  solucaoController,
              maxLines: 6,
              decoration:
                  const InputDecoration(
                labelText:
                    'O que foi feito?',
                hintText:
                    'Descreva a solução realizada...',
                border:
                    OutlineInputBorder(),
                alignLabelWithHint:
                    true,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            SizedBox(
              height: 52,
              child:
                  FilledButton.icon(
                onPressed:
                    concluir,
                icon:
                    const Icon(
                  Icons.check,
                ),
                label:
                    const Text(
                  'Concluir ocorrência',
                ),
              ),
            ),
          ],

          if (concluida) ...[
            const Text(
              'Manutenção realizada',
              style:
                  TextStyle(
                fontSize: 19,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(
                  16,
                ),
                child: Column(
                  children: [
                    _linhaInfo(
                      Icons.person,
                      'Responsável',
                      ocorrencia
                              .responsavelManutencao ??
                          '-',
                    ),

                    const Divider(),

                    _linhaInfo(
                      Icons.build,
                      'Solução',
                      ocorrencia
                              .solucao ??
                          '-',
                    ),

                    if (ocorrencia
                            .dataConclusao !=
                        null) ...[
                      const Divider(),
                      _linhaInfo(
                        Icons.calendar_today,
                        'Conclusão',
                        _formatarDataHora(
                          ocorrencia
                              .dataConclusao!,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _statusOcorrenciaDetalhe(
    String status,
  ) {
    final concluida =
        status == 'Concluída';

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration:
          BoxDecoration(
        color: concluida
            ? Colors.green
                .withOpacity(0.1)
            : Colors.orange
                .withOpacity(0.1),
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: concluida
              ? Colors.green
              : Colors.orange,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }

  Widget _linhaInfo(
    IconData icone,
    String titulo,
    String valor,
  ) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Icon(
          icone,
          size: 20,
          color: Colors.grey,
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,
            children: [
              Text(
                titulo,
                style:
                    const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                valor,
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatarDataHora(
    DateTime data,
  ) {
    final dia =
        data.day.toString().padLeft(
              2,
              '0',
            );

    final mes =
        data.month.toString().padLeft(
              2,
              '0',
            );

    final hora =
        data.hour.toString().padLeft(
              2,
              '0',
            );

    final minuto =
        data.minute.toString().padLeft(
              2,
              '0',
            );

    return '$dia/$mes/${data.year} às $hora:$minuto';
  }
}

