
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LokasiKantorPage extends StatefulWidget {
  const LokasiKantorPage({super.key});

  @override
  State<LokasiKantorPage> createState() => _LokasiKantorPageState();
}

class _LokasiKantorPageState extends State<LokasiKantorPage> {
  static const LatLng _pusatKota = LatLng(-6.9175, 107.6191);

  final Set<Marker> _markers = {
    Marker(
      markerId: const MarkerId('kantor1'),
      position: const LatLng(-6.9147, 107.6098),
      infoWindow: const InfoWindow(
        title: 'Kantor Pelayanan Warga',
        snippet: 'Contoh lokasi pelayanan warga',
      ),
    ),
    Marker(
      markerId: const MarkerId('kantor2'),
      position: const LatLng(-6.9218, 107.6071),
      infoWindow: const InfoWindow(
        title: 'Kantor Informasi Kota',
        snippet: 'Contoh lokasi informasi kota',
      ),
    ),
    Marker(
      markerId: const MarkerId('kantor3'),
      position: const LatLng(-6.9024, 107.6188),
      infoWindow: const InfoWindow(
        title: 'Kantor Administrasi',
        snippet: 'Contoh lokasi administrasi',
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Kantor'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Temukan lokasi kantor dan layanan publik '
              'melalui peta Nusantara Cerdas.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: _pusatKota,
                zoom: 13,
              ),
              markers: _markers,
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}
