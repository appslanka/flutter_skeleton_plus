import 'package:example/examples/custom_shimmer_gradient.dart';
import 'package:example/examples/items.dart';
import 'package:example/examples/list_view_cards.dart';
import 'package:example/examples/list_view_custom.dart';
import 'package:example/examples/rtl.dart';
import 'package:example/examples/theme_modes.dart';
import 'package:flutter/material.dart';

import 'examples/list_view_default.dart';
import 'examples/skeleton_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skeletons Examples"),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).push((MaterialPageRoute(
                  builder: (context) => const ItemsExamplePage()))),
              child: const Text(
                "Items",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(),
            TextButton(
              onPressed: () => Navigator.of(context).push((MaterialPageRoute(
                  builder: (context) => ListViewExample1Page()))),
              child: const Text(
                "List View (Default)",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(),
            TextButton(
              onPressed: () => Navigator.of(context).push((MaterialPageRoute(
                  builder: (context) => ListViewExample2Page()))),
              child: const Text(
                "List View (Custom List Tiles)",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(),
            TextButton(
              onPressed: () => Navigator.of(context).push((MaterialPageRoute(
                  builder: (context) => ListviewCardsExamplePage()))),
              child: const Text(
                "List View (Cards)",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(),
            TextButton(
              onPressed: () => Navigator.of(context).push((MaterialPageRoute(
                  builder: (context) => SkeletonThemeExamplePage()))),
              child: const Text(
                "SkeletonTheme",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(),
            TextButton(
              onPressed: () => Navigator.of(context).push((MaterialPageRoute(
                  builder: (context) => ThemeModesExamplePage()))),
              child: const Text(
                "Light/Dark Mode",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                  (MaterialPageRoute(builder: (context) => RtlExamplePage()))),
              child: const Text(
                "Right-To-Left",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(),
            TextButton(
              onPressed: () => Navigator.of(context).push((MaterialPageRoute(
                  builder: (context) => CustomShimmerGradientExamplePage()))),
              child: const Text(
                "Custom Shimmer Gradient",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
