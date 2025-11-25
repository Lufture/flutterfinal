// lib/widgets/shimmer_list.dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  final int itemCount;
  const ShimmerList({super.key, this.itemCount = 6});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (_, i) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListTile(
          leading: Container(height: 48, width: 48, color: Colors.white),
          title: Container(height: 16, color: Colors.white),
          subtitle: Container(height: 12, margin: const EdgeInsets.only(top: 8), color: Colors.white),
        ),
      ),
    );
  }
}
