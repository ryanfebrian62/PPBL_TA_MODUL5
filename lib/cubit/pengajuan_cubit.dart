
import 'package:flutter_bloc/flutter_bloc.dart';

class PengajuanCubit extends Cubit<List<Map<String, dynamic>>> {
  PengajuanCubit() : super(<Map<String, dynamic>>[]);

  int get totalPengajuan => state.length;

  int get totalKeranjang => state
      .where((item) => item['status'] == 'Dalam Keranjang')
      .length;

  void tambahPengajuan(
    String namaLayanan, {
    String nama = '',
    String email = '',
    String sesi = 'Pagi',
  }) {
    final daftarBaru = List<Map<String, dynamic>>.from(state);

    daftarBaru.add({
      'namaLayanan': namaLayanan,
      'nama': nama,
      'email': email,
      'sesi': sesi,
      'selesai': false,
      'status': 'Dalam Keranjang',
    });

    emit(daftarBaru);
  }

  void kirimSemuaPengajuan() {
    final daftarBaru = state.map((item) {
      final itemBaru = Map<String, dynamic>.from(item);

      if (itemBaru['status'] == 'Dalam Keranjang') {
        itemBaru['status'] = 'Menunggu tindak lanjut';
      }

      return itemBaru;
    }).toList();

    emit(daftarBaru);
  }

  void tandaiSelesai(int index) {
    if (index < 0 || index >= state.length) return;

    final daftarBaru = state
        .map((item) => Map<String, dynamic>.from(item))
        .toList();

    daftarBaru[index]['selesai'] = true;
    daftarBaru[index]['status'] = 'Selesai';

    emit(daftarBaru);
  }

  void hapusPengajuan(int index) {
    if (index < 0 || index >= state.length) return;

    final daftarBaru = List<Map<String, dynamic>>.from(state)
      ..removeAt(index);

    emit(daftarBaru);
  }

  void kosongkanPengajuan() {
    emit(<Map<String, dynamic>>[]);
  }
}
