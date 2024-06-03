import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:taska/app/app.bottomsheets.dart';
import 'package:taska/app/app.locator.dart';
import 'package:taska/models/primary_modal_model.dart';
import 'package:taska/services/notification_service.dart';
import 'package:app_settings/app_settings.dart';

class PermissionService {
  final NotificationService _notificationService =
      locator<NotificationService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();

  Future<int> _sdkAndroidVersion() async {
    final AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.version.sdkInt;
  }

  Future<bool> requestNotificationPermission() async {
    // If platform is android and an sdk version lower than 33 then permission
    // is granted
    if (Platform.isAndroid && await _sdkAndroidVersion() < 33) return true;
    final bool requestPermission = await _requestPluginNotificationPermission();
    if (requestPermission) {
      return true;
    } else {
      final response = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.primaryModal,
        data: const PrimaryModalModel(
          icon: Icons.info_rounded,
          title: 'Tasks Updates Missed',
          description: "You'll miss task reminders without notifications",
          modelType: PrimaryModelEnum.permissionDenied,
          mainButtonTitle: 'Enable Notifications',
          secondaryButtonTitle: 'Cancel',
        ),
      );
      if (response?.confirmed == true) {
        await AppSettings.openAppSettings(type: AppSettingsType.notification);
        return await _requestPluginNotificationPermission();
      }
      return false;
    }
  }

  Future<bool> _requestPluginNotificationPermission() async {
    final bool isIOS = Platform.isIOS;
    if (isIOS) {
      return await _notificationService.flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(
                alert: true,
                badge: true,
                sound: true,
              ) ??
          false;
    } else {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notificationService.flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>();
      final List<bool> androidPermission = [];
      androidPermission.add(
          await androidImplementation?.requestNotificationsPermission() ??
              false);
      androidPermission.add(
          await androidImplementation?.requestExactAlarmsPermission() ?? false);
      return androidPermission.isNotEmpty &&
          androidPermission.every((element) => element == true);
    }
  }
}
