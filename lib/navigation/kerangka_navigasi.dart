
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../pages/beranda_page.dart';
import '../pages/layanan_page.dart';
import '../pages/warga_page.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indexAktif = 0;

  void _ubahHalaman(int index) {
    setState(() {
      _indexAktif = index;
    });
  }

  void _bukaDrawerRoute(String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    final layarLebar = lebar >= 600;

    final halaman = [
      BerandaPage(
        onBukaLayanan: () => _ubahHalaman(1),
      ),
      const LayananPage(),
      const WargaPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NUSANTARA CERDAS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      drawer: NavigationDrawer(
        selectedIndex: _indexAktif,
        onDestinationSelected: (index) {
          Navigator.pop(context);

          if (index < 3) {
            _ubahHalaman(index);
          }
        },
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 24, 16, 16),
            child: Text(
              'Menu Utama',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: Text('Beranda'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.miscellaneous_services_outlined),
            selectedIcon: Icon(Icons.miscellaneous_services),
            label: Text('Layanan'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: Text('Warga'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 24, 16, 8),
            child: Text(
              'Menu Pendukung',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Pengaturan Kota'),
            onTap: () => _bukaDrawerRoute(AppRoutes.pengaturan),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Statistik Layanan'),
            onTap: () => _bukaDrawerRoute(AppRoutes.statistik),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Tentang Aplikasi'),
            onTap: () => _bukaDrawerRoute(AppRoutes.tentang),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Keluar'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Menu Keluar dipilih'),
                ),
              );
            },
          ),
        ],
      ),

      body: Row(
        children: [
          if (layarLebar)
            NavigationRail(
              selectedIndex: _indexAktif,
              onDestinationSelected: _ubahHalaman,
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Beranda'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.miscellaneous_services_outlined),
                  selectedIcon: Icon(Icons.miscellaneous_services),
                  label: Text('Layanan'),
                ),
                NavigationRailDestination(
                  icon: IkonWargaDenganBadge(terpilih: false),
                  selectedIcon: IkonWargaDenganBadge(terpilih: true),
                  label: Text('Warga'),
                ),
              ],
            ),
          Expanded(
            child: halaman[_indexAktif],
          ),
        ],
      ),

      bottomNavigationBar: layarLebar
          ? null
          : NavigationBar(
              selectedIndex: _indexAktif,
              onDestinationSelected: _ubahHalaman,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                NavigationDestination(
                  icon: Icon(Icons.miscellaneous_services_outlined),
                  selectedIcon: Icon(Icons.miscellaneous_services),
                  label: 'Layanan',
                ),
                NavigationDestination(
                  icon: IkonWargaDenganBadge(terpilih: false),
                  selectedIcon: IkonWargaDenganBadge(terpilih: true),
                  label: 'Warga',
                ),
              ],
            ),
    );
  }
}

class IkonWargaDenganBadge extends StatelessWidget {
  const IkonWargaDenganBadge({
    super.key,
    required this.terpilih,
  });

  final bool terpilih;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
        PengajuanCubit,
        List<Map<String, dynamic>>,
        int>(
      selector: (state) => state.length,
      builder: (context, total) {
        return Badge(
          isLabelVisible: total > 0,
          label: Text('$total'),
          child: Icon(
            terpilih ? Icons.people : Icons.people_outline,
          ),
        );
      },
    );
  }
}
