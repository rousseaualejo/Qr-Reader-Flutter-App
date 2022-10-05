import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:qrreader/models/scan_model.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles({Key? key, required this.tipo}) : super(key: key);

  final String tipo;

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans     = scanListProvider.scans;
    final isLoading = scanListProvider.isLoading;

    final screenSize = MediaQuery.of(context).size;

    return isLoading 
    ? const Center(child: CircularProgressIndicator())
    : scans.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: scans.length,
            itemBuilder: (_, i) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  scanListProvider.borrarScanPorId(scans[i].id!);
                },
                child: Tile(tipo: tipo, scan: scans[i]),
              );
            },
          )
        : SizedBox(
            width: screenSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  tipo == 'http'
                      ? Icons.history_rounded
                      : tipo == 'map'
                          ? Icons.map_outlined
                          : Icons.short_text_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: screenSize.width / 2.5,
                ),
                const Text('No scans with this label yet.'),
              ],
            ),
          );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.tipo,
    required this.scan,
  }) : super(key: key);

  final String tipo;
  final ScanModel scan;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        elevation: 0,
        
        color: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),

        child: 
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          visualDensity:  const VisualDensity(horizontal: VisualDensity.minimumDensity),
          onTap: () async {
            tipo != 'other'
              ? launchUrlString(context, scan)
              : ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Now text is in clipboard'),
                  ),
                );
            await Clipboard.setData(ClipboardData(text: scan.valor));
          },

          title: Text(tipo != 'geo' ? scan.valor : 'Location'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              IconButton(
                icon: const Icon(Icons.copy_rounded),
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Now text is in clipboard'),
                    ),
                  );
                  await Clipboard.setData(ClipboardData(text: scan.valor));
                },
                splashRadius: 24,
                padding: EdgeInsets.zero,
                visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity),
              ),

              IconButton(
                icon: const Icon(Icons.share_rounded),
                onPressed: () async {
                  await Share.share('Check this ${scan.valor}');
                },
                splashRadius: 24,
                padding: EdgeInsets.zero,
                visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity),
              ),

            ],
          ),
        ),

      ),
    );
  }
}
