import 'package:flutter/material.dart';

class Header extends SliverPersistentHeaderDelegate {
  final DraggableScrollableController? draggableSheetController;
  final ScrollController? scrollController;

  const Header({
    this.draggableSheetController,
    this.scrollController,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        double height = MediaQuery.sizeOf(context).height;

        onDragUpdate(details.globalPosition.dy, height);
      },
      onVerticalDragEnd: (details) {
        onDragEnd();
      },
      child: Container(
        height: maxExtent,
        width: double.infinity,
        color: Colors.teal[100],
        child: const Column(
          children: [
            _Handle(),
            _Title(),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => kToolbarHeight + 10;

  @override
  double get minExtent => kToolbarHeight + 10;

  @override
  bool shouldRebuild(covariant Header oldDelegate) {
    return true;
  }

  void onDragUpdate(double offsetY, double height) {
    double moveOffset = 1 - offsetY / height;

    moveOffset = moveOffset.clamp(0.25, 1);

    draggableSheetController?.jumpTo(moveOffset);
  }

  void onDragEnd() {
    if (draggableSheetController == null) return;

    final DraggableScrollableController controller = draggableSheetController!;
    final double medianSize = (0.25 + 1) / 2, currentSize = controller.size;

    double movementSize = 0.25;

    if (currentSize >= medianSize) {
      movementSize = 1;
    } else {
      movementSize = 0.25;
      scrollController?.jumpTo(0);
    }

    controller.animateTo(movementSize,
        duration: Durations.medium1, curve: Curves.ease);
  }
}

class _Handle extends StatelessWidget {
  const _Handle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width / 4),
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white,
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text('2024/05/19'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
