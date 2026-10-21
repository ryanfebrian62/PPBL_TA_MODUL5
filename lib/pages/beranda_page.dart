import 'package:flutter/material.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({
    super.key,
    required this.onBukaLayanan,
  });

  final VoidCallback onBukaLayanan;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_city,
            size: 90,
            color: Colors.blue,
          ),
          const SizedBox(height: 20),

          const Text(
            'Selamat Datang di Nusantara Cerdas',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Platform layanan kota yang membantu '
            'masyarakat mengakses informasi dan layanan '
            'publik dengan lebih mudah.',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          // Informasi Kota
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.info,
                color: Colors.blue,
              ),
              title: const Text(
                'Informasi Kota',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Akses informasi mengenai kota.',
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/pengaturan',
                );
              },
            ),
          ),

          // Layanan Masyarakat
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.support_agent,
                color: Colors.blue,
              ),
              title: const Text(
                'Layanan Masyarakat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Temukan berbagai layanan untuk warga.',
              ),
              onTap: onBukaLayanan,
            ),
          ),
        ],
      ),
    );
  }
}