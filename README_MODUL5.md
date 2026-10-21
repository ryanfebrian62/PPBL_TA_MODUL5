# Nusantara Cerdas - Modul 5

Project ini melanjutkan project Modul 4 dan menggunakan Cubit untuk state favorit dan pengajuan.

## Menjalankan project
1. Buka folder project ini di VS Code.
2. Jalankan `flutter pub get`.
3. Jalankan `flutter run -d chrome` untuk mencoba di browser, atau `flutter run` untuk perangkat yang tersedia.

## Perubahan utama
- Menambahkan `flutter_bloc`.
- Menambahkan `FavoritCubit` dan `PengajuanCubit`.
- Mengganti penggunaan Provider/ChangeNotifier pada favorit dan pengajuan.
- Menggunakan `MultiBlocProvider` pada `main.dart`.
- Ikon favorit, daftar favorit, data pengajuan, statistik, dan badge navigasi membaca state dari Cubit.

## Git
Folder `.git` tidak disertakan agar project tidak otomatis terhubung ke repository GitHub sebelumnya. Hubungkan ke repository milik sendiri setelah project diperiksa.
