import 'package:flutter/material.dart';
import 'package:flutter_skeleton_plus/flutter_skeleton_plus.dart';

class ListViewExample1Page extends StatefulWidget {
  const ListViewExample1Page({super.key});

  @override
  _ListViewExample1PageState createState() => _ListViewExample1PageState();
}

class _ListViewExample1PageState extends State<ListViewExample1Page> {
  bool _isLoading = true;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List View (Default)"),
      ),
      body: Skeleton(
        isLoading: _isLoading,
        skeleton: const SkeletonListView(),
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

  Widget _contentView() => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Image.asset(
                "assets/placeholder.png",
                width: 48,
                height: 48,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lorem ipsum dolor sit amet.",
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text("Lorem ipsum dolor sit."),
                ],
              ))
            ],
          ),
        ),
      );
}
//  ListView.builder(
//         physics: NeverScrollableScrollPhysics(),
//         itemBuilder: (context, index) => Container(),
//       )