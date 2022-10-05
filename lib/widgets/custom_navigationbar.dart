import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qrreader/providers/ui_providers.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    return NavigationBar(
      selectedIndex: uiProvider.selectedMenuOpt,
      
      onDestinationSelected: (int index) {
        uiProvider.selectedMenuOpt = index;
      },

      destinations: const [
        NavigationDestination(
          selectedIcon: Icon(Icons.map),
          label: 'Maps',
          icon: Icon(Icons.map_outlined),
        ),

        NavigationDestination(
          selectedIcon: Icon(Icons.history),
          label: 'Links',
          icon: Icon(Icons.history_outlined),
        ),

        NavigationDestination(
          selectedIcon: Icon(Icons.more_horiz),
          label: 'Others',
          icon: Icon(Icons.more_horiz_outlined),
        ),
      ],

    );

  }
}
