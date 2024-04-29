import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/presenters/viewmodels/home_viewmodel.dart';

class Header extends SliverPersistentHeaderDelegate {
  final DraggableScrollableController? draggableSheetController;
  final ScrollController? scrollController;
  final VoidCallback? onClickAddButton;

  const Header({
    this.draggableSheetController,
    this.scrollController,
    this.onClickAddButton,
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
            _Title(onClickAddButton: onClickAddButton),
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
  final VoidCallback? onClickAddButton;

  const _Title({
    super.key,
    this.onClickAddButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeViewModel homeViewModel = viewModelProvider<HomeViewModel>();
    final DateTime selectedDateTime =
        ref.watch(homeViewModel.selectedDateProvider);

    return Theme(
      data: ThemeData(useMaterial3: false),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(DateFormat('yyyy/MM/dd').format(selectedDateTime)),
        actions: [
          _AddIconButton(onClickAddButton: onClickAddButton),
        ],
      ),
    );
  }
}

class _AddIconButton extends StatelessWidget {
  final VoidCallback? onClickAddButton;

  const _AddIconButton({
    super.key,
    this.onClickAddButton,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onClickAddButton,
      icon: const Icon(Icons.add),
    );
  }
}
