import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:poll_dashboard/app/modules/home/views/add_poll_screen.dart';
import 'package:poll_dashboard/app/modules/home/views/polls_screen.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Poll Dashboard'),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.white,
            tabs: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Add Poll'),
              ),
              Text('Polls'),
              Text('Users'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AddPollScreen(controller),
            PollsScreen(),
            Text('Users'),
          ],
        ),
      ),
    );
  }
}
