import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Header extends SliverPersistentHeaderDelegate {
  final DraggableScrollableController? draggableSheetController;
  final ScrollController? scrollController;
  final Function(DateTime)? onClickAddButton;
  final StateProvider<DateTime> selectedDateProvider;

  const Header({
    this.draggableSheetController,
    this.scrollController,
    this.onClickAddButton,
    required this.selectedDateProvider,
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
      child: SizedBox(
        height: maxExtent,
        width: double.infinity,
        child: Column(
          children: [
            const _Handle(),
            _Title(
              onClickAddButton: onClickAddButton,
              selectedDateProvider: selectedDateProvider,
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

class _Title extends ConsumerWidget {
  final Function(DateTime)? onClickAddButton;
  final StateProvider<DateTime> selectedDateProvider;

  const _Title({
    super.key,
    this.onClickAddButton,
    required this.selectedDateProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime selectedDateTime = ref.watch(selectedDateProvider);

    return Theme(
      data: ThemeData(useMaterial3: false),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(DateFormat('yyyy/MM/dd').format(selectedDateTime)),
        actions: [
          _AddIconButton(
            onClickAddButton: onClickAddButton,
            selectedDateProvider: selectedDateProvider,
          ),
        ],
      ),
    );
  }
}

class _AddIconButton extends ConsumerWidget {
  final Function(DateTime)? onClickAddButton;
  final StateProvider<DateTime> selectedDateProvider;

  const _AddIconButton({
    super.key,
    this.onClickAddButton,
    required this.selectedDateProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        DateTime selectedDate = ref.read(selectedDateProvider);

        onClickAddButton?.call(selectedDate);
      },
      icon: const Icon(Icons.add),
    );
  }
}
