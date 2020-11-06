import 'package:emergencyhealthcare/app/locator.dart';
import 'package:emergencyhealthcare/models/hospital.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SearchViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  List<Hospital> _hospitals = Hospital.hospitals;
  List<Hospital> get hospitals => _hospitals;
  List<Hospital> _searchResult = [];
  List<Hospital> get searchResult => _searchResult;

  String _query;
  String get query => _query;
  set query(value) {
    _query = value;
    onSearchTextChanged(_query);
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      notifyListeners();
      return;
    }

    _hospitals.forEach((hospitals) {
      if (hospitals.name.toLowerCase().contains(text.toLowerCase()) ||
          hospitals.location.toLowerCase().contains(text.toLowerCase()))
        _searchResult.add(hospitals);
      notifyListeners();
    });
  }

  void getAdmit(String hospitalName) async {
    var response = await _dialogService.showConfirmationDialog(
      barrierDismissible: false,
      title: 'Admit to',
      description: '$hospitalName ?',
      cancelTitle: 'Cancel',
      confirmationTitle: 'Confirm',
    );

    if (response.confirmed) {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('your channel id', 'your channel name',
              'your channel description',
              importance: Importance.max,
              priority: Priority.high,
              showWhen: false);
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
          0,
          'Admission Complete',
          'Successfully admitted to $hospitalName. Stay safe and take care of yourself.',
          platformChannelSpecifics,
          payload: 'item x');
    }
  }

  onPop() {
    _navigationService.back();
  }
}
