import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/constants/ui_constants.dart';
import 'package:presentation/pages/home_page/local_widgets/row_panel.dart';
import 'package:presentation/pages/home_page/local_widgets/stack_panel.dart';
import 'package:presentation/presenters/viewmodels/home_viewmodel.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'local_widgets/custom_calendar.dart';
import 'local_widgets/task_sheet.dart';

class HomePage extends ConsumerStatefulWidget {
  final Future<void> Function(DateTime)? pageNavigator;

  const HomePage({
    super.key,
    this.pageNavigator,
  });

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = viewModelProvider<HomeViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final DateTime nowDate = DateTime.now();

      _viewModel.getTaskOnSelectedDate(nowDate).then((value) {
        ref
            .read(_viewModel.selectedDateTasksProvider.notifier)
            .update((state) => value);
      });

      _viewModel.getAllTasks().then((value) => ref
          .read(_viewModel.allTasksProvider.notifier)
          .update((state) => value));
    });
  }

  @override
  Widget build(BuildContext context) {
    RowPanel rowPanel = RowPanel(
      selectedDateProvider: _viewModel.selectedDateProvider,
      allTaskProvider: _viewModel.allTasksProvider,
      selectedDateTasksProvider: _viewModel.selectedDateTasksProvider,
      onPressedDay: (dateTime) => _onPressedDay(dateTime),
      onPressedAddButton: _onPressedAddButton,
    );

    StackPanel stackPanel = StackPanel(
      selectedDateProvider: _viewModel.selectedDateProvider,
      allTasksProvider: _viewModel.allTasksProvider,
      selectedDateTasksProvider: _viewModel.selectedDateTasksProvider,
      onPressedDay: (dateTime) => _onPressedDay(dateTime),
      onPressedAddButton: _onPressedAddButton,
    );

    return Scaffold(
      body: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if (sizingInformation.deviceScreenType ==
                DeviceScreenType.desktop) {
              return rowPanel;
            }

            return OrientationLayoutBuilder(
              portrait: (context) {
                return stackPanel;
              },
              landscape: (context) {
                return rowPanel;
              },
            );
          },
        ),
      ),
    );
  }

  void _onPressedAddButton() {
    final DateTime selectedDate = ref.read(_viewModel.selectedDateProvider);

    if (widget.pageNavigator != null) {
      widget.pageNavigator!(selectedDate).then((value) async {
        await _viewModel.getTaskOnSelectedDate(selectedDate).then((value) => ref
            .read(_viewModel.selectedDateTasksProvider.notifier)
            .update((state) => value));

        await _viewModel.getAllTasks().then((value) => ref
            .read(_viewModel.allTasksProvider.notifier)
            .update((state) => value));
      });
    }
  }

  Future<void> _onPressedDay(DateTime selectedDateTime) async {
    ref
        .read(_viewModel.selectedDateProvider.notifier)
        .update((state) => selectedDateTime);

    List<Task> tasks = await _viewModel.getTaskOnSelectedDate(selectedDateTime);

    ref
        .read(_viewModel.selectedDateTasksProvider.notifier)
        .update((state) => tasks);
  }
}
