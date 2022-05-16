import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poll_dashboard/app/core/widget/CustomTextFormField.dart';
import 'package:poll_dashboard/app/core/widget/loading_button.dart';
import 'package:poll_dashboard/app/modules/home/controllers/home_controller.dart';

class AddPollScreen extends StatelessWidget {
  final HomeController controller;

  const AddPollScreen(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Obx(() => Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormFiled(
                    label: 'Title (English)',
                    onChange: (v) => controller.addingPoll!.titleEn = v),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormFiled(
                    label: 'Title (Urdu)',
                    onChange: (v) => controller.addingPoll!.titleUr = v),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormFiled(
                    label: 'Sub Title (English)',
                    onChange: (v) => controller.addingPoll!.subTitleEn = v),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormFiled(
                    label: 'Sub Title (Urdu)',
                    onChange: (v) => controller.addingPoll!.subTitleUr = v),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormFiled(
                    label: 'Duration In Hours',
                    keyboardType: TextInputType.number,
                    onChange: (v) =>
                        controller.addingPoll!.duration = int.tryParse(v) ?? 0),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: controller.addOption,
                    child: const Text('Add Option')),
                ...List.generate(
                  controller.addingPoll!.options.length,
                  (index) => _buildOption(index),
                ),
                const SizedBox(
                  height: 30,
                ),
                LoadingButton(
                    text: 'Add Poll',
                    onClick: controller.addPoll,
                    isLoading: controller.isAddingPoll),
                const SizedBox(
                  height: 30,
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildOption(int index) {
    return Column(
      children: [
        CustomTextFormFiled(
            label: 'Option Title (English)',
            onChange: (v) => controller.addingPoll!.options[index]['en'] = v),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormFiled(
            label: 'Option Title (Urdu)',
            onChange: (v) => controller.addingPoll!.options[index]['ur'] = v),
        if (index > 1)
          IconButton(
            onPressed: controller.removeOption,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(),
        ),
      ],
    );
  }
}
