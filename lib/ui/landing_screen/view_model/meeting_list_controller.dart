import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meetings/data/model/meeting_date_model.dart'
    show MeetingDateModel;
import 'package:meetings/data/model/meeting_item_model.dart';
import 'package:meetings/data/repo/meeting_repo.dart';
import 'package:meetings/data/services/api_services.dart';
import 'package:meetings/utils/api_error_handler.dart';
import 'package:meetings/utils/dio.dart';

class MeetingListController with ChangeNotifier {
  MeetingListController() {
    loadMeetings();
  }

  DateTime _calenderSelectedDate = DateTime.now();

  DateTime get calenderSelectedDate => DateTime(
    _calenderSelectedDate.year,
    _calenderSelectedDate.month,
    _calenderSelectedDate.day,
  );

  set calenderSelectedDate(DateTime value) {
    _calenderSelectedDate = value;
    notifyListeners();
  }

  final meetingRepo = MeetingRepo(ApiServices(dio));

  get selectedMonth => _calenderSelectedDate.month;

  get selectedYear => _calenderSelectedDate.year;

  set selectedMonth(value) {
    _calenderSelectedDate = _calenderSelectedDate.copyWith(month: value);
    notifyListeners();
    loadMeetings();
  }

  set selectedYear(value) {
    _calenderSelectedDate = _calenderSelectedDate.copyWith(year: value);
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

      // meetingDateList = [
      //   MeetingDateModel(date: "2025-04-04", items: [MeetingItemModel(
      //     id: "asdf",
      //     title: "hww locad",
      //     time: "8:00 AM"
      //
      //   )]),
      // ];
    } catch (e) {
      hasError = true;
      errorMessage = apiErrorHandler(e);
    }
    loading = false;
  }
}
