import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../domain/entities/task.dart';
import '../../../../viewmodels/home/home_viewmodel.dart';
import 'edit_task_note_box.dart';
import 'edit_task_buttons.dart';
import 'edit_card.dart';

class EditTaskForm extends StatefulWidget {
  final Task task;

  const EditTaskForm({super.key, required this.task});

  @override
  State<EditTaskForm> createState() => _EditTaskFormState();
}

class _EditTaskFormState extends State<EditTaskForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  DateTime? _selectedDate;
  String _selectedRoom = "Phòng khách";
  String? _deadlineError;

  final List<String> _rooms = [
    'Phòng khách',
    'Phòng ngủ',
    'Nhà bếp',
    'Nhà vệ sinh',
    'Ban công',
    'Phòng thờ'
  ];

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description ?? "");
    _selectedDate = widget.task.deadline?.toLocal();
    _selectedRoom = widget.task.room;
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeViewModel>();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const EditTaskNoteBox(),
            const SizedBox(height: 30),
            EditCard(
              title: "TÊN CÔNG VIỆC *",
              child: TextFormField(
                controller: _titleController,
                validator: (value) =>
                value == null || value.isEmpty
                    ? "Vui lòng nhập tên công việc"
                    : null,
                decoration: inputDecoration(),
              ),
            ),
            const SizedBox(height: 16),

            EditCard(
              title: "MÔ TẢ CHI TIẾT",
              child: TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: inputDecoration(),
              ),
            ),
            const SizedBox(height: 16),

            EditCard(
              title: "KHU VỰC *",
              icon: Icons.location_on,
              child: DropdownButtonFormField<String>(
                value: _selectedRoom,
                items: _rooms
                    .map((room) => DropdownMenuItem(
                  value: room,
                  child: Text(room),
                ))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedRoom = value!),
                decoration: inputDecoration(),
              ),
            ),
            const SizedBox(height: 16),

            EditCard(
              title: "HẠN HOÀN THÀNH *",
              icon: Icons.calendar_today,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: _pickDate,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F3F6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            _selectedDate != null
                                ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year} "
                                "${_selectedDate!.hour.toString().padLeft(2, '0')}:${_selectedDate!.minute.toString().padLeft(2, '0')}"
                                : "Chọn ngày & giờ",
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_deadlineError != null) ...[
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        _deadlineError!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 24),


            EditTaskButtons(
              onCancel: () => Navigator.pop(context),
              onSave: () async {
                setState(() => _deadlineError = null);

                if (!_formKey.currentState!.validate()) return;

                if (_selectedDate == null) {
                  setState(() => _deadlineError = "Vui lòng chọn deadline");
                  return;
                }

                if (_selectedDate!.isBefore(DateTime.now())) {
                  setState(() => _deadlineError = "Deadline không được trong quá khứ");
                  return;
                }

                final updatedTask = widget.task.copyWith(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  room: _selectedRoom,
                  deadline: _selectedDate,
                );

                await vm.update(updatedTask);

                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Cập nhật công việc thành công"),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );

                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF1F3F6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    );
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (pickedDate == null) return;

    if (!mounted) return;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate ?? DateTime.now()),
    );

    setState(() {
      _selectedDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime?.hour ?? 0,
        pickedTime?.minute ?? 0,
      );
    });
  }
}