
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../cubit/theme_cubit.dart';
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
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text('Kelola aktivitas dan layanan Anda sebagai warga.'),
        const SizedBox(height: 20),

        // Sakelar mode terang dan gelap.
        Card(
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) {
              final modeGelap = mode == ThemeMode.dark;

              return SwitchListTile(
                secondary: Icon(
                  modeGelap ? Icons.dark_mode : Icons.light_mode,
                ),
                title: const Text('Mode Gelap'),
                subtitle: Text(
                  modeGelap ? 'Aktif' : 'Tidak aktif',
                ),
                value: modeGelap,
                onChanged: (_) {
                  context.read<ThemeCubit>().toggleMode();
                },
              );
            },
          ),
        ),
        const SizedBox(height: 18),

        Card(
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor:
                      Theme.of(context).colorScheme.onPrimary,
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.primary,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
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
              child: BlocBuilder<
                  PengajuanCubit,
                  List<Map<String, dynamic>>>(
                builder: (context, data) => _stat(
                  context,
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
                  context,
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
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, daftarFavorit) {
            if (daftarFavorit.isEmpty) {
              return const Card(
                child: ListTile(
                  leading: Icon(
                    Icons.star_border,
                    color: Colors.grey,
                  ),
                  title: Text('Belum ada layanan favorit.'),
                ),
              );
            }

            return Column(
              children: daftarFavorit.map((nama) {
                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    title: Text(nama),
                    trailing: IconButton(
                      tooltip: 'Hapus dari favorit',
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        context
                            .read<FavoritCubit>()
                            .batalTandai(nama);
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 24),

        Row(
          children: [
            const Expanded(
              child: Text(
                'Keranjang Pengajuan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BlocBuilder<
                PengajuanCubit,
                List<Map<String, dynamic>>>(
              builder: (context, daftar) {
                final totalKeranjang = daftar
                    .where(
                      (item) =>
                          item['status'] == 'Dalam Keranjang',
                    )
                    .length;

                return FilledButton(
                  onPressed: totalKeranjang == 0
                      ? null
                      : () {
                          context
                              .read<PengajuanCubit>()
                              .kirimSemuaPengajuan();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '$totalKeranjang layanan berhasil dikirim.',
                              ),
                            ),
                          );
                        },
                  child: Text('Kirim Semua ($totalKeranjang)'),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 8),

        BlocBuilder<
            PengajuanCubit,
            List<Map<String, dynamic>>>(
          builder: (context, daftar) {
            final keranjang = daftar
                .asMap()
                .entries
                .where(
                  (entry) =>
                      entry.value['status'] == 'Dalam Keranjang',
                )
                .toList();

            if (keranjang.isEmpty) {
              return const Card(
                child: ListTile(
                  leading: Icon(Icons.shopping_basket_outlined),
                  title: Text('Keranjang masih kosong.'),
                  subtitle: Text(
                    'Pilih layanan dan tambahkan ke keranjang terlebih dahulu.',
                  ),
                ),
              );
            }

            return Column(
              children: keranjang.map((entry) {
                final item = entry.value;

                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.assignment_add),
                    title: Text(
                      item['namaLayanan']?.toString() ?? '-',
                    ),
                    subtitle: Text(
                      'Sesi: ${item['sesi'] ?? 'Pagi'}',
                    ),
                    trailing: IconButton(
                      tooltip: 'Hapus dari keranjang',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        context
                            .read<PengajuanCubit>()
                            .hapusPengajuan(entry.key);
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 24),

        Row(
          children: [
            const Expanded(
              child: Text(
                'Riwayat Pengajuan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
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

        BlocBuilder<
            PengajuanCubit,
            List<Map<String, dynamic>>>(
          builder: (context, daftar) {
            final riwayat = daftar.asMap().entries
                .where(
                  (entry) =>
                      entry.value['status'] != 'Dalam Keranjang',
                )
                .toList()
                .reversed
                .take(5)
                .toList();

            if (riwayat.isEmpty) {
              return const Card(
                child: ListTile(
                  leading: Icon(Icons.history, color: Colors.grey),
                  title: Text('Belum ada riwayat pengajuan'),
                  subtitle: Text(
                    'Layanan yang sudah dikirim akan muncul di sini.',
                  ),
                ),
              );
            }

            return Column(
              children: riwayat.map((entry) {
                final item = entry.value;
                final status = item['status']?.toString() ??
                    (item['selesai'] == true
                        ? 'Selesai'
                        : 'Menunggu tindak lanjut');

                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.assignment_outlined),
                    title: Text(
                      item['namaLayanan']?.toString() ?? '-',
                    ),
                    subtitle: Text('Status: $status'),
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

        _menu(
          context,
          Icons.chat_outlined,
          'Tanya Petugas',
          AppRoutes.tanyaPetugas,
        ),
        _menu(
          context,
          Icons.map_outlined,
          'Lokasi Kantor',
          AppRoutes.lokasiKantor,
        ),
        _menu(
          context,
          Icons.bar_chart,
          'Statistik Layanan',
          AppRoutes.statistik,
        ),
      ],
    );
  }

  Widget _stat(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menu(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
