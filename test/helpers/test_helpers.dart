import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:taska/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:taska/services/preference_storage_service.dart';
import 'package:taska/services/task_service.dart';
import 'package:taska/services/notification_service.dart';
import 'package:taska/services/permission_service.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<PreferenceStorageService>(
      onMissingStub: OnMissingStub.returnDefault),
  MockSpec<TaskService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<NotificationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<PermissionService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterPreferenceStorageService();
  getAndRegisterTaskService();
  getAndRegisterNotificationService();
  getAndRegisterPermissionService();
// @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

MockPreferenceStorageService getAndRegisterPreferenceStorageService() {
  _removeRegistrationIfExists<PreferenceStorageService>();
  final service = MockPreferenceStorageService();
  locator.registerSingleton<PreferenceStorageService>(service);
  return service;
}

MockTaskService getAndRegisterTaskService() {
  _removeRegistrationIfExists<TaskService>();
  final service = MockTaskService();
  locator.registerSingleton<TaskService>(service);
  return service;
}

MockNotificationService getAndRegisterNotificationService() {
  _removeRegistrationIfExists<NotificationService>();
  final service = MockNotificationService();
  locator.registerSingleton<NotificationService>(service);
  return service;
}

MockPermissionService getAndRegisterPermissionService() {
  _removeRegistrationIfExists<PermissionService>();
  final service = MockPermissionService();
  locator.registerSingleton<PermissionService>(service);
  return service;
}
// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
