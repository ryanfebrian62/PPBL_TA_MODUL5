import 'package:flutter/material.dart';

class RiwayatLaporanPage extends StatelessWidget {
  const RiwayatLaporanPage({super.key});

  void _tampilkanPesan(BuildContext context, String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Riwayat Laporan'),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(
                Icons.report,
                color: Colors.blue,
              ),
              title: Text('Lampu Jalan Rusak'),
              subtitle: Text('Status: Diproses'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.report,
                color: Colors.blue,
              ),
              title: Text('Jalan Berlubang'),
              subtitle: Text('Status: Selesai'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.report,
                color: Colors.blue,
              ),
              title: Text('Sampah Menumpuk'),
              subtitle: Text('Status: Diproses'),
            ),
          ),
        ],
      ),

      // Tombol tambah laporan
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _tampilkanPesan(
            context,
            'Membuat laporan baru',
          );
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      // BottomAppBar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Tombol Home
              IconButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.home),
                tooltip: 'Beranda',
              ),

              // Tombol Cari
              IconButton(
                onPressed: () {
                  _tampilkanPesan(
                    context,
                    'Fitur pencarian dipilih',
                  );
                },
                icon: const Icon(Icons.search),
                tooltip: 'Cari',
              ),

              // Ruang untuk FAB
              const SizedBox(width: 60),

              // Tombol Notifikasi
              IconButton(
                onPressed: () {
                  _tampilkanPesan(
                    context,
                    'Tidak ada notifikasi baru',
                  );
                },
                icon: const Icon(Icons.notifications),
                tooltip: 'Notifikasi',
              ),

              // Tombol Profil
              IconButton(
                onPressed: () {
                  _tampilkanPesan(
                    context,
                    'Menu profil dipilih',
                  );
                },
                icon: const Icon(Icons.person),
                tooltip: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}