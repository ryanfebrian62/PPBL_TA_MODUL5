import 'package:flutter/material.dart';
import '../pages/detail_layanan_page.dart';
import '../pages/detail_pengajuan_page.dart';
import '../pages/pengaturan_kota_page.dart';
import '../pages/tentang_aplikasi_page.dart';
import '../pages/statistik_layanan_page.dart';
import '../pages/route_tidak_dikenal_page.dart';
import '../pages/tanya_petugas_page.dart';
import '../pages/lokasi_kantor_page.dart';
import '../pages/riwayat_laporan_page.dart';
import '../navigation/kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String detailLayanan = '/detail-layanan';
  static const String detailPengajuan = '/detail-pengajuan';
  static const String pengaturan = '/pengaturan';
  static const statistik = '/statistik';
  static const String lokasiKantor = '/lokasi-kantor';
  static const String tanyaPetugas = '/tanya-petugas';
  static const String tentang = '/tentang';
  static const String riwayatLaporan = '/riwayat-laporan';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      pengaturan: (context) => const PengaturanKotaPage(),
      tentang: (context) => const TentangAplikasiPage(),
      statistik: (context) => const StatistikPage(),
      lokasiKantor: (context) => const LokasiKantorPage(),
      tanyaPetugas: (context) => const TanyaPetugasPage(),
      riwayatLaporan: (context) => const RiwayatLaporanPage(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    // Route untuk detail layanan
    if (settings.name == detailLayanan) {
      final arguments =
          settings.arguments as Map<String, String>? ?? {};

      return MaterialPageRoute(
        builder: (context) => DetailLayananPage(
          nama: arguments['nama'] ?? 'Tidak ada nama',
          dinas: arguments['dinas'] ?? 'Tidak diketahui',
          jam: arguments['jam'] ?? 'Tidak diketahui',
          keterangan:
              arguments['keterangan'] ?? 'Tidak ada keterangan',
        ),
      );
    }

    if (settings.name == detailPengajuan) {
      final data =
          settings.arguments as Map<String, dynamic>;

      return MaterialPageRoute(
        builder: (context) => DetailPengajuanPage(
          pengajuan: data,
        ),
      );
    }

    return null;
  }

  static Route<dynamic> routeTidakDikenal(
    RouteSettings settings,
  ) {
    return MaterialPageRoute(
      builder: (context) => RouteTidakDikenalPage(
        namaRoute: settings.name ?? 'Tidak diketahui',
      ),
    );
  }
}