import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poll_dashboard/app/data/model/poll_model.dart';
import 'package:poll_dashboard/app/modules/home/controllers/home_controller.dart';

class PollsScreen extends StatelessWidget {
  PollsScreen({Key? key}) : super(key: key);

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        onRefresh: controller.onRefresh,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: DropdownButton<bool>(
                  value: controller.isPendingPolls,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: true,
                      child: Text('Pending Polls'),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Text('Complete Polls'),
                    ),
                  ],
                  onChanged: controller.onPollsTypeChange),
            ),
            Expanded(
              child: ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.polls.length,
                  itemBuilder: (_, index) => _result(controller.polls[index])),
            )
          ],
        ),
      ),
    );
  }

  Widget _result(PollModel poll) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Get.theme.scaffoldBackgroundColor.withOpacity(.4),
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text('This is a Test Poll',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
            ),
            SizedBox(
              height: 10,
            ),
            _buildAnswerContainer('Answer No. 1', 80),
            _buildAnswerContainer('Answer No. 2', 20),
            _buildAnswerContainer('Answer No. 3', 10),
            _buildAnswerContainer('Answer No. 4', 45),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerContainer(String answer, double percentage) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          Container(
            width: (Get.width - 45) * (percentage / 100),
            height: 45,
            decoration: BoxDecoration(
              color: Get.theme.primaryColor.withOpacity(percentage / 100),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Text(
                  '$percentage%',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  answer,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
