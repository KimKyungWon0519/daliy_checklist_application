import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:presentation/constants/ui_constants.dart';

class Header extends SliverPersistentHeaderDelegate {
  final _headerSize = kToolbarHeight + 10;

  final DraggableScrollableController? draggableSheetController;
  final ScrollController? scrollController;
  final StateProvider<DateTime> selectedDateProvider;
  final VoidCallback? onPressedAddButton;

  const Header({
    this.draggableSheetController,
    this.scrollController,
    required this.selectedDateProvider,
    this.onPressedAddButton,
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
              selectedDateProvider: selectedDateProvider,
              onPressedAddButton: onPressedAddButton,
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => _headerSize;

  @override
  double get minExtent => _headerSize;

  @override
  bool shouldRebuild(covariant Header oldDelegate) {
    return true;
  }

  void onDragUpdate(final double offsetY, final double height) {
    double moveOffset = 1 - offsetY / height;

    moveOffset = moveOffset.clamp(taskListPanelMinSize, taskListPanelMaxSize);

    draggableSheetController?.jumpTo(moveOffset);
  }

  void onDragEnd() {
    if (draggableSheetController == null) return;

    final DraggableScrollableController controller = draggableSheetController!;
    final double medianSize = (taskListPanelMinSize + taskListPanelMaxSize) / 2,
        currentSize = controller.size;

    double movementSize = taskListPanelMinSize;

    if (currentSize >= medianSize) {
      movementSize = taskListPanelMaxSize;
    } else {
      movementSize = taskListPanelMinSize;
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
  final StateProvider<DateTime> selectedDateProvider;
  final VoidCallback? onPressedAddButton;

  const _Title({
    super.key,
    required this.selectedDateProvider,
    this.onPressedAddButton,
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
            onPressedAddButton: onPressedAddButton,
          ),
        ],
      ),
    );
  }
}

class _AddIconButton extends ConsumerWidget {
  final VoidCallback? onPressedAddButton;

  const _AddIconButton({
    super.key,
    this.onPressedAddButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: onPressedAddButton,
      icon: const Icon(Icons.add),
    );
  }
}
