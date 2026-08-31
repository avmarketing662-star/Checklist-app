import 'package:flutter/material.dart';

import '../models/models.dart';
import '../auth/usuario_app.dart';
import '../auth/login_page.dart';
import '../auth/store_selection_page.dart';
import '../ocorrencias/nova_ocorrencia_page.dart';
import '../ocorrencias/detalhes_ocorrencia_page.dart';
import '../prevencoes/gerenciar_prevencoes_page.dart';
import '../checklists/gerenciar_checklists_page.dart';
import '../fluxograma/gerenciar_fluxograma_page.dart';
import '../dashboard/dashboard_page.dart';

// HOME PAGE
// ============================================================

class HomePage extends StatefulWidget {
  final UsuarioApp usuario;
  final String lojaSelecionada;

  const HomePage({
    super.key,
    required this.usuario,
    required this.lojaSelecionada,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int abaSelecionada = 0;

  DateTime dataSelecionada = DateTime.now();

  // ==========================================================
  // CATEGORIAS
  // ==========================================================

  final List<String> categorias = [
    'Abertura de loja',
    'Fechamento de loja',
    'Açougue',
    'Padaria',
    'Hortifruti',
    'Reposição',
    'Caixa',
    'Depósito',
    'Limpeza',
    'Administrativo',
    'Prevenção',
    'Outros',
  ];

  // ==========================================================
  // CHECKLISTS
  // ==========================================================

  final List<Checklist> checklists = [
    Checklist(
      id: 'check_001',
      nome: 'Abertura de loja',
      categoria: 'Abertura de loja',
      usaHorario: true,
      horarioInicio: const TimeOfDay(
        hour: 6,
        minute: 30,
      ),
      horarioFim: const TimeOfDay(
        hour: 7,
        minute: 30,
      ),
      tarefas: [
        Tarefa(
          id: 'tar_001',
          descricao: 'Extintores vistos',
        ),
        Tarefa(
          id: 'tar_002',
          descricao: 'Alarmes desligados',
        ),
        Tarefa(
          id: 'tar_003',
          descricao: 'Abrir caixas',
        ),
        Tarefa(
          id: 'tar_004',
          descricao: 'Limpeza geral',
        ),
      ],
    ),
    Checklist(
      id: 'check_002',
      nome: 'Padaria',
      categoria: 'Padaria',
      usaHorario: false,
      tarefas: [
        Tarefa(
          id: 'tar_005',
          descricao: 'Levar pão para outra loja',
        ),
        Tarefa(
          id: 'tar_006',
          descricao: 'Conferir materiais de insumo',
        ),
      ],
    ),
    Checklist(
      id: 'check_003',
      nome: 'Reposição',
      categoria: 'Reposição',
      usaHorario: false,
      tarefas: [
        Tarefa(
          id: 'tar_007',
          descricao: 'Conferir gôndolas',
        ),
        Tarefa(
          id: 'tar_008',
          descricao: 'Fazer ponto extra leite Ninho',
        ),
      ],
    ),
    Checklist(
      id: 'check_004',
      nome: 'Fechamento de loja',
      categoria: 'Fechamento de loja',
      usaHorario: true,
      horarioInicio: const TimeOfDay(
        hour: 21,
        minute: 30,
      ),
      horarioFim: const TimeOfDay(
        hour: 22,
        minute: 30,
      ),
      tarefas: [
        Tarefa(
          id: 'tar_009',
          descricao: 'Extintores vistos',
        ),
        Tarefa(
          id: 'tar_010',
          descricao: 'Alarmes desligados',
        ),
        Tarefa(
          id: 'tar_011',
          descricao: 'Fechar caixas',
        ),
        Tarefa(
          id: 'tar_012',
          descricao: 'Limpeza geral',
        ),
      ],
    ),
  ];

  // ==========================================================
  // TAREFAS CONCLUÍDAS
  // ==========================================================

  final Map<String, bool> tarefasConcluidas = {};

  // ==========================================================
  // OCORRÊNCIAS
  // ==========================================================

  final List<Ocorrencia> ocorrencias = [
    Ocorrencia(
      id: 'oc_001',
      numero: '000001',
      titulo: 'Balcão refrigerado',
      descricao:
          'Balcão refrigerado do açougue não está atingindo a temperatura adequada.',
      loja: 'Camanducaia',
      setor: 'Açougue',
      status: 'Aberta',
      dataAbertura: DateTime(
        2026,
        8,
        26,
        8,
        42,
      ),
    ),
    Ocorrencia(
      id: 'oc_002',
      numero: '000002',
      titulo: 'Lâmpada queimada',
      descricao:
          'Lâmpada do depósito está queimada.',
      loja: 'Extrema',
      setor: 'Depósito',
      status: 'Concluída',
      responsavelManutencao: 'Carlos',
      solucao:
          'Realizada a substituição da lâmpada.',
      dataAbertura: DateTime(
        2026,
        8,
        25,
        14,
        10,
      ),
      dataConclusao: DateTime(
        2026,
        8,
        25,
        15,
        20,
      ),
    ),
  ];

  // ==========================================================
  // PREVENÇÕES
  // ==========================================================

  final List<Prevencao> prevencoes = [
    Prevencao(
      id: 'prev_001',
      titulo: 'Cheiro de gás',
      descricao:
          'Procedimento para situações em que seja identificado cheiro de gás.',
      etapas: [
        EtapaPrevencao(
          id: 'etapa_001',
          ordem: 1,
          descricao:
              'Verificar se existe algum vazamento aparente.',
        ),
        EtapaPrevencao(
          id: 'etapa_002',
          ordem: 2,
          descricao:
              'Não acionar equipamentos elétricos próximos ao local.',
        ),
        EtapaPrevencao(
          id: 'etapa_003',
          ordem: 3,
          descricao:
              'Afastar as pessoas do local de risco.',
        ),
        EtapaPrevencao(
          id: 'etapa_004',
          ordem: 4,
          descricao:
              'Comunicar imediatamente o responsável pela loja.',
        ),
        EtapaPrevencao(
          id: 'etapa_005',
          ordem: 5,
          descricao:
              'Acionar a manutenção ou responsável técnico.',
        ),
      ],
    ),

    Prevencao(
      id: 'prev_002',
      titulo: 'Pessoa usando capacete',
      descricao:
          'Procedimento para situações em que uma pessoa esteja utilizando capacete dentro da loja.',
      etapas: [
        EtapaPrevencao(
          id: 'etapa_006',
          ordem: 1,
          descricao:
              'Abordar a pessoa de maneira cordial.',
        ),
        EtapaPrevencao(
          id: 'etapa_007',
          ordem: 2,
          descricao:
              'Orientar a pessoa sobre a necessidade de retirar o capacete.',
        ),
        EtapaPrevencao(
          id: 'etapa_008',
          ordem: 3,
          descricao:
              'Caso a pessoa não retire o capacete, chamar a segurança.',
        ),
        EtapaPrevencao(
          id: 'etapa_009',
          ordem: 4,
          descricao:
              'Registrar uma ocorrência caso seja necessário.',
        ),
      ],
    ),
  ];

  // ==========================================================
  // DATA
  // ==========================================================

  String nomeDia(DateTime data) {
    const dias = [
      'Segunda-feira',
      'Terça-feira',
      'Quarta-feira',
      'Quinta-feira',
      'Sexta-feira',
      'Sábado',
      'Domingo',
    ];

    return dias[data.weekday - 1];
  }

  String nomeMes(DateTime data) {
    const meses = [
      'janeiro',
      'fevereiro',
      'março',
      'abril',
      'maio',
      'junho',
      'julho',
      'agosto',
      'setembro',
      'outubro',
      'novembro',
      'dezembro',
    ];

    return meses[data.month - 1];
  }

  String dataFormatada() {
    return '${nomeDia(dataSelecionada)}, '
        '${dataSelecionada.day} de '
        '${nomeMes(dataSelecionada)} de '
        '${dataSelecionada.year}';
  }

  void mudarDia(int quantidade) {
    setState(() {
      dataSelecionada =
          dataSelecionada.add(
        Duration(days: quantidade),
      );
    });
  }

  // ==========================================================
  // FORMATAÇÃO DE HORÁRIO
  // ==========================================================

  String formatarHorario(TimeOfDay horario) {
    final hora =
        horario.hour.toString().padLeft(2, '0');

    final minuto =
        horario.minute.toString().padLeft(2, '0');

    return '$hora:$minuto';
  }

  // ==========================================================
  // HOME / CHECKLIST
  // ==========================================================

Widget criarChecklist(Checklist checklist) {
  int concluidas = 0;

  for (final tarefa in checklist.tarefas) {
    if (tarefasConcluidas[tarefa.id] == true) {
      concluidas++;
    }
  }

  final total = checklist.tarefas.length;

  final progresso =
      total == 0 ? 0.0 : concluidas / total;

  final concluido =
      total > 0 && concluidas == total;

  // ============================================================
  // ÍCONE DA CATEGORIA
  // ============================================================

  IconData icone = Icons.checklist_rounded;

  switch (checklist.categoria) {
    case 'Abertura de loja':
      icone = Icons.wb_sunny_rounded;
      break;

    case 'Fechamento de loja':
      icone = Icons.nights_stay_rounded;
      break;

    case 'Açougue':
      icone = Icons.restaurant_rounded;
      break;

    case 'Padaria':
      icone = Icons.bakery_dining_rounded;
      break;

    case 'Hortifruti':
      icone = Icons.eco_rounded;
      break;

    case 'Reposição':
      icone = Icons.inventory_2_rounded;
      break;

    case 'Caixa':
      icone = Icons.point_of_sale_rounded;
      break;

    case 'Depósito':
      icone = Icons.warehouse_rounded;
      break;

    case 'Limpeza':
      icone = Icons.cleaning_services_rounded;
      break;

    case 'Administrativo':
      icone = Icons.business_center_rounded;
      break;

    case 'Prevenção':
      icone = Icons.shield_rounded;
      break;
  }

  return GestureDetector(
    onTap: () {
      abrirChecklist(checklist);
    },

    child: AnimatedContainer(
      duration: const Duration(
        milliseconds: 250,
      ),

      margin: const EdgeInsets.only(
        bottom: 16,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(
          22,
        ),

        border: Border.all(
          color: concluido
              ? const Color(0xFFB7E4C7)
              : const Color(0xFFE5EAF0),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.045),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(
          20,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // =================================================
            // CABEÇALHO
            // =================================================

            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // =================================================
                // ÍCONE
                // =================================================

                Container(
                  width: 52,
                  height: 52,

                  decoration: BoxDecoration(
                    color: concluido
                        ? const Color(0xFFE9F8EF)
                        : const Color(0xFFEAF3FF),

                    borderRadius:
                        BorderRadius.circular(16),
                  ),

                  child: Icon(
                    concluido
                        ? Icons.check_rounded
                        : icone,

                    color: concluido
                        ? const Color(0xFF1B9A55)
                        : const Color(0xFF0757B8),

                    size: 26,
                  ),
                ),

                const SizedBox(
                  width: 14,
                ),

                // =================================================
                // INFORMAÇÕES
                // =================================================

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      // NOME
                      Text(
                        checklist.nome,

                        maxLines: 2,

                        overflow:
                            TextOverflow.ellipsis,

                        style:
                            const TextStyle(
                          fontSize: 17,
                          fontWeight:
                              FontWeight.w800,
                          color:
                              Color(0xFF172033),
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      // =================================================
                      // CATEGORIA + HORÁRIO
                      // =================================================

                      Wrap(
                        spacing: 8,
                        runSpacing: 6,

                        crossAxisAlignment:
                            WrapCrossAlignment.center,

                        children: [

                          // CATEGORIA
                          Container(
                            constraints:
                                const BoxConstraints(
                              maxWidth: 180,
                            ),

                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 9,
                              vertical: 5,
                            ),

                            decoration:
                                BoxDecoration(
                              color:
                                  const Color(
                                0xFFF3F5F8,
                              ),

                              borderRadius:
                                  BorderRadius
                                      .circular(8),
                            ),

                            child: Text(
                              checklist.categoria,

                              maxLines: 1,

                              overflow:
                                  TextOverflow
                                      .ellipsis,

                              style:
                                  const TextStyle(
                                fontSize: 11,
                                fontWeight:
                                    FontWeight.w600,
                                color:
                                    Color(
                                  0xFF667085,
                                ),
                              ),
                            ),
                          ),

                          // HORÁRIO
                          if (checklist.usaHorario &&
                              checklist.horarioInicio !=
                                  null &&
                              checklist.horarioFim !=
                                  null)

                            Row(
                              mainAxisSize:
                                  MainAxisSize.min,

                              children: [

                                const Icon(
                                  Icons
                                      .schedule_rounded,
                                  size: 14,
                                  color:
                                      Color(
                                    0xFF667085,
                                  ),
                                ),

                                const SizedBox(
                                  width: 4,
                                ),

                                Text(
                                  '${formatarHorario(checklist.horarioInicio!)}'
                                  ' - '
                                  '${formatarHorario(checklist.horarioFim!)}',

                                  maxLines: 1,

                                  overflow:
                                      TextOverflow
                                          .ellipsis,

                                  style:
                                      const TextStyle(
                                    fontSize: 11,
                                    color:
                                        Color(
                                      0xFF667085,
                                    ),
                                    fontWeight:
                                        FontWeight
                                            .w600,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  width: 8,
                ),

                // =================================================
                // CONTADOR
                // =================================================

                Container(
                  constraints:
                      const BoxConstraints(
                    minWidth: 42,
                  ),

                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 9,
                    vertical: 7,
                  ),

                  decoration:
                      BoxDecoration(
                    color: concluido
                        ? const Color(
                            0xFFE9F8EF,
                          )
                        : const Color(
                            0xFFEAF3FF,
                          ),

                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
                  ),

                  child: Text(
                    '$concluidas/$total',

                    textAlign:
                        TextAlign.center,

                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          FontWeight.w800,

                      color: concluido
                          ? const Color(
                              0xFF1B9A55,
                            )
                          : const Color(
                              0xFF0757B8,
                            ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 18,
            ),

            // =================================================
            // PROGRESSO
            // =================================================

            Row(
              children: [

                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(
                      10,
                    ),

                    child:
                        LinearProgressIndicator(
                      value: progresso,

                      minHeight: 7,

                      backgroundColor:
                          const Color(
                        0xFFE9EDF2,
                      ),

                      valueColor:
                          AlwaysStoppedAnimation<
                              Color>(
                        concluido
                            ? const Color(
                                0xFF25A765,
                              )
                            : const Color(
                                0xFF0757B8,
                              ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 12,
                ),

                Text(
                  '${(progresso * 100).round()}%',

                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w800,

                    color: concluido
                        ? const Color(
                            0xFF1B9A55,
                          )
                        : const Color(
                            0xFF0757B8,
                          ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 15,
            ),

            // =================================================
            // BOTÃO / INDICAÇÃO
            // =================================================

            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets
                      .symmetric(
                horizontal: 14,
                vertical: 12,
              ),

              decoration:
                  BoxDecoration(
                color:
                    const Color(
                  0xFFF3F7FC,
                ),

                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
              ),

              child: const Row(
                children: [

                  Icon(
                    Icons.touch_app_rounded,
                    size: 18,
                    color:
                        Color(0xFF0757B8),
                  ),

                  SizedBox(
                    width: 8,
                  ),

                  Expanded(
                    child: Text(
                      'Toque para abrir o checklist',

                      maxLines: 1,

                      overflow:
                          TextOverflow.ellipsis,

                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w700,
                        color:
                            Color(0xFF0757B8),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 8,
                  ),

                  Icon(
                    Icons
                        .arrow_forward_ios_rounded,
                    size: 14,
                    color:
                        Color(0xFF0757B8),
                  ),
                ],
              ),
            ),

            // =================================================
            // STATUS CONCLUÍDO
            // =================================================

            if (concluido)

              Container(
                width: double.infinity,

                margin:
                    const EdgeInsets.only(
                  top: 10,
                ),

                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 14,
                  vertical: 11,
                ),

                decoration:
                    BoxDecoration(
                  color:
                      const Color(
                    0xFFE9F8EF,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),

                child: const Row(
                  children: [

                    Icon(
                      Icons.verified_rounded,
                      size: 18,
                      color:
                          Color(0xFF1B9A55),
                    ),

                    SizedBox(
                      width: 8,
                    ),

                    Expanded(
                      child: Text(
                        'Checklist concluído',

                        maxLines: 1,

                        overflow:
                            TextOverflow.ellipsis,

                        style: TextStyle(
                          color:
                              Color(
                            0xFF1B9A55,
                          ),
                          fontSize: 12,
                          fontWeight:
                              FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// ABRIR CHECKLIST EM POP-UP DE TELA INTEIRA
// ============================================================

void abrirChecklist(Checklist checklist) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black54,
    builder: (dialogContext) {
      return Dialog.fullscreen(
        backgroundColor: const Color(0xFFF5F7FB),
        child: StatefulBuilder(
          builder: (context, setDialogState) {
            
            int concluidas = 0;

            for (final tarefa in checklist.tarefas) {
              if (tarefasConcluidas[tarefa.id] == true) {
                concluidas++;
              }
            }

            final total = checklist.tarefas.length;

            final progresso = total == 0
                ? 0.0
                : concluidas / total;

            final concluido =
                total > 0 && concluidas == total;

            return SafeArea(
              child: Column(
                children: [

                  // ==================================================
                  // CABEÇALHO
                  // ==================================================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      16,
                      12,
                      16,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFE5EAF0),
                        ),
                      ),
                    ),

                    child: Row(
                      children: [

                        // ÍCONE
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: concluido
                                ? const Color(0xFFE9F8EF)
                                : const Color(0xFFEAF3FF),
                            borderRadius:
                                BorderRadius.circular(15),
                          ),
                          child: Icon(
                            concluido
                                ? Icons.check_rounded
                                : Icons.checklist_rounded,
                            color: concluido
                                ? const Color(0xFF1B9A55)
                                : const Color(0xFF0757B8),
                            size: 26,
                          ),
                        ),

                        const SizedBox(width: 13),

                        // TÍTULO
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [

                              Text(
                                checklist.nome,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight:
                                      FontWeight.w900,
                                  color:
                                      Color(0xFF172033),
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                checklist.categoria,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color:
                                      Color(0xFF667085),
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // BOTÃO FECHAR
                        Material(
                          color: const Color(0xFFF3F5F8),
                          borderRadius:
                              BorderRadius.circular(13),
                          child: InkWell(
                            borderRadius:
                                BorderRadius.circular(13),
                            onTap: () {
                              Navigator.of(
                                dialogContext,
                              ).pop();
                            },
                            child: const SizedBox(
                              width: 46,
                              height: 46,
                              child: Icon(
                                Icons.close_rounded,
                                size: 26,
                                color:
                                    Color(0xFF172033),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ==================================================
                  // CONTEÚDO
                  // ==================================================

                  Expanded(
                    child: ListView(
                      physics:
                          const BouncingScrollPhysics(),

                      padding:
                          const EdgeInsets.fromLTRB(
                        20,
                        20,
                        20,
                        30,
                      ),

                      children: [

                        // ==================================================
                        // HORÁRIO
                        // ==================================================

                        if (checklist.usaHorario &&
                            checklist.horarioInicio != null &&
                            checklist.horarioFim != null)

                          Container(
                            padding:
                                const EdgeInsets.all(15),

                            decoration:
                                BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(17),
                              border: Border.all(
                                color:
                                    const Color(
                                  0xFFE5EAF0,
                                ),
                              ),
                            ),

                            child: Row(
                              children: [

                                Container(
                                  width: 42,
                                  height: 42,
                                  decoration:
                                      BoxDecoration(
                                    color:
                                        const Color(
                                      0xFFEAF3FF,
                                    ),
                                    borderRadius:
                                        BorderRadius
                                            .circular(12),
                                  ),
                                  child: const Icon(
                                    Icons
                                        .schedule_rounded,
                                    color:
                                        Color(0xFF0757B8),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [

                                      Text(
                                        'Horário do checklist',
                                        style:
                                            TextStyle(
                                          fontSize: 11,
                                          color:
                                              Color(
                                            0xFF667085,
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 3),

                                      Text(
                                        'Período programado',
                                        style:
                                            TextStyle(
                                          fontSize: 13,
                                          fontWeight:
                                              FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Text(
                                  '${formatarHorario(checklist.horarioInicio!)}'
                                  ' - '
                                  '${formatarHorario(checklist.horarioFim!)}',

                                  style:
                                      const TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                        FontWeight.w800,
                                    color:
                                        Color(0xFF0757B8),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 16),

                        // ==================================================
                        // PROGRESSO
                        // ==================================================

                        Container(
                          padding:
                              const EdgeInsets.all(18),

                          decoration:
                              BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(18),
                            border: Border.all(
                              color:
                                  const Color(
                                0xFFE5EAF0,
                              ),
                            ),
                          ),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [

                              Row(
                                children: [

                                  const Expanded(
                                    child: Text(
                                      'Progresso',
                                      style:
                                          TextStyle(
                                        fontSize: 14,
                                        fontWeight:
                                            FontWeight.w800,
                                        color:
                                            Color(
                                          0xFF172033,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Text(
                                    '$concluidas de $total',

                                    style:
                                        const TextStyle(
                                      fontSize: 12,
                                      fontWeight:
                                          FontWeight.w700,
                                      color:
                                          Color(
                                        0xFF0757B8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(
                                  10,
                                ),
                                child:
                                    LinearProgressIndicator(
                                  value: progresso,
                                  minHeight: 9,
                                  backgroundColor:
                                      const Color(
                                    0xFFE9EDF2,
                                  ),
                                  valueColor:
                                      AlwaysStoppedAnimation<
                                          Color>(
                                    concluido
                                        ? const Color(
                                            0xFF25A765,
                                          )
                                        : const Color(
                                            0xFF0757B8,
                                          ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                '${(progresso * 100).round()}% concluído',

                                style:
                                    const TextStyle(
                                  fontSize: 11,
                                  color:
                                      Color(0xFF667085),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 22),

                        // ==================================================
                        // TÍTULO TAREFAS
                        // ==================================================

                        const Text(
                          'Tarefas',

                          style: TextStyle(
                            fontSize: 19,
                            fontWeight:
                                FontWeight.w900,
                            color:
                                Color(0xFF172033),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // ==================================================
                        // LISTA DE TAREFAS
                        // ==================================================

                        ...List.generate(
                          checklist.tarefas.length,
                          (index) {

                            final tarefa =
                                checklist.tarefas[index];

                            final feita =
                                tarefasConcluidas[
                                        tarefa.id] ??
                                    false;

                            return Container(
                              margin:
                                  const EdgeInsets.only(
                                bottom: 10,
                              ),

                              decoration:
                                  BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(
                                  16,
                                ),
                                border: Border.all(
                                  color: feita
                                      ? const Color(
                                          0xFFB7E4C7,
                                        )
                                      : const Color(
                                          0xFFE5EAF0,
                                        ),
                                ),
                              ),

                              child:
                                  CheckboxListTile(
                                value: feita,

                                onChanged: (valor) {

                                  this.setState(() {

                                    tarefasConcluidas[
                                            tarefa.id] =
                                        valor ?? false;
                                  });

                                  setDialogState(() {});
                                },

                                controlAffinity:
                                    ListTileControlAffinity
                                        .leading,

                                contentPadding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal: 12,
                                  vertical: 5,
                                ),

                                title: Text(
                                  tarefa.descricao,

                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                        FontWeight.w600,

                                    decoration: feita
                                        ? TextDecoration
                                            .lineThrough
                                        : TextDecoration
                                            .none,

                                    color: feita
                                        ? const Color(
                                            0xFF8A95A3,
                                          )
                                        : const Color(
                                            0xFF293241,
                                          ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        // ==================================================
                        // CHECKLIST CONCLUÍDO
                        // ==================================================

                        if (concluido)

                          Container(
                            margin:
                                const EdgeInsets.only(
                              top: 5,
                            ),

                            padding:
                                const EdgeInsets.all(16),

                            decoration:
                                BoxDecoration(
                              color:
                                  const Color(
                                0xFFE9F8EF,
                              ),
                              borderRadius:
                                  BorderRadius.circular(
                                16,
                              ),
                            ),

                            child: const Row(
                              children: [

                                Icon(
                                  Icons.verified_rounded,
                                  color:
                                      Color(0xFF1B9A55),
                                  size: 24,
                                ),

                                SizedBox(width: 10),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [

                                      Text(
                                        'Checklist concluído!',
                                        style:
                                            TextStyle(
                                          color:
                                              Color(
                                            0xFF1B9A55,
                                          ),
                                          fontSize: 14,
                                          fontWeight:
                                              FontWeight.w900,
                                        ),
                                      ),

                                      SizedBox(height: 2),

                                      Text(
                                        'Todas as tarefas foram realizadas.',
                                        style:
                                            TextStyle(
                                          color:
                                              Color(
                                            0xFF43845F,
                                          ),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

Widget telaHome() {
  int totalTarefas = 0;
  int tarefasFeitas = 0;

  for (final checklist in checklists) {
    totalTarefas += checklist.tarefas.length;

    for (final tarefa in checklist.tarefas) {
      if (tarefasConcluidas[tarefa.id] == true) {
        tarefasFeitas++;
      }
    }
  }

  final progressoGeral = totalTarefas == 0
      ? 0.0
      : tarefasFeitas / totalTarefas;

  final checklistsConcluidos = checklists.where((checklist) {
    if (checklist.tarefas.isEmpty) {
      return false;
    }

    return checklist.tarefas.every(
      (tarefa) =>
          tarefasConcluidas[tarefa.id] == true,
    );
  }).length;

  return SafeArea(
    child: Column(
      children: [

        // ========================================================
        // HEADER COMPACTO — FIXO
        // ========================================================

        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(
            10,
            10,
            10,
            10,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF063B7A),
                Color(0xFF0757B8),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(22),
              bottomRight: Radius.circular(22),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ==================================================
              // USUÁRIO
              // ==================================================

              Row(
                children: [

                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.14),
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 21,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          'Olá, ${widget.usuario.usuario}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Row(
                          children: [

                            const Icon(
                              Icons.storefront_rounded,
                              size: 12,
                              color: Colors.white70,
                            ),

                            const SizedBox(width: 4),

                            Expanded(
                              child: Text(
                                widget.lojaSelecionada,
                                overflow:
                                    TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ADMIN
                  if (widget.usuario.administrador)
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color:
                            Colors.white.withOpacity(.13),
                        borderRadius:
                            BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [

                          Icon(
                            Icons.admin_panel_settings_rounded,
                            color: Colors.white,
                            size: 13,
                          ),

                          SizedBox(width: 4),

                          Text(
                            'ADMIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight:
                                  FontWeight.w800,
                              letterSpacing: .4,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // ==================================================
              // DATA
              // ==================================================

              Row(
                children: [

                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color:
                          Colors.white.withOpacity(.12),
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),

                  const SizedBox(width: 9),

                  Expanded(
                    child: Text(
                      dataFormatada(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  // DIA ANTERIOR
                  Material(
                    color:
                        Colors.white.withOpacity(.10),
                    borderRadius:
                        BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(10),
                      onTap: () {
                        mudarDia(-1);
                      },
                      child: const SizedBox(
                        width: 34,
                        height: 34,
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 6),

                  // PRÓXIMO DIA
                  Material(
                    color:
                        Colors.white.withOpacity(.10),
                    borderRadius:
                        BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(10),
                      onTap: () {
                        mudarDia(1);
                      },
                      child: const SizedBox(
                        width: 34,
                        height: 34,
                        child: Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ========================================================
        // TÍTULO CHECKLISTS — FIXO
        // ========================================================

        Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            14,
            20,
            10,
          ),
          child: Row(
            children: [

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      'Checklists',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight:
                            FontWeight.w900,
                        color:
                            Color(0xFF172033),
                      ),
                    ),

                    SizedBox(height: 3),

                    Text(
                      'Atividades da operação',
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            Color(0xFF667085),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 7,
                ),
                decoration:
                    BoxDecoration(
                  color:
                      const Color(0xFFEAF3FF),
                  borderRadius:
                      BorderRadius.circular(10),
                ),
                child: Text(
                  '${checklists.length} listas',
                  style:
                      const TextStyle(
                    color:
                        Color(0xFF0757B8),
                    fontSize: 11,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),

        // ========================================================
        // ÁREA MÓVEL
        // ========================================================

        Expanded(
          child: ListView(
            physics:
                const BouncingScrollPhysics(),
            padding:
                const EdgeInsets.only(
              bottom: 30,
            ),
            children: [

              // ==================================================
              // RESUMO DO DIA — MÓVEL
              // ==================================================

              Padding(
                padding:
                    const EdgeInsets.fromLTRB(
                  20,
                  5,
                  20,
                  15,
                ),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.all(18),
                  decoration:
                      BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          const Color(0xFFE5EAF0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(.035),
                        blurRadius: 15,
                        offset:
                            const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      Row(
                        children: [

                          Container(
                            width: 44,
                            height: 44,
                            decoration:
                                BoxDecoration(
                              color:
                                  const Color(
                                0xFFEAF3FF,
                              ),
                              borderRadius:
                                  BorderRadius
                                      .circular(13),
                            ),
                            child:
                                const Icon(
                              Icons
                                  .task_alt_rounded,
                              color:
                                  Color(0xFF0757B8),
                            ),
                          ),

                          const SizedBox(
                            width: 12,
                          ),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [

                                Text(
                                  'Resumo do dia',
                                  style:
                                      TextStyle(
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight
                                            .w800,
                                    color:
                                        Color(
                                      0xFF172033,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 3,
                                ),

                                Text(
                                  'Acompanhe o andamento dos checklists',
                                  style:
                                      TextStyle(
                                    fontSize: 11,
                                    color:
                                        Color(
                                      0xFF667085,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            '${(progressoGeral * 100).round()}%',
                            style:
                                const TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight
                                      .w900,
                              color:
                                  Color(0xFF0757B8),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(
                          10,
                        ),
                        child:
                            LinearProgressIndicator(
                          value:
                              progressoGeral,
                          minHeight: 8,
                          backgroundColor:
                              const Color(
                            0xFFE9EDF2,
                          ),
                          valueColor:
                              const AlwaysStoppedAnimation(
                            Color(0xFF0757B8),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 13,
                      ),

                      Row(
                        children: [

                          Expanded(
                            child: Text(
                              '$tarefasFeitas de $totalTarefas tarefas concluídas',
                              style:
                                  const TextStyle(
                                fontSize: 11,
                                fontWeight:
                                    FontWeight.w600,
                                color:
                                    Color(
                                  0xFF667085,
                                ),
                              ),
                            ),
                          ),

                          Text(
                            '$checklistsConcluidos/${checklists.length} checklists',
                            style:
                                const TextStyle(
                              fontSize: 11,
                              fontWeight:
                                  FontWeight.w700,
                              color:
                                  Color(
                                0xFF0757B8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // ==================================================
              // LISTA DE CHECKLISTS — MÓVEL
              // ==================================================

              ...checklists.map(
                (checklist) => Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child:
                      criarChecklist(checklist),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


 Widget _cardResumoOcorrencia(
    String titulo,
    String valor,
    IconData icone,
  ) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(
              icone,
              size: 25,
            ),
            const SizedBox(height: 5),
            Text(
              valor,
              style:
                  const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            Text(
              titulo,
              textAlign:
                  TextAlign.center,
              style:
                  const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardOcorrencia(
    Ocorrencia ocorrencia,
  ) {
    final concluida =
        ocorrencia.status ==
            'Concluída';

    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(12),
        onTap: () {
          abrirOcorrencia(
            ocorrencia,
          );
        },
        child: Padding(
          padding:
              const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets
                            .all(10),
                    decoration:
                        BoxDecoration(
                      color: concluida
                          ? Colors.green
                              .withOpacity(
                              0.1,
                            )
                          : Colors.orange
                              .withOpacity(
                              0.1,
                            ),
                      shape:
                          BoxShape.circle,
                    ),
                    child: Icon(
                      concluida
                          ? Icons
                              .check_circle
                          : Icons
                              .build,
                      color: concluida
                          ? Colors.green
                          : Colors.orange,
                    ),
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
                          ocorrencia.titulo,
                          style:
                              const TextStyle(
                            fontSize: 17,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                        Text(
                          'Ocorrência #${ocorrencia.numero}',
                          style:
                              const TextStyle(
                            color:
                                Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  _statusOcorrencia(
                    ocorrencia.status,
                  ),
                ],
              ),

              const SizedBox(
                height: 12,
              ),

              Text(
                ocorrencia.descricao,
                maxLines: 2,
                overflow:
                    TextOverflow.ellipsis,
              ),

              const SizedBox(
                height: 12,
              ),

              Wrap(
                spacing: 12,
                runSpacing: 6,
                children: [
                  _informacaoOcorrencia(
                    Icons.store,
                    ocorrencia.loja,
                  ),
                  _informacaoOcorrencia(
                    Icons.location_on,
                    ocorrencia.setor,
                  ),
                  _informacaoOcorrencia(
                    Icons.calendar_today,
                    _formatarDataHora(
                      ocorrencia
                          .dataAbertura,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusOcorrencia(
    String status,
  ) {
    final concluida =
        status == 'Concluída';

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
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
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _informacaoOcorrencia(
    IconData icone,
    String texto,
  ) {
    return Row(
      mainAxisSize:
          MainAxisSize.min,
      children: [
        Icon(
          icone,
          size: 15,
          color: Colors.grey,
        ),
        const SizedBox(width: 4),
        Text(
          texto,
          style:
              const TextStyle(
            fontSize: 12,
            color: Colors.grey,
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

    return '$dia/$mes/${data.year} $hora:$minuto';
  }

  void novaOcorrencia() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            NovaOcorrenciaPage(
          numero:
              _proximoNumeroOcorrencia(),
          lojaInicial:
              widget.lojaSelecionada,
          permitirTrocarLoja:
              widget.usuario.administrador,
        ),
      ),
    ).then((resultado) {
      if (resultado is Ocorrencia) {
        setState(() {
          ocorrencias.insert(
            0,
            resultado,
          );
        });
      }
    });
  }

  String _proximoNumeroOcorrencia() {
    return (ocorrencias.length + 1)
        .toString()
        .padLeft(6, '0');
  }

  void abrirOcorrencia(
    Ocorrencia ocorrencia,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetalhesOcorrenciaPage(
          ocorrencia: ocorrencia,
        ),
      ),
    ).then((resultado) {
      if (resultado == true) {
        setState(() {});
      }
    });
  }
// ============================================================
// TELA DE OCORRÊNCIAS
// ============================================================

Widget telaOcorrencias() {
  final abertas = ocorrencias
      .where((o) => o.status == 'Aberta')
      .length;

  final concluidas = ocorrencias
      .where((o) => o.status == 'Concluída')
      .length;

  final total = ocorrencias.length;

  return SafeArea(
    child: Column(
      children: [
        // ======================================================
        // CABEÇALHO
        // ======================================================

        Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            12,
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3FF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.report_problem_rounded,
                  color: Color(0xFF0757B8),
                  size: 27,
                ),
              ),

              const SizedBox(width: 14),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ocorrências',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF172033),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Registre e acompanhe problemas da operação.',
                      style: TextStyle(
                        color: Color(0xFF667085),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // BOTÃO NOVA OCORRÊNCIA
              Material(
                color: const Color(0xFF0757B8),
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: novaOcorrencia,
                  child: const SizedBox(
                    width: 48,
                    height: 48,
                    child: Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // ======================================================
        // RESUMO
        // ======================================================

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Row(
            children: [
              Expanded(
                child: _cardResumoOcorrencia(
                  'Total',
                  '$total',
                  Icons.assignment_rounded,
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: _cardResumoOcorrencia(
                  'Abertas',
                  '$abertas',
                  Icons.warning_amber_rounded,
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: _cardResumoOcorrencia(
                  'Concluídas',
                  '$concluidas',
                  Icons.check_circle_rounded,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // ======================================================
        // TÍTULO DA LISTA
        // ======================================================

        Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            8,
            20,
            10,
          ),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Registros',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF172033),
                  ),
                ),
              ),

              if (ocorrencias.isNotEmpty)
                Text(
                  '$total ocorrência${total == 1 ? '' : 's'}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF667085),
                  ),
                ),
            ],
          ),
        ),

        // ======================================================
        // LISTA
        // ======================================================

        Expanded(
          child: ocorrencias.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF3FF),
                            borderRadius:
                                BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.assignment_rounded,
                            size: 40,
                            color: Color(0xFF0757B8),
                          ),
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          'Nenhuma ocorrência',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF172033),
                          ),
                        ),

                        const SizedBox(height: 6),

                        const Text(
                          'As ocorrências registradas aparecerão aqui.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF667085),
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 20),

                        ElevatedButton.icon(
                          onPressed: novaOcorrencia,
                          icon: const Icon(
                            Icons.add_rounded,
                          ),
                          label: const Text(
                            'Nova ocorrência',
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  physics:
                      const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    0,
                    16,
                    30,
                  ),
                  itemCount: ocorrencias.length,
                  itemBuilder: (context, index) {
                    return _cardOcorrencia(
                      ocorrencias[index],
                    );
                  },
                ),
        ),
      ],
    ),
  );
}
  // ==========================================================
  // PREVENÇÃO
  // ==========================================================

  Widget telaPrevencao() {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              10,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.shield_outlined,
                  size: 32,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Prevenção',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const Padding(
            padding:
                EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Align(
              alignment:
                  Alignment.centerLeft,
              child: Text(
                'Procedimentos para situações de risco.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          Expanded(
            child:
                prevencoes.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhuma prevenção cadastrada.',
                        ),
                      )
                    : ListView.builder(
                        padding:
                            const EdgeInsets
                                .fromLTRB(
                          16,
                          0,
                          16,
                          20,
                        ),
                        itemCount:
                            prevencoes.length,
                        itemBuilder:
                            (context, index) {
                          return _cardPrevencao(
                            prevencoes[index],
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _cardPrevencao(
    Prevencao prevencao,
  ) {
    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),
      clipBehavior:
          Clip.antiAlias,
      child: ExpansionTile(
        leading:
            const CircleAvatar(
          child: Icon(
            Icons.shield,
          ),
        ),
        title: Text(
          prevencao.titulo,
          style:
              const TextStyle(
            fontWeight:
                FontWeight.bold,
            fontSize: 17,
          ),
        ),
        subtitle: Text(
          '${prevencao.etapas.length} etapa(s)',
        ),
        childrenPadding:
            const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          18,
        ),
        children: [
          if (prevencao.descricao
              .trim()
              .isNotEmpty)
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(
                12,
              ),
              margin:
                  const EdgeInsets.only(
                bottom: 16,
              ),
              decoration:
                  BoxDecoration(
                color: Colors.grey
                    .withOpacity(
                  0.08,
                ),
                borderRadius:
                    BorderRadius.circular(
                  10,
                ),
              ),
              child: Text(
                prevencao.descricao,
              ),
            ),

          ...List.generate(
            prevencao.etapas.length,
            (index) {
              final etapa =
                  prevencao.etapas[index];

              final ultima =
                  index ==
                      prevencao.etapas
                              .length -
                          1;

              return Row(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration:
                            BoxDecoration(
                          color: Colors.blue
                              .withOpacity(
                            0.1,
                          ),
                          shape:
                              BoxShape.circle,
                        ),
                        alignment:
                            Alignment.center,
                        child: Text(
                          '${etapa.ordem}',
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ),

                      if (!ultima)
                        Container(
                          width: 2,
                          height: 35,
                          color: Colors
                              .grey
                              .withOpacity(
                            0.3,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets
                              .only(
                        top: 8,
                        bottom: 15,
                      ),
                      child: Text(
                        etapa.descricao,
                        style:
                            const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
// ============================================================
// MONITORAMENTO
// ============================================================

Widget telaMonitoramento() {
  return SafeArea(
    child: Column(
      children: [
        // ======================================================
        // CABEÇALHO
        // ======================================================

Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 16,
  ),
  child: Row(
    children: [
      Expanded(
        child: _statusMonitoramento(
          'NORMAL',
          '4',
          Colors.green,
          Icons.check_circle,
        ),
      ),

      const SizedBox(width: 8),

      Expanded(
        child: _statusMonitoramento(
          'ALERTA',
          '1',
          Colors.orange,
          Icons.warning_amber,
        ),
      ),

      const SizedBox(width: 8),

      Expanded(
        child: _statusMonitoramento(
          'CRÍTICO',
          '1',
          Colors.red,
          Icons.error,
        ),
      ),
    ],
  ),
),

        // ======================================================
        // RESUMO
        // ======================================================

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Row(
            children: [
              _statusMonitoramento(
                'NORMAL',
                '4',
                Colors.green,
                Icons.check_circle,
              ),

              _statusMonitoramento(
                'ALERTA',
                '1',
                Colors.orange,
                Icons.warning_amber,
              ),

              _statusMonitoramento(
                'CRÍTICO',
                '1',
                Colors.red,
                Icons.error,
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // ======================================================
        // EQUIPAMENTOS
        // ======================================================

        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              20,
            ),
            children: [
              _equipamento(
                titulo: 'Câmara de Resfriados',
                sensor: 'ESP32-001',
                temperatura: 3.8,
                minimo: 0,
                maximo: 5,
                status: 'NORMAL',
                icone: Icons.ac_unit,
                ultimaLeitura: '07:42',
              ),

              _equipamento(
                titulo: 'Câmara de Congelados',
                sensor: 'ESP32-002',
                temperatura: -18.4,
                minimo: -25,
                maximo: -15,
                status: 'NORMAL',
                icone: Icons.severe_cold,
                ultimaLeitura: '07:42',
              ),

              _equipamento(
                titulo: 'Câmara do Açougue',
                sensor: 'ESP32-003',
                temperatura: 8.2,
                minimo: 0,
                maximo: 5,
                status: 'CRÍTICO',
                icone: Icons.restaurant,
                ultimaLeitura: '07:42',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ==========================================================
// TELA FLUXOGRAMA
// ==========================================================

Widget telaFluxograma() {
  return SafeArea(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            10,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.account_tree_outlined,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Fluxograma',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              const Text(
                'Manual de procedimentos por setor.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        Expanded(
          child: ListView(
            padding:
                const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              20,
            ),
            children: [
              _sumarioFluxograma(),

              const SizedBox(height: 20),

              ...List.generate(
                fluxograma.length,
                (index) {
                  return _documentoSetor(
                    fluxograma[index],
                    index + 1,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _sumarioFluxograma() {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.list_alt),
              SizedBox(width: 10),
              Text(
                'Sumário',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ...List.generate(
            fluxograma.length,
            (index) {
              final setor =
                  fluxograma[index];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Text(
                  '${(index + 1).toString().padLeft(2, '0')}. '
                  '${setor.nome}',
                  style:
                      const TextStyle(
                    fontSize: 15,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
Widget _documentoSetor(
  SetorFluxograma setor,
  int numero,
) {
  return Card(
    margin: const EdgeInsets.only(
      bottom: 18,
    ),
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            '${numero.toString().padLeft(2, '0')} — '
            '${setor.nome.toUpperCase()}',
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          if (setor.descricao
              .trim()
              .isNotEmpty)
            Text(
              setor.descricao,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

          const SizedBox(height: 18),

          const Divider(),

          const SizedBox(height: 10),

          const Text(
            'PROCEDIMENTOS',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 10),

          ...List.generate(
            setor.procedimentos.length,
            (index) {
              final procedimento =
                  setor.procedimentos[index];

              return Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 12,
                ),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      alignment:
                          Alignment.center,
                      decoration:
                          BoxDecoration(
                        color: Colors.blue
                            .withOpacity(
                          0.1,
                        ),
                        shape:
                            BoxShape.circle,
                      ),
                      child: Text(
                        '${index + 1}',
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
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
                            procedimento
                                .descricao,
                            style:
                                const TextStyle(
                              fontSize: 15,
                            ),
                          ),

                          if (procedimento
                                  .horario !=
                              null)
                            Padding(
                              padding:
                                  const EdgeInsets
                                      .only(
                                top: 4,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons
                                        .access_time,
                                    size: 15,
                                    color:
                                        Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    procedimento
                                        .horario!,
                                    style:
                                        const TextStyle(
                                      color:
                                          Colors.grey,
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

// ============================================================
// STATUS
// ============================================================
Widget _statusMonitoramento(
  String titulo,
  String quantidade,
  Color cor,
  IconData icone,
) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icone,
            color: cor,
            size: 24,
          ),

          const SizedBox(height: 4),

          Text(
            quantidade,
            style: TextStyle(
              color: cor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            titulo,
            style: TextStyle(
              color: cor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
// ============================================================
// EQUIPAMENTO
// ============================================================

Widget _equipamento({
  required String titulo,
  required String sensor,
  required double temperatura,
  required double minimo,
  required double maximo,
  required String status,
  required IconData icone,
  required String ultimaLeitura,
}) {
  final bool normal = status == 'NORMAL';

  final Color cor = normal
      ? Colors.green
      : status == 'ALERTA'
          ? Colors.orange
          : Colors.red;

  return Card(
    margin: const EdgeInsets.only(
      bottom: 14,
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // ==================================================
          // CABEÇALHO DO EQUIPAMENTO
          // ==================================================

          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: cor.withOpacity(0.10),
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: Icon(
                  icone,
                  color: cor,
                  size: 24,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      'Sensor: $sensor',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // STATUS
              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: cor.withOpacity(0.10),
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: cor,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 5),

                    Text(
                      status,
                      style: TextStyle(
                        color: cor,
                        fontSize: 10,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ==================================================
          // TEMPERATURA
          // ==================================================

          Center(
            child: Column(
              children: [
                Text(
                  '${temperatura.toStringAsFixed(1).replaceAll('.', ',')} °C',
                  style: TextStyle(
                    color: cor,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 3),

                const Text(
                  'TEMPERATURA ATUAL',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // ==================================================
          // LIMITES
          // ==================================================

          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'Mínimo',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${minimo.toStringAsFixed(0)}°C',
                      style: const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 1,
                height: 30,
                color: Colors.grey.shade300,
              ),

              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'Máximo',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${maximo.toStringAsFixed(0)}°C',
                      style: const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ==================================================
          // INDICADOR 1 A 10
          // ==================================================

          _indicadorTemperatura(
            temperatura,
            minimo,
            maximo,
            cor,
          ),

          // ==================================================
          // ALERTA
          // ==================================================

          if (!normal) ...[
            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: cor.withOpacity(0.08),
                borderRadius:
                    BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: cor,
                    size: 20,
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      temperatura > maximo
                          ? 'Temperatura acima do limite'
                          : 'Temperatura abaixo do limite',
                      style: TextStyle(
                        color: cor,
                        fontWeight:
                            FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 12),

          // ==================================================
          // RODAPÉ
          // ==================================================

          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 16,
                color: Colors.grey,
              ),

              const SizedBox(width: 5),

              Text(
                'Última leitura: $ultimaLeitura',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),

              const Spacer(),

              TextButton(
                onPressed: () {},
                child: const Text(
                  'Ver histórico →',
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// ============================================================
// INDICADOR DE TEMPERATURA
// ============================================================

Widget _indicadorTemperatura(
  double temperatura,
  double minimo,
  double maximo,
  Color cor,
) {
  double porcentagem;

  if (temperatura <= minimo) {
    porcentagem = 0;
  } else if (temperatura >= maximo) {
    porcentagem = 1;
  } else {
    porcentagem =
        (temperatura - minimo) /
        (maximo - minimo);
  }

  return Column(
    crossAxisAlignment:
        CrossAxisAlignment.start,

    children: [
      const Text(
        'TEMPERATURA',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
     
      const SizedBox(height: 8),

      LayoutBuilder(
        builder: (
          context,
          constraints,
        ) {
          final largura =
              constraints.maxWidth;

          final posicao =
              (largura - 20) *
                  porcentagem;

          return SizedBox(
            height: 70,
            child: Stack(
              clipBehavior:
                  Clip.none,
              children: [
                // LINHA
                Positioned(
                  left: 0,
                  right: 0,
                  top: 28,
                  child: Container(
                    height: 8,
                    decoration:
                        BoxDecoration(
                      color:
                          Colors.grey.shade200,
                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                ),

                // PARTE PREENCHIDA
                Positioned(
                  left: 0,
                  width: posicao + 10,
                  top: 28,
                  child: Container(
                    height: 8,
                    decoration:
                        BoxDecoration(
                      color: cor,
                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                ),

                // PONTEIRO
                Positioned(
                  left: posicao,
                  top: 8,
                  child: Column(
                    children: [
                      Icon(
                        Icons.arrow_drop_down,
                        color: cor,
                        size: 26,
                      ),

                      Container(
                        width: 3,
                        height: 18,
                        decoration:
                            BoxDecoration(
                          color: cor,
                          borderRadius:
                              BorderRadius.circular(
                            5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // NÚMEROS
                Positioned(
                  left: 0,
                  right: 0,
                  top: 45,
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: List.generate(
                      10,
                      (index) {
                        return Text(
                          '${index + 1}',
                          style:
                              const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}

// ==========================================================
// FLUXOGRAMA
// ==========================================================

final List<SetorFluxograma> fluxograma = [
  SetorFluxograma(
    id: 'setor_001',
    nome: 'Açougue',
    descricao:
        'Rotinas e procedimentos diários do setor de açougue.',
    procedimentos: [
      ProcedimentoFluxograma(
        id: 'proc_001',
        descricao: 'Fazer limpeza do setor.',
      ),
      ProcedimentoFluxograma(
        id: 'proc_002',
        descricao: 'Lavar os equipamentos.',
        horario: '17:00',
      ),
      ProcedimentoFluxograma(
        id: 'proc_003',
        descricao: 'Conferir carnes armazenadas.',
      ),
      ProcedimentoFluxograma(
        id: 'proc_004',
        descricao: 'Conferir validade dos produtos.',
      ),
      ProcedimentoFluxograma(
        id: 'proc_005',
        descricao:
            'Verificar temperatura dos balcões.',
      ),
    ],
  ),

  SetorFluxograma(
    id: 'setor_002',
    nome: 'Padaria',
    descricao:
        'Rotinas e procedimentos da padaria.',
    procedimentos: [
      ProcedimentoFluxograma(
        id: 'proc_006',
        descricao: 'Conferir materiais de produção.',
      ),
      ProcedimentoFluxograma(
        id: 'proc_007',
        descricao: 'Verificar validade dos produtos.',
      ),
      ProcedimentoFluxograma(
        id: 'proc_008',
        descricao: 'Realizar limpeza dos equipamentos.',
      ),
    ],
  ),

  SetorFluxograma(
    id: 'setor_003',
    nome: 'Hortifruti',
    descricao:
        'Rotinas de organização e qualidade.',
    procedimentos: [
      ProcedimentoFluxograma(
        id: 'proc_009',
        descricao: 'Conferir qualidade dos produtos.',
      ),
      ProcedimentoFluxograma(
        id: 'proc_010',
        descricao: 'Retirar produtos impróprios.',
      ),
      ProcedimentoFluxograma(
        id: 'proc_011',
        descricao: 'Organizar as bancas.',
      ),
    ],
  ),
];

  // ==========================================================
  // CONFIGURAÇÕES
  // ==========================================================

  Widget telaConfiguracoes() {
    return SafeArea(
      child: ListView(
        padding:
            const EdgeInsets.all(20),
        children: [
          const Text(
            'Configurações',
            style: TextStyle(
              fontSize: 28,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          Card(
            child: ListTile(
              leading:
                  const CircleAvatar(
                child: Icon(
                  Icons.checklist,
                ),
              ),
              title:
                  const Text(
                'Gerenciar checklists',
                style:
                    TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              subtitle:
                  const Text(
                'Criar, editar e excluir checklists',
              ),
              trailing:
                  const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                abrirGerenciamentoChecklists();
              },
            ),
          ),
            const SizedBox(
            height: 12,
          ),

          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(
                  Icons.account_tree,
                ),
              ),
              title: const Text(
                'Editar fluxograma',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Gerenciar setores e procedimentos',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                abrirGerenciamentoFluxograma();
              },
            ),
          ),
          const SizedBox(
            height: 12,
          ),

          // --------------------------------------------------
          // GERENCIAR PREVENÇÕES
          // --------------------------------------------------

          Card(
            child: ListTile(
              leading:
                  const CircleAvatar(
                child: Icon(
                  Icons.shield,
                ),
              ),
              title:
                  const Text(
                'Gerenciar prevenções',
                style:
                    TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              subtitle:
                  const Text(
                'Criar, editar e excluir procedimentos',
              ),
              trailing:
                  const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                abrirGerenciamentoPrevencoes();
              },
            ),
          ),
        ],
      ),
    );
  }

  void abrirGerenciamentoChecklists() {
    print('CLICOU EM GERENCIAR CHECKLISTS');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          print('ABRINDO PAGINA DE CHECKLISTS');

          return GerenciarChecklistsPage(
            checklists: checklists,
            categorias: categorias,
            onAtualizar: () {
              setState(() {});
            },
          );
        },
      ),
    );
  }

  void abrirGerenciamentoPrevencoes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            GerenciarPrevencoesPage(
          prevencoes: prevencoes,
          onAtualizar: () {
            setState(() {});
          },
        ),
      ),
    );
  }
void abrirGerenciamentoFluxograma() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          GerenciarFluxogramaPage(
        fluxograma: fluxograma,
        onAtualizar: () {
          setState(() {});
        },
      ),
    ),
  );
}
  // ==========================================================
  // OUTRAS TELAS
  // ==========================================================

  Widget telaGenerica(
    IconData icone,
    String titulo,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            icone,
            size: 70,
            color: Colors.blue,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            titulo,
            style:
                const TextStyle(
              fontSize: 26,
              fontWeight:
                  FontWeight.bold,
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
Widget build(BuildContext context) {
  final telas = [
    telaHome(),
    telaOcorrencias(),
    telaPrevencao(),
    telaMonitoramento(),
    telaFluxograma(),
    telaDashboards(),
    telaConfiguracoes(),
  ];

  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Avenida • ${widget.lojaSelecionada}',
      ),

      actions: [

        // TROCAR LOJA
        if (widget.usuario.administrador)
          IconButton(
            tooltip: 'Trocar loja',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => StoreSelectionPage(
                    usuario: widget.usuario,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.store,
            ),
          ),

        // ==================================================
        // MENU DOS 3 PONTINHOS
        // ==================================================

        PopupMenuButton<int>(
          tooltip: 'Menu',

          icon: const Icon(
            Icons.more_vert_rounded,
          ),

          onSelected: (index) {
            setState(() {
              abaSelecionada = index;
            });
          },

          itemBuilder: (context) => const [

            PopupMenuItem(
              value: 0,
              child: Row(
                children: [
                  Icon(
                    Icons.home_outlined,
                    color: Color(0xFF0757B8),
                  ),
                  SizedBox(width: 12),
                  Text('Home'),
                ],
              ),
            ),

            PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_outlined,
                    color: Color(0xFF0757B8),
                  ),
                  SizedBox(width: 12),
                  Text('Ocorrências'),
                ],
              ),
            ),

            PopupMenuItem(
              value: 2,
              child: Row(
                children: [
                  Icon(
                    Icons.shield_outlined,
                    color: Color(0xFF0757B8),
                  ),
                  SizedBox(width: 12),
                  Text('Prevenção'),
                ],
              ),
            ),

            PopupMenuItem(
              value: 3,
              child: Row(
                children: [
                  Icon(
                    Icons.videocam_outlined,
                    color: Color(0xFF0757B8),
                  ),
                  SizedBox(width: 12),
                  Text('Monitoramento'),
                ],
              ),
            ),

            PopupMenuItem(
              value: 4,
              child: Row(
                children: [
                  Icon(
                    Icons.account_tree_outlined,
                    color: Color(0xFF0757B8),
                  ),
                  SizedBox(width: 12),
                  Text('Fluxograma'),
                ],
              ),
            ),

            PopupMenuItem(
              value: 5,
              child: Row(
                children: [
                  Icon(
                    Icons.bar_chart_outlined,
                    color: Color(0xFF0757B8),
                  ),
                  SizedBox(width: 12),
                  Text('Dashboards'),
                ],
              ),
            ),

            PopupMenuItem(
              value: 6,
              child: Row(
                children: [
                  Icon(
                    Icons.settings_outlined,
                    color: Color(0xFF0757B8),
                  ),
                  SizedBox(width: 12),
                  Text('Configurações'),
                ],
              ),
            ),
          ],
        ),

        // SAIR
        IconButton(
          tooltip: 'Sair',
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginPage(),
              ),
              (route) => false,
            );
          },
          icon: const Icon(
            Icons.logout,
          ),
        ),
      ],
    ),

    // ==================================================
    // CONTEÚDO
    // ==================================================

    body: telas[abaSelecionada],
  );
}}