import 'package:poll_dashboard/app/core/constants.dart';
import 'package:poll_dashboard/app/data/model/poll_model.dart';

class PollRemoteDataSource {
  static Future<PollModel> addPoll(PollModel poll) async {
    final result = await dio.post(
      '/admin/poll',
      data: poll.toMap(),
    );
    if (result.data['status'] == false) {
      return throw Exception(result.data['message']);
    }
    return PollModel.fromMap(result.data['data']);
  }

  static Future<List<PollModel>> getPendingPolls(int page) async {
    final result = await dio.get(
      '/polls/pending/$page',
    );
    if (result.data['status'] == false) {
      return throw Exception(result.data['message']);
    }

    return (result.data['data'] as List)
        .map((e) => PollModel.fromMap(e))
        .toList();
  }

  static Future<List<PollModel>> getCompletePolls(int page) async {
    final result = await dio.get(
      '/polls/complete/$page',
    );
    if (result.data['status'] == false) {
      return throw Exception(result.data['message']);
    }

    return (result.data['data'] as List)
        .map((e) => PollModel.fromMap(e))
        .toList();
  }
}
