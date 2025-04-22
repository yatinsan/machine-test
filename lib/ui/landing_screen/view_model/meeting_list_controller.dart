import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meetings/data/model/meeting_date_model.dart'
    show MeetingDateModel;
import 'package:meetings/data/repo/meeting_repo.dart';
import 'package:meetings/data/services/api_services.dart';
import 'package:meetings/utils/api_error_handler.dart';
import 'package:meetings/utils/dio.dart';

class MeetingListController with ChangeNotifier {
  MeetingListController(){
    loadMeetings();
  }

  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;

  final meetingRepo = MeetingRepo(ApiServices(dio));

  get selectedMonth => _selectedMonth;

  get selectedYear => _selectedYear;

  set selectedMonth(value) {
    _selectedMonth = value;
    notifyListeners();
    loadMeetings();
  }

  set selectedYear(value) {
    _selectedYear = value;
    notifyListeners();
    loadMeetings();
  }

  bool _loading = false;
  bool _hasError = false;
  String? _errorMessage;
  List<MeetingDateModel>? meetingDateList;

  bool get loading => _loading;

  bool get hasError => _hasError;

  String? get errorMessage => _errorMessage;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  set hasError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  set errorMessage(String? value) {
    _errorMessage = value;
    notifyListeners();
  }

  clearErrorMessage() {
    errorMessage = null;
  }

  loadMeetings() async {
    clearErrorMessage();
    loading = true;

    try {
      final response = await meetingRepo.getAllMeetings(
        year: selectedYear,
        month: selectedMonth,
      );

      meetingDateList = response.data;
    } catch (e) {
      hasError = true;
      errorMessage = apiErrorHandler(e);
    }
    loading = false;
  }
}
