import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/ui/widgets/common/primary_button/primary_button.dart';

import 'in_progress_viewmodel.dart';

class InProgressView extends StackedView<InProgressViewModel> {
  final int id;
  const InProgressView({Key? key, required this.id}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    InProgressViewModel viewModel,
    Widget? child,
  ) {
    final (Color?, Color?) taskColor = viewModel.task.color.getColors(context);
    final List<Color> gradientColor = context.isDarkMode()
        ? [
            taskColor.$1!.withOpacity(0.45),
            taskColor.$1!.withOpacity(0.5),
            taskColor.$1!.withOpacity(0.65),
            taskColor.$1!.withOpacity(0.7),
            taskColor.$1!.withOpacity(0.85),
            taskColor.$1!.withOpacity(0.9),
            taskColor.$1!,
          ]
        : [
            taskColor.$1!,
            taskColor.$1!.withOpacity(0.9),
            taskColor.$1!.withOpacity(0.85),
            taskColor.$1!.withOpacity(0.7),
            taskColor.$1!.withOpacity(0.65),
            taskColor.$1!.withOpacity(0.5),
            taskColor.$1!.withOpacity(0.45),
          ];
    return Scaffold(
      body: MediaQuery.withNoTextScaling(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: const Alignment(0.8, 1),
              colors: gradientColor,
              tileMode: TileMode.mirror,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: AnimatedScale(
              scale: viewModel.scale,
              duration: viewModel.duration,
              curve: Curves.easeInOut,
              child: DefaultTextStyle.merge(
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(flex: 5),
                    Text(
                      viewModel.task.taskName,
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: taskColor.$2,
                      ),
                    ),
                    const Spacer(flex: 2),
                    Text(
                      viewModel.task.description,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: taskColor.$2,
                      ),
                    ),
                    const Spacer(flex: 5),
                    Text(
                      viewModel.task.startTime.toLocaleTime(),
                      style: context.textTheme.displaySmall?.copyWith(
                        color: taskColor.$2,
                      ),
                    ),
                    const Spacer(flex: 3),
                    Text(
                      'to',
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: taskColor.$2,
                      ),
                    ),
                    const Spacer(flex: 3),
                    Text(
                      viewModel.task.endTime.toLocaleTime(),
                      style: context.textTheme.displaySmall?.copyWith(
                        color: taskColor.$2,
                      ),
                    ),
                    const Spacer(flex: 5),
                    LinearProgressIndicator(
                      minHeight: 20,
                      value: viewModel.task.getTaskProgress(),
                      valueColor: AlwaysStoppedAnimation(context.colors.onBackground),
                      backgroundColor: context.colors.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    const Spacer(flex: 6),
                    FractionallySizedBox(
                      widthFactor: .8,
                      child: PrimaryButton.outline(
                        onTap: viewModel.back,
                        border: Border.all(
                          color: taskColor.$2!,
                        ),
                        buttonText: 'Dismiss',
                        borderRadius: 30,
                        maxLines: 1,
                        buttonTextStyle: context.textTheme.bodyMedium?.copyWith(
                          color: taskColor.$2,
                        ),
                      ),
                    ),
                    const Spacer(flex: 5),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  InProgressViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      InProgressViewModel(id: id);
}
