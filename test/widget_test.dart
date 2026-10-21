import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nusantara_cerdas_nav/cubit/favorit_cubit.dart';
import 'package:nusantara_cerdas_nav/cubit/pengajuan_cubit.dart';
import 'package:nusantara_cerdas_nav/main.dart';

void main() {
  testWidgets('Nusantara Cerdas dapat ditampilkan', (tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => FavoritCubit()),
          BlocProvider(create: (_) => PengajuanCubit()),
        ],
        child: const NusantaraCerdasApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('NUSANTARA CERDAS'), findsOneWidget);
  });
}
