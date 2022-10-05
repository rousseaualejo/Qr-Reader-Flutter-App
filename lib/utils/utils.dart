import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:qrreader/providers/db_providers.dart';

launchUrlString(BuildContext context, ScanModel scan) async {
  final _url = scan.valor;
  
  if (scan.tipo != 'geo') {
    if (!await launchUrl(
        Uri.parse(_url), 
        mode: LaunchMode.externalNonBrowserApplication,
      )
    ) throw 'Could not launch $_url';
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
