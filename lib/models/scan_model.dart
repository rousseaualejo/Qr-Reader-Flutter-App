import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  ScanModel({
    this.id,
    this.tipo,
    this.canLaunch = false,
    required this.valor,
  }) {
    if (valor.contains('http')) {
      tipo = "http";
    } else if (valor.contains('geo')) {
      tipo = "geo";
    } else {
      tipo = "other";
    }
    if (valor.split(':').length > 1) {
      canLaunch = true;
    } else {
      canLaunch = false;
    }
  }

  int? id;
  String? tipo;
  String valor;
  bool? canLaunch = false;

  LatLng getLatLng() {
    final latlng = valor.substring(4).split(',');
    final lat = double.parse(latlng[0]);
    final lng = double.parse(latlng[1]);

    return LatLng(lat, lng);
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
