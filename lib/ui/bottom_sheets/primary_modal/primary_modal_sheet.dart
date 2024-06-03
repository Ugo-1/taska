import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/models/primary_modal_model.dart';
import 'package:taska/ui/widgets/common/primary_button/primary_button.dart';
import 'package:taska/ui/widgets/common/sizes.dart';
import 'package:taska/utils/theme.dart';

import 'primary_modal_sheet_model.dart';

class PrimaryModalSheet extends StackedView<PrimaryModalSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const PrimaryModalSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PrimaryModalSheetModel viewModel,
    Widget? child,
  ) {
    assert(request.data is PrimaryModalModel);
    final PrimaryModalModel modalModel = request.data;
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(20),
      ),
      constraints: BoxConstraints(
        maxHeight: context.heightPercent(50),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:
                    (modalModel.modelType == PrimaryModelEnum.permissionDenied)
                        ? context.colors.errorContainer
                        : context.colors.primaryContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  modalModel.icon,
                  size: 30,
                  color: (modalModel.modelType ==
                          PrimaryModelEnum.permissionDenied)
                      ? context.colors.onErrorContainer
                      : context.colors.onPrimaryContainer,
                ),
              ),
            ),
            const HSize(20),
            Text(
              modalModel.title,
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.copyWith(
                fontFamily: kFConstantia,
                fontWeight: FontWeight.w500,
                color: context.colors.onSurfaceVariant,
              ),
            ),
            const HSize(10),
            Text(
              modalModel.description,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.outline,
              ),
            ),
            if (modalModel.mainButtonTitle != null)
              PrimaryButton(
                width: double.maxFinite,
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                onTap: () => completer?.call(SheetResponse(confirmed: true)),
                buttonText: modalModel.mainButtonTitle!,
              ),
            if (modalModel.secondaryButtonTitle != null)
              PrimaryButton.outline(
                width: double.maxFinite,
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                onTap: () => completer?.call(SheetResponse(confirmed: false)),
                buttonText: modalModel.secondaryButtonTitle!,
              ),
          ],
        ),
      ),
    );
  }

  @override
  PrimaryModalSheetModel viewModelBuilder(BuildContext context) =>
      PrimaryModalSheetModel();
}
