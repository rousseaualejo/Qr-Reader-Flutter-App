import 'package:flutter/material.dart';

import 'package:qrreader/providers/db_providers.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';
  bool isLoading = false;

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    nuevoScan.id = id;

    if (tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
      notifyListeners();
    }

    return nuevoScan;
  }

  cargarScans() async {
    final nuevosScans = await DBProvider.db.getAllScans();
    scans = nuevosScans.isNotEmpty ? [...nuevosScans as List<ScanModel>] : [];

    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    toggleLoading();

    final nuevosScans = await DBProvider.db.getScansByTipo(tipo);
    scans = nuevosScans.isNotEmpty ? [...nuevosScans as List<ScanModel>] : [];
    tipoSeleccionado = tipo;

    toggleLoading();
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScan();
    scans = [];
    notifyListeners();
  }

  borrarScanPorId(int id) async {
    await DBProvider.db.deleteScan(id);
    cargarScansPorTipo(tipoSeleccionado);
  }

  toggleLoading() {
    isLoading = !isLoading;
  }
}
