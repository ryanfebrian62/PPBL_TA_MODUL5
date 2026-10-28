
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';

class DetailLayananPage extends StatefulWidget {
  const DetailLayananPage({
    super.key,
    required this.nama,
    required this.dinas,
    required this.jam,
    required this.keterangan,
  });

  final String nama;
  final String dinas;
  final String jam;
  final String keterangan;

  @override
  State<DetailLayananPage> createState() =>
      _DetailLayananPageState();
}

class _DetailLayananPageState extends State<DetailLayananPage> {
  final TextEditingController _namaController =
      TextEditingController();
  final TextEditingController _emailController =
      TextEditingController();

  bool _setuju = false;
  bool _sedangMengirim = false;
  String _sesi = 'Pagi';

  bool get _formValid {
    return _namaController.text.trim().isNotEmpty &&
        _emailController.text.trim().contains('@') &&
        _setuju;
  }

  Future<void> _ajukanPermohonan() async {
    if (!_formValid || _sedangMengirim) return;

    setState(() {
      _sedangMengirim = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    context.read<PengajuanCubit>().tambahPengajuan(
      widget.nama,
      nama: _namaController.text.trim(),
      email: _emailController.text.trim(),
      sesi: _sesi,
    );

    Navigator.pop(
      context,
      '"${widget.nama}" ditambahkan ke keranjang pengajuan.',
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Layanan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.description,
              size: 70,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),

            Text(
              widget.nama,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Dinas Penanggung Jawab',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.dinas),
            const SizedBox(height: 12),

            const Text(
              'Jam Operasional',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.jam),
            const SizedBox(height: 12),

            const Text(
              'Keterangan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.keterangan),
            const SizedBox(height: 24),

            const Text(
              'Formulir Pengajuan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _namaController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 12),

            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: _setuju,
              title: const Text(
                'Saya menyetujui penggunaan data pribadi.',
              ),
              onChanged: (value) {
                setState(() {
                  _setuju = value ?? false;
                });
              },
            ),
            const SizedBox(height: 8),

            const Text(
              'Pilih Sesi Kunjungan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            RadioListTile<String>(
              title: const Text('Pagi'),
              value: 'Pagi',
              groupValue: _sesi,
              onChanged: (value) {
                setState(() {
                  _sesi = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Siang'),
              value: 'Siang',
              groupValue: _sesi,
              onChanged: (value) {
                setState(() {
                  _sesi = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Sore'),
              value: 'Sore',
              groupValue: _sesi,
              onChanged: (value) {
                setState(() {
                  _sesi = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _formValid && !_sedangMengirim
                    ? _ajukanPermohonan
                    : null,
                child: _sedangMengirim
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Ajukan Permohonan'),
              ),
            ),
            const SizedBox(height: 8),

            const Text(
              'Layanan akan masuk ke keranjang. Anda dapat mengirim '
              'semua layanan sekaligus dari halaman Warga.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
