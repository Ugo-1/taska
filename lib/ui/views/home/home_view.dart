import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:taska/ui/views/home/home_compact_view.dart';
import 'package:taska/ui/views/home/home_medium_view.dart';
import 'package:taska/ui/widgets/common/screen_layout.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return ScreenLayout(
      compactLayout: (_) => const HomeCompactView(),
      mediumLayout: (_) => const HomeMediumView(),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}