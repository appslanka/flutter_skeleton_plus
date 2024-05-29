import 'package:flutter/material.dart';
import 'package:flutter_skeleton_plus/flutter_skeleton_plus.dart';

class SkeletonThemeExamplePage extends StatefulWidget {
  const SkeletonThemeExamplePage({super.key});

  @override
  _SkeletonThemeExamplePageState createState() =>
      _SkeletonThemeExamplePageState();
}

class _SkeletonThemeExamplePageState extends State<SkeletonThemeExamplePage> {
  bool _isLoading = true;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC7E5EE),
      appBar: AppBar(
        title: const Text("SkeletonTheme"),
      ),
      body: SkeletonTheme(
        themeMode: ThemeMode.light,
        shimmerGradient: const LinearGradient(
          colors: [
            Color(0xFF67C5E2),
            Color(0xFF18A6D1),
            Color(0xFF67C5E2),
          ],
          stops: [
            0.1,
            0.5,
            0.9,
          ],
        ),
        child: Skeleton(
          duration: const Duration(milliseconds: 800),
          isLoading: _isLoading,
          skeleton: SkeletonListView(
              item: SkeletonListTile(
            contentSpacing: 24,
            padding: const EdgeInsets.symmetric(vertical: 16),
            leadingStyle: const SkeletonAvatarStyle(width: 32, height: 24),
            titleStyle:
                SkeletonLineStyle(borderRadius: BorderRadius.circular(4)),
            hasSubtitle: false,
          )),
          child: _contentView(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleLoading,
        child: Icon(
          _isLoading ? Icons.hourglass_full : Icons.hourglass_bottom,
        ),
      ),
    );
  }

  Widget _contentView() => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              const Icon(
                Icons.panorama,
                size: 28,
              ),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: Text(
                  "Lorem ipsum dolor sit amet.",
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      );
}
