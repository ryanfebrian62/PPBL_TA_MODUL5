import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../navigation/app_routes.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text(
          'Warga',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        const Text('Kelola aktivitas dan layanan Anda sebagai warga.'),
        const SizedBox(height: 20),
        Card(
          color: Colors.blue,
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.blue, size: 32),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profil Warga',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Pantau pengajuan dan akses layanan kota.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: BlocBuilder<PengajuanCubit, List<Map<String, dynamic>>>(
                builder: (context, data) => _stat(
                  'Total Pengajuan',
                  '${data.length}',
                  Icons.assignment_outlined,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: BlocBuilder<FavoritCubit, Set<String>>(
                builder: (context, data) => _stat(
                  'Layanan Favorit',
                  '${data.length}',
                  Icons.star_outline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Layanan Favorit',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, daftarFavorit) {
            if (daftarFavorit.isEmpty) {
              return const Card(
                child: ListTile(
                  leading: Icon(Icons.star_border, color: Colors.grey),
                  title: Text('Belum ada layanan favorit.'),
                ),
              );
            }
            return Column(
              children: daftarFavorit.map((nama) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.star, color: Colors.amber),
                    title: Text(nama),
                    trailing: IconButton(
                      tooltip: 'Hapus dari favorit',
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () =>
                          context.read<FavoritCubit>().batalTandai(nama),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Riwayat Pengajuan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoutes.detailLayanan,
                arguments: <String, String>{
                  'nama': 'Pengajuan Layanan Umum',
                  'dinas': 'Dinas Komunikasi dan Informatika',
                  'jam': '08.00 - 15.00',
                  'keterangan': 'Formulir pengajuan layanan warga.',
                },
              ),
              child: const Text('Buat pengajuan'),
            ),
          ],
        ),
        BlocBuilder<PengajuanCubit, List<Map<String, dynamic>>>(
          builder: (context, daftar) {
            if (daftar.isEmpty) {
              return const Card(
                child: ListTile(
                  leading: Icon(Icons.history, color: Colors.grey),
                  title: Text('Belum ada pengajuan'),
                  subtitle: Text('Pengajuan yang dikirim akan muncul di sini.'),
                ),
              );
            }
            return Column(
              children: daftar.asMap().entries.toList().reversed.take(3).map((entry) {
                final index = entry.key;
                final item = entry.value;
                final selesai = item['selesai'] == true;
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.assignment_outlined),
                    title: Text(item['namaLayanan']?.toString() ?? '-'),
                    subtitle: Text(selesai ? 'Status: Selesai' : 'Status: Menunggu tindak lanjut'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.detailPengajuan,
                      arguments: item,
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 20),
        _menu(context, Icons.chat_outlined, 'Tanya Petugas', AppRoutes.tanyaPetugas),
        _menu(context, Icons.map_outlined, 'Lokasi Kantor', AppRoutes.lokasiKantor),
        _menu(context, Icons.bar_chart, 'Statistik Layanan', AppRoutes.statistik),
      ],
    );
  }

  Widget _stat(String title, String value, IconData icon) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.blue, size: 28),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Text(title, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      );

  Widget _menu(BuildContext context, IconData icon, String title, String route) =>
      Card(
        child: ListTile(
          leading: Icon(icon, color: Colors.blue),
          title: Text(title),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.pushNamed(context, route),
        ),
      );
}
