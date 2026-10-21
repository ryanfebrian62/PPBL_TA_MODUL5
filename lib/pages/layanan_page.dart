import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/favorit_cubit.dart';

class LayananPage extends StatelessWidget {
  const LayananPage({super.key});

  void _bukaDetail(
    BuildContext context, {
    required String nama,
    required String dinas,
    required String jam,
    required String keterangan,
  }) async {
    final hasil = await Navigator.pushNamed(
      context,
      '/detail-layanan',
      arguments: {
        'nama': nama,
        'dinas': dinas,
        'jam': jam,
        'keterangan': keterangan,
      },
    );

    if (hasil != null && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(hasil.toString())));
    }
  }

  Widget _itemLayanan(
    BuildContext context, {
    required String nama,
    required String dinas,
    required String jam,
    required String keterangan,
  }) {
    return BlocBuilder<FavoritCubit, Set<String>>(
      builder: (context, daftarFavorit) {
        final isFavorit = daftarFavorit.contains(nama);

        return Card(
          child: ListTile(
            leading: const Icon(Icons.description, color: Colors.blue),
            title: Text(
              nama,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(dinas),
            trailing: IconButton(
              tooltip: isFavorit ? 'Hapus dari favorit' : 'Tambah ke favorit',
              onPressed: () {
                final cubit = context.read<FavoritCubit>();
                if (isFavorit) {
                  cubit.batalTandai(nama);
                } else {
                  cubit.tandai(nama);
                }
              },
              icon: Icon(
                isFavorit ? Icons.star : Icons.star_border,
                color: isFavorit ? Colors.amber : Colors.grey,
              ),
            ),
            onTap: () {
              _bukaDetail(
                context,
                nama: nama,
                dinas: dinas,
                jam: jam,
                keterangan: keterangan,
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Layanan Publik',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Perizinan'),
              Tab(text: 'Kesehatan'),
              Tab(text: 'Transportasi'),
            ],
          ),

          Expanded(
            child: TabBarView(
              children: [
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _itemLayanan(
                      context,
                      nama: 'Izin Usaha',
                      dinas: 'DPMPTSP',
                      jam: '08.00 - 16.00',
                      keterangan:
                          'Layanan pengajuan izin usaha bagi masyarakat.',
                    ),
                    _itemLayanan(
                      context,
                      nama: 'Izin Bangunan',
                      dinas: 'Dinas PUPR',
                      jam: '08.00 - 15.00',
                      keterangan: 'Layanan pengurusan izin bangunan.',
                    ),
                    _itemLayanan(
                      context,
                      nama: 'Izin Reklame',
                      dinas: 'DPMPTSP',
                      jam: '08.00 - 16.00',
                      keterangan: 'Layanan pengajuan izin pemasangan reklame.',
                    ),
                  ],
                ),

                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _itemLayanan(
                      context,
                      nama: 'Pendaftaran Puskesmas',
                      dinas: 'Dinas Kesehatan',
                      jam: '08.00 - 14.00',
                      keterangan: 'Layanan pendaftaran kunjungan puskesmas.',
                    ),
                    _itemLayanan(
                      context,
                      nama: 'Layanan Ambulans',
                      dinas: 'Dinas Kesehatan',
                      jam: '24 Jam',
                      keterangan:
                          'Layanan bantuan ambulans untuk kondisi darurat.',
                    ),
                    _itemLayanan(
                      context,
                      nama: 'Konsultasi Kesehatan',
                      dinas: 'Dinas Kesehatan',
                      jam: '08.00 - 15.00',
                      keterangan: 'Layanan konsultasi kesehatan masyarakat.',
                    ),
                  ],
                ),

                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _itemLayanan(
                      context,
                      nama: 'Informasi Angkutan Umum',
                      dinas: 'Dinas Perhubungan',
                      jam: '08.00 - 16.00',
                      keterangan: 'Informasi rute dan jadwal angkutan umum.',
                    ),
                    _itemLayanan(
                      context,
                      nama: 'Pengaduan Transportasi',
                      dinas: 'Dinas Perhubungan',
                      jam: '08.00 - 16.00',
                      keterangan:
                          'Layanan pengaduan terkait transportasi kota.',
                    ),
                    _itemLayanan(
                      context,
                      nama: 'Kartu Parkir',
                      dinas: 'Dinas Perhubungan',
                      jam: '08.00 - 15.00',
                      keterangan:
                          'Layanan informasi dan pengurusan kartu parkir.',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
