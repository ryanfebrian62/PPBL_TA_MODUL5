import 'package:flutter/material.dart';

class PengaturanKotaPage extends StatelessWidget {
  const PengaturanKotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Pengaturan Kota'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.location_city),
            title: Text('Kota Saat Ini'),
            subtitle: Text('Nusantara Cerdas'),
          ),
          Divider(),
          SwitchListTile(
            value: true,
            onChanged: null,
            title: Text('Notifikasi Layanan'),
            subtitle: Text(
              'Menerima informasi terbaru dari layanan kota.',
            ),
          ),
        ],
      ),
    );
  }
}