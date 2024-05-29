import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_skeleton_plus/flutter_skeleton_plus.dart';

class CustomShimmerGradientExamplePage extends StatefulWidget {
  const CustomShimmerGradientExamplePage({super.key});

  @override
  _CustomShimmerGradientExamplePageState createState() =>
      _CustomShimmerGradientExamplePageState();
}

class _CustomShimmerGradientExamplePageState
    extends State<CustomShimmerGradientExamplePage> {
  bool _isLoading = true;

  final random = new Random();

  String randomText() => texts[random.nextInt(5)];

  final List<String> texts = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "Sed blandit purus in ornare facilisis.",
    "Pellentesque euismod lectus sit amet felis fringilla, ut tempor justo pulvinar.",
    "Nullam lobortis sem eu porta rhoncus.",
    "Cras sed eros a dolor viverra luctus id interdum ante.",
    "Mauris aliquet sapien rutrum enim dignissim tincidunt.",
  ];

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Shimmer Gradient"),
      ),
      body: Skeleton(
        duration: const Duration(milliseconds: 1500),
        shimmerGradient: const LinearGradient(
          colors: [
            Color(0xFFB9B9F5),
            Color(0xFF7E18D1),
            Color(0xFF7E18D1),
            Color(0xFFB9B9F5),
          ],
          stops: [
            0.0,
            0.3,
            1,
            1,
          ],
          begin: Alignment(-1, 0),
          end: Alignment(1, 0),
        ),
        isLoading: _isLoading,
        skeleton: _skeletonView(),
        child: _contentView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleLoading,
        child: Icon(
          _isLoading ? Icons.hourglass_full : Icons.hourglass_bottom,
        ),
      ),
    );
  }

  Widget _skeletonView() => SkeletonListView(
        item: SkeletonListTile(
          verticalSpacing: 12,
          leadingStyle: const SkeletonAvatarStyle(
              width: 64, height: 64, shape: BoxShape.circle),
          titleStyle: SkeletonLineStyle(
              height: 16,
              minLength: 200,
              // randomLength: true,
              borderRadius: BorderRadius.circular(4)),
          subtitleStyle: SkeletonLineStyle(
              height: 12,
              maxLength: 200,
              randomLength: true,
              borderRadius: BorderRadius.circular(4)),
          hasSubtitle: true,
        ),
      );

  Widget _contentView() => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/placeholder.png")),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    randomText(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 16),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    randomText(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ))
            ],
          ),
        ),
      );
}
