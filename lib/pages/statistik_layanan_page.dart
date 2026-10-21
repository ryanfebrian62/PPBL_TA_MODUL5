import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

import '../cubit/pengajuan_cubit.dart';

class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  @override
  Widget build(BuildContext context) {
    final daftar = context.watch<PengajuanCubit>().state;

    final total = daftar.length;
    final selesai =
        daftar.where((item) => item['selesai'] == true).length;
    final diproses = total - selesai;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik Layanan'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ringkasan Pengajuan Warga',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                _kartuStatistik('Total', total, Colors.blue),
                const SizedBox(width: 10),
                _kartuStatistik('Diproses', diproses, Colors.orange),
                const SizedBox(width: 10),
                _kartuStatistik('Selesai', selesai, Colors.green),
              ],
            ),

            const SizedBox(height: 30),
            const Text(
              'Status Pengajuan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            if (total == 0)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Belum ada data pengajuan untuk ditampilkan.',
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              SizedBox(
                height: 250,
                child: PieChart(
                  PieChartData(
                    sections: [
                      if (selesai > 0)
                        PieChartSectionData(
                          value: selesai.toDouble(),
                          title: 'Selesai\n$selesai',
                          color: Colors.green,
                          radius: 85,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (diproses > 0)
                        PieChartSectionData(
                          value: diproses.toDouble(),
                          title: 'Diproses\n$diproses',
                          color: Colors.orange,
                          radius: 85,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                    sectionsSpace: 3,
                    centerSpaceRadius: 25,
                  ),
                ),
              ),

            const SizedBox(height: 20),
            const Text(
              'Keterangan:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.circle, color: Colors.orange, size: 14),
                SizedBox(width: 8),
                Text('Pengajuan belum selesai'),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: 14),
                SizedBox(width: 8),
                Text('Pengajuan selesai'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _kartuStatistik(String judul, int jumlah, Color warna) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 6,
          ),
          child: Column(
            children: [
              Text(
                '$jumlah',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: warna,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                judul,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
