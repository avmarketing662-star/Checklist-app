import 'package:flutter/material.dart';

import '../models/models.dart';

// ============================================================
// NOVA OCORRÊNCIA
// ============================================================

class NovaOcorrenciaPage
    extends StatefulWidget {
  final String numero;
  final String lojaInicial;
  final bool permitirTrocarLoja;

  const NovaOcorrenciaPage({
    super.key,
    required this.numero,
    required this.lojaInicial,
    required this.permitirTrocarLoja,
  });

  @override
  State<NovaOcorrenciaPage> createState() =>
      _NovaOcorrenciaPageState();
}

class _NovaOcorrenciaPageState
    extends State<NovaOcorrenciaPage> {

  final tituloController =
      TextEditingController();

  final descricaoController =
      TextEditingController();

  late String loja;

  String setor = 'Açougue';

  @override
  void initState() {
    super.initState();
    loja = widget.lojaInicial;
  }

  final lojas = [
    'Camanducaia',
    'Extrema',
    'Cambuí',
    'Itapeva',
  ];

  final setores = [
    'Açougue',
    'Padaria',
    'Hortifruti',
    'Reposição',
    'Caixa',
    'Depósito',
    'Limpeza',
    'Administrativo',
    'Loja',
    'Outros',
  ];

  @override
  void dispose() {
    tituloController.dispose();
    descricaoController.dispose();
    super.dispose();
  }

  void salvar() {
    final titulo =
        tituloController.text.trim();

    final descricao =
        descricaoController.text.trim();

    if (titulo.isEmpty ||
        descricao.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Preencha o título e a descrição.',
          ),
        ),
      );
      return;
    }

    final ocorrencia =
        Ocorrencia(
      id: DateTime.now()
          .microsecondsSinceEpoch
          .toString(),
      numero: widget.numero,
      titulo: titulo,
      descricao: descricao,
      loja: loja,
      setor: setor,
      status: 'Aberta',
      dataAbertura:
          DateTime.now(),
    );

    Navigator.pop(
      context,
      ocorrencia,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nova Ocorrência',
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(20),
        children: [
          Text(
            'Ocorrência #${widget.numero}',
            style:
                const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          TextField(
            controller:
                tituloController,
            decoration:
                const InputDecoration(
              labelText: 'Título',
              hintText:
                  'Ex.: Balcão refrigerado com problema',
              border:
                  OutlineInputBorder(),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          if (widget.permitirTrocarLoja)
            DropdownButtonFormField<String>(
              initialValue: loja,
              decoration:
                  const InputDecoration(
                labelText: 'Loja',
                border:
                    OutlineInputBorder(),
              ),
              items: lojas.map(
                (item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                },
              ).toList(),
              onChanged: (valor) {
                if (valor != null) {
                  setState(() {
                    loja = valor;
                  });
                }
              },
            )
          else
            InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Loja',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.store),
              ),
              child: Text(loja),
            ),

          const SizedBox(
            height: 20,
          ),

          DropdownButtonFormField<String>(
            initialValue: setor,
            decoration:
                const InputDecoration(
              labelText: 'Setor / Local',
              border:
                  OutlineInputBorder(),
            ),
            items: setores.map(
              (item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              },
            ).toList(),
            onChanged: (valor) {
              if (valor != null) {
                setState(() {
                  setor = valor;
                });
              }
            },
          ),

          const SizedBox(
            height: 20,
          ),

          TextField(
            controller:
                descricaoController,
            maxLines: 6,
            decoration:
                const InputDecoration(
              labelText:
                  'Descrição do problema',
              hintText:
                  'Descreva detalhadamente o que aconteceu...',
              border:
                  OutlineInputBorder(),
              alignLabelWithHint:
                  true,
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          SizedBox(
            height: 52,
            child: FilledButton.icon(
              onPressed: salvar,
              icon:
                  const Icon(
                Icons.save,
              ),
              label:
                  const Text(
                'Registrar ocorrência',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

