
import 'package:flutter/material.dart';

class TanyaPetugasPage extends StatefulWidget {
  const TanyaPetugasPage({super.key});

  @override
  State<TanyaPetugasPage> createState() => _TanyaPetugasPageState();
}

class _TanyaPetugasPageState extends State<TanyaPetugasPage> {
  final TextEditingController _pesanController =
      TextEditingController();

  final List<Map<String, String>> _daftarPesan = [
    {
      'pengirim': 'petugas',
      'pesan': 'Halo! Ada yang bisa kami bantu?',
    },
  ];

  void _kirimPesan() {
    final pesan = _pesanController.text.trim();

    if (pesan.isEmpty) return;

    setState(() {
      _daftarPesan.add({
        'pengirim': 'warga',
        'pesan': pesan,
      });

      _daftarPesan.add({
        'pengirim': 'petugas',
        'pesan': 'Terima kasih. Pesan Anda telah diterima.',
      });
    });

    _pesanController.clear();
  }

  @override
  void dispose() {
    _pesanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tanya Petugas'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _daftarPesan.length,
              itemBuilder: (context, index) {
                final data = _daftarPesan[index];
                final warga = data['pengirim'] == 'warga';

                return Align(
                  alignment: warga
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(
                      maxWidth: 280,
                    ),
                    decoration: BoxDecoration(
                      color: warga
                          ? Colors.blue
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      data['pesan']!,
                      style: TextStyle(
                        color: warga ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _pesanController,
                    decoration: const InputDecoration(
                      hintText: 'Tulis pesan...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _kirimPesan(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _kirimPesan,
                  icon: const Icon(Icons.send),
                  color: Colors.blue,
                  tooltip: 'Kirim pesan',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
