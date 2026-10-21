import 'package:flutter/material.dart';

class DetailPengajuanPage extends StatelessWidget {
  const DetailPengajuanPage({
    super.key,
    required this.pengajuan,
  });

  final Map<String, dynamic> pengajuan;

  @override
  Widget build(BuildContext context) {
    final selesai = pengajuan['selesai'] == true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengajuan'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.description,
                size: 80,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Informasi Pengajuan',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            _detail('Nama Layanan', pengajuan['namaLayanan']),
            _detail('Nama Pemohon', pengajuan['nama']),
            _detail('Email', pengajuan['email']),
            _detail('Sesi Kunjungan', pengajuan['sesi']),

            const SizedBox(height: 12),

            const Text(
              'Status Pengajuan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Chip(
              avatar: Icon(
                selesai ? Icons.check_circle : Icons.hourglass_top,
                color: selesai ? Colors.green : Colors.orange,
              ),
              label: Text(
                selesai
                    ? 'Selesai ditindaklanjuti'
                    : 'Menunggu tindak lanjut',
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detail(String judul, dynamic nilai) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            judul,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(nilai?.toString() ?? '-'),
        ],
      ),
    );
  }
}
