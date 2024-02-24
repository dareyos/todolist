import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:todolist/services/add_task.dart';

class AddTaskAlertDialog extends StatefulWidget {
  const AddTaskAlertDialog({Key? key}) : super(key: key);

  @override
  State<AddTaskAlertDialog> createState() => _AddTaskAlertDialogState();
}

class _AddTaskAlertDialogState extends State<AddTaskAlertDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Новая заметка',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.brown),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width,
        child: _buildForm(),
      ),
      actions: [
        _buildButton(
          label: 'Отмена',
          onPressed: () => back(context),
          backgroundColor: Colors.grey,
        ),
        _buildButton(
          label: 'Сохранить',
          onPressed: () => save(context),
        ),
      ],
    );
  }

  void save(BuildContext context) {
    final taskName = taskNameController.text;
    final taskDesc = taskDescController.text;
    final taskTag = selectedValue;
    addTasks(taskName: taskName, taskDesc: taskDesc, taskTag: taskTag);
    Navigator.of(context, rootNavigator: true).pop();
  }

  void back(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  Widget _buildForm() {
    return Form(
      child: Column(
        children: <Widget>[
          _buildTextField(
            controller: taskNameController,
            hintText: 'Заметка',
            icon: const Icon(CupertinoIcons.square_list, color: Colors.brown),
          ),
          const SizedBox(height: 15),
          _buildTextField(
            controller: taskDescController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            hintText: 'Описание',
            icon: const Icon(CupertinoIcons.bubble_left_bubble_right, color: Colors.brown),
          ),
          const SizedBox(height: 15),
          _buildDropdown(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required Icon icon,
    TextInputType? keyboardType,
    int? maxLines,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 14),
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14),
        icon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Row(
      children: <Widget>[
        const Icon(CupertinoIcons.tag, color: Colors.brown),
        const SizedBox(width: 15.0),
        Expanded(
          child: DropdownButtonFormField2(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            isExpanded: true,
            hint: const Text(
              'Категория заметки',
              style: TextStyle(fontSize: 14),
            ),
            buttonHeight: 60,
            buttonPadding: const EdgeInsets.only(left: 20, right: 10),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            items: taskTags
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  selectedValue = value;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required void Function() onPressed,
    Color? backgroundColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      child: Text(label),
    );
  }
}
