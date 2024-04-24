import 'package:flutter/material.dart';

class TaskSheet extends StatefulWidget {
  const TaskSheet({super.key});

  @override
  State<TaskSheet> createState() => _TaskSheetState();
}

class _TaskSheetState extends State<TaskSheet> {
  DraggableScrollableController _controller = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _controller,
      initialChildSize: 0.25,
      minChildSize: 0.25,
      maxChildSize: 1,
      snap: true,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.teal[100],
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: _TaskPanel(
            controller: _controller,
            scrollController: scrollController,
          ),
        );
      },
    );
  }
}

class _TaskPanel extends StatelessWidget {
  final DraggableScrollableController? controller;
  final ScrollController? scrollController;

  const _TaskPanel({
    super.key,
    this.controller,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverPersistentHeader(
          delegate: Header(
            controller: controller,
            scrollController: scrollController,
          ),
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return CheckboxListTile(
                title: Text('$index'),
                value: false,
                onChanged: (value) {},
              );
            },
            childCount: 100,
          ),
        ),
      ],
    );
  }
}

class Header extends SliverPersistentHeaderDelegate {
  final DraggableScrollableController? controller;
  final ScrollController? scrollController;

  const Header({
    this.controller,
    this.scrollController,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        print((1 -
                (details.globalPosition / MediaQuery.sizeOf(context).height).dy)
            .clamp(0.25, 1));
        controller?.jumpTo((1 -
                (details.globalPosition / MediaQuery.sizeOf(context).height).dy)
            .clamp(0.25, 1));
      },
      onVerticalDragEnd: (details) {
        if (controller == null) return;

        if (controller!.size > (0.25 + 1) / 2) {
          controller!
              .animateTo(1, duration: Durations.medium1, curve: Curves.ease);
        } else if (controller!.size <= (0.25 + 1) / 2) {
          controller!
              .animateTo(0.25, duration: Durations.medium1, curve: Curves.ease);
          scrollController?.jumpTo(0);
        }
      },
      child: Container(
        height: maxExtent,
        width: double.infinity,
        color: Colors.teal[100],
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width / 4),
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
            ),
            Theme(
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
            ),
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
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
