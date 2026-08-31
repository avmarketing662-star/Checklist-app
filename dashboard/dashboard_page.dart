import 'package:flutter/material.dart';


// ============================================================
// DASHBOARD
// ============================================================

Widget telaDashboards() {
  return SafeArea(
    child: ListView(
      padding: const EdgeInsets.all(18),
      children: [

        // ======================================================
        // CABEÇALHO
        // ======================================================

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dashboards',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Visão geral da operação',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                Icons.insights,
                color: Colors.blue,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // ======================================================
        // FILTROS
        // ======================================================

        Row(
          children: [

            Expanded(
              child: _filtroDashboard(
                Icons.calendar_today,
                'Período',
                'Últimos 30 dias',
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: _filtroDashboard(
                Icons.store,
                'Loja',
                'Todas as lojas',
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // ======================================================
        // INDICADORES
        // ======================================================

        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.45,
          children: [

            _indicadorDashboard(
              titulo: 'Ocorrências',
              valor: '24',
              variacao: '+8,2%',
              icone: Icons.warning_amber_rounded,
              cor: Colors.red,
            ),

            _indicadorDashboard(
              titulo: 'Resolvidas',
              valor: '18',
              variacao: '+12%',
              icone: Icons.check_circle_outline,
              cor: Colors.green,
            ),

            _indicadorDashboard(
              titulo: 'Em aberto',
              valor: '6',
              variacao: '-4,5%',
              icone: Icons.pending_actions,
              cor: Colors.orange,
            ),

            _indicadorDashboard(
              titulo: 'Taxa resolução',
              valor: '75%',
              variacao: '+5,4%',
              icone: Icons.analytics_outlined,
              cor: Colors.blue,
            ),
          ],
        ),

        const SizedBox(height: 22),

        // ======================================================
        // GRÁFICO DE OCORRÊNCIAS
        // ======================================================

        _cardDashboard(
          titulo: 'Ocorrências ao longo do tempo',
          subtitulo: 'Últimos 7 dias',
          child: SizedBox(
            height: 220,
            child: CustomPaint(
              painter:
                  _GraficoLinhaPainter(),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // ======================================================
        // OCORRÊNCIAS POR LOJA
        // ======================================================

        _cardDashboard(
          titulo: 'Ocorrências por loja',
          subtitulo:
              'Distribuição entre as unidades',
          child: Column(
            children: [

              _barraLoja(
                'Camanducaia',
                42,
                0.90,
              ),

              _barraLoja(
                'Extrema',
                31,
                0.70,
              ),

              _barraLoja(
                'Cambuí',
                22,
                0.50,
              ),

              _barraLoja(
                'Itapeva',
                15,
                0.34,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ======================================================
        // SETORES
        // ======================================================

        _cardDashboard(
          titulo: 'Ocorrências por setor',
          subtitulo:
              'Setores com maior número de registros',
          child: Column(
            children: [

              _rankingSetor(
                'Açougue',
                18,
                Icons.restaurant,
              ),

              _rankingSetor(
                'Padaria',
                14,
                Icons.bakery_dining,
              ),

              _rankingSetor(
                'Hortifruti',
                11,
                Icons.eco,
              ),

              _rankingSetor(
                'Caixa',
                8,
                Icons.point_of_sale,
              ),

              _rankingSetor(
                'Reposição',
                6,
                Icons.inventory_2,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ======================================================
        // STATUS
        // ======================================================

        _cardDashboard(
          titulo: 'Status das ocorrências',
          subtitulo:
              'Situação atual dos registros',
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            children: [

              _statusDashboard(
                'Resolvidas',
                '18',
                Colors.green,
                Icons.check_circle,
              ),

              _statusDashboard(
                'Em análise',
                '4',
                Colors.orange,
                Icons.pending,
              ),

              _statusDashboard(
                'Abertas',
                '2',
                Colors.red,
                Icons.error_outline,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ======================================================
        // MONITORAMENTO
        // ======================================================

        _cardDashboard(
          titulo: 'Monitoramento',
          subtitulo:
              'Status dos equipamentos',
          child: Row(
            children: [

              Expanded(
                child: _monitoramentoDashboard(
                  'Normal',
                  '8',
                  Colors.green,
                  Icons.check_circle,
                ),
              ),

              Expanded(
                child: _monitoramentoDashboard(
                  'Alerta',
                  '2',
                  Colors.orange,
                  Icons.warning_amber,
                ),
              ),

              Expanded(
                child: _monitoramentoDashboard(
                  'Crítico',
                  '1',
                  Colors.red,
                  Icons.error,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),
      ],
    ),
  );
}

// ============================================================
// FILTRO
// ============================================================

Widget _filtroDashboard(
  IconData icone,
  String titulo,
  String valor,
) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 11,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(12),
      border: Border.all(
        color: Colors.grey.shade200,
      ),
    ),
    child: Row(
      children: [

        Icon(
          icone,
          size: 17,
          color: Colors.blue,
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                valor,
                overflow:
                    TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const Icon(
          Icons.keyboard_arrow_down,
          size: 18,
        ),
      ],
    ),
  );
}

// ============================================================
// INDICADOR
// ============================================================

Widget _indicadorDashboard({
  required String titulo,
  required String valor,
  required String variacao,
  required IconData icone,
  required Color cor,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black
              .withOpacity(0.04),
          blurRadius: 12,
          offset:
              const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Row(
          children: [

            Container(
              padding:
                  const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color:
                    cor.withOpacity(0.10),
                borderRadius:
                    BorderRadius.circular(9),
              ),
              child: Icon(
                icone,
                color: cor,
                size: 19,
              ),
            ),

            const Spacer(),

            Text(
              variacao,
              style: TextStyle(
                color: cor,
                fontSize: 10,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),

        const Spacer(),

        Text(
          valor,
          style: const TextStyle(
            fontSize: 25,
            fontWeight:
                FontWeight.bold,
          ),
        ),

        Text(
          titulo,
          style: TextStyle(
            color:
                Colors.grey.shade600,
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// CARD
// ============================================================

Widget _cardDashboard({
  required String titulo,
  required String subtitulo,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black
              .withOpacity(0.04),
          blurRadius: 12,
          offset:
              const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Text(
          titulo,
          style: const TextStyle(
            fontSize: 16,
            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          subtitulo,
          style: TextStyle(
            color:
                Colors.grey.shade600,
            fontSize: 11,
          ),
        ),

        const SizedBox(height: 18),

        child,
      ],
    ),
  );
}

// ============================================================
// BARRA POR LOJA
// ============================================================

Widget _barraLoja(
  String nome,
  int valor,
  double porcentagem,
) {
  return Padding(
    padding:
        const EdgeInsets.only(
      bottom: 16,
    ),
    child: Column(
      children: [

        Row(
          children: [

            Expanded(
              child: Text(
                nome,
                style:
                    const TextStyle(
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),

            Text(
              '$valor',
              style:
                  const TextStyle(
                fontSize: 12,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),

        const SizedBox(height: 7),

        ClipRRect(
          borderRadius:
              BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: porcentagem,
            minHeight: 8,
            backgroundColor:
                Colors.grey.shade200,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// RANKING
// ============================================================

Widget _rankingSetor(
  String nome,
  int quantidade,
  IconData icone,
) {
  return Padding(
    padding:
        const EdgeInsets.only(
      bottom: 12,
    ),
    child: Row(
      children: [

        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color:
                Colors.blue.withOpacity(
              0.08,
            ),
            borderRadius:
                BorderRadius.circular(10),
          ),
          child: Icon(
            icone,
            color: Colors.blue,
            size: 19,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            nome,
            style: const TextStyle(
              fontSize: 13,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ),

        Text(
          '$quantidade',
          style: const TextStyle(
            fontSize: 14,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// STATUS
// ============================================================

Widget _statusDashboard(
  String titulo,
  String valor,
  Color cor,
  IconData icone,
) {
  return Column(
    children: [

      Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color:
              cor.withOpacity(0.10),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icone,
          color: cor,
          size: 23,
        ),
      ),

      const SizedBox(height: 7),

      Text(
        valor,
        style: const TextStyle(
          fontSize: 20,
          fontWeight:
              FontWeight.bold,
        ),
      ),

      Text(
        titulo,
        style: TextStyle(
          color:
              Colors.grey.shade600,
          fontSize: 10,
        ),
      ),
    ],
  );
}

// ============================================================
// MONITORAMENTO
// ============================================================

Widget _monitoramentoDashboard(
  String titulo,
  String valor,
  Color cor,
  IconData icone,
) {
  return Column(
    children: [

      Icon(
        icone,
        color: cor,
        size: 28,
      ),

      const SizedBox(height: 5),

      Text(
        valor,
        style: const TextStyle(
          fontSize: 20,
          fontWeight:
              FontWeight.bold,
        ),
      ),

      Text(
        titulo,
        style: TextStyle(
          color:
              Colors.grey.shade600,
          fontSize: 10,
        ),
      ),
    ],
  );
}

// ============================================================
// GRÁFICO DE LINHA
// ============================================================

class _GraficoLinhaPainter
    extends CustomPainter {

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint =
        Paint()
          ..style =
              PaintingStyle.stroke
          ..strokeWidth = 3;

    final grade =
        Paint()
          ..color =
              Colors.grey.shade200
          ..strokeWidth = 1;

    // --------------------------------------------------------
    // GRADE
    // --------------------------------------------------------

    for (int i = 0; i < 5; i++) {
      final y =
          size.height * i / 4;

      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        grade,
      );
    }

    // --------------------------------------------------------
    // LINHA
    // --------------------------------------------------------

    final pontos = [
      0.72,
      0.50,
      0.65,
      0.32,
      0.45,
      0.20,
      0.38,
    ];

    final path = Path();

    for (int i = 0;
        i < pontos.length;
        i++) {

      final x =
          size.width *
              i /
              (pontos.length - 1);

      final y =
          size.height *
              pontos[i];

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    // --------------------------------------------------------
    // PONTOS
    // --------------------------------------------------------

    final pontoPaint =
        Paint()
          ..style =
              PaintingStyle.fill;

    for (int i = 0;
        i < pontos.length;
        i++) {

      final x =
          size.width *
              i /
              (pontos.length - 1);

      final y =
          size.height *
              pontos[i];

      canvas.drawCircle(
        Offset(x, y),
        5,
        pontoPaint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}