import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poll_dashboard/app/core/constants.dart';
import 'package:poll_dashboard/app/data/local/auth_local_data_source.dart';
import 'package:poll_dashboard/app/data/model/poll_model.dart';
import 'package:poll_dashboard/app/data/remote/poll_remote_data_source.dart';

class HomeController extends GetxController {
  final _isAddingPoll = Rx(false);
  final _addingPoll = Rxn<PollModel>();
  final _polls = RxList<PollModel>();
  final _isPendingPolls = RxBool(true);

  bool get isAddingPoll => _isAddingPoll.value;

  PollModel? get addingPoll => _addingPoll.value;

  List<PollModel> get polls => _polls;

  bool get isPendingPolls => _isPendingPolls.value;

  int _currentPage = 1;

  bool isNoMoreData = false;
  bool isFetchingData = false;
  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onClose() {
    scrollController.removeListener(_loadMore);
    scrollController.dispose();
    super.onClose();
  }

  void getData() async {
    if (addingPoll == null) {
      _addingPoll.value = PollModel(
        id: '',
        titleEn: '',
        titleUr: '',
        subTitleEn: '',
        subTitleUr: '',
        duration: 0,
        options: [],
      );
      addOption();
      addOption();
      dio.options.headers['token'] = AuthLocaleDataSource.getToken();
      await _getPolls();
      scrollController.addListener(_loadMore);
    }
  }

  void _loadMore() {
    if (!isFetchingData &&
        !isNoMoreData &&
        scrollController.position.extentAfter < 300) {
      _currentPage++;
      _getPolls();
    }
  }

  Future<void> onRefresh() async {
    _currentPage = 1;
    await _getPolls();
  }

  Future<void> _getPolls() async {
    isFetchingData = true;
    try {
      _polls.value = await (isPendingPolls
          ? PollRemoteDataSource.getPendingPolls(_currentPage)
          : PollRemoteDataSource.getCompletePolls(_currentPage));
      print(polls.length);
      isNoMoreData = polls.length < 10;
    } catch (e) {
      if (_currentPage > 1) _currentPage--;
      print(e);
    }
    isFetchingData = false;
  }

  void onPollsTypeChange(bool? type) {
    _currentPage = 1;
    _isPendingPolls.value = type == true ? true : false;
    _getPolls();
  }

  void addOption() {
    _addingPoll.value!.options.add({
      'en': '',
      'ur': '',
    });
    _addingPoll.refresh();
  }

  void removeOption() {
    if (addingPoll!.options.length > 2) {
      _addingPoll.value!.options
          .removeAt(_addingPoll.value!.options.length - 1);
      _addingPoll.refresh();
    }
  }

  void addPoll() async {
    if (addingPoll!.titleEn.isEmpty ||
        addingPoll!.titleUr.isEmpty ||
        addingPoll!.subTitleEn.isEmpty ||
        addingPoll!.subTitleUr.isEmpty ||
        addingPoll!.options.first['en']!.isEmpty ||
        addingPoll!.options.first['ur']!.isEmpty ||
        addingPoll!.options[1]['en']!.isEmpty ||
        addingPoll!.options[1]['ur']!.isEmpty ||
        addingPoll!.duration == 0) {
      _showSnackBarError('Please Fill The Fields First.');
    } else {
      _isAddingPoll.value = true;
      try {
        await PollRemoteDataSource.addPoll(addingPoll!);
        Get.snackbar('Success', 'Poll Added.',
            colorText: Colors.white,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP);
      } catch (e) {
        _showSnackBarError(e.toString());
      }
      _isAddingPoll.value = false;
    }
  }

  void _showSnackBarError(String error) {
    Get.snackbar('Error', error,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP);
  }
}
