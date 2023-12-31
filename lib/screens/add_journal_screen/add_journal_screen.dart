import 'package:flutter/material.dart';
import '../../helpers/weekday.dart';
import '../../models/journal.dart';
import '../../services/journal_service.dart';

class AddJournalScreen extends StatelessWidget {
  final Journal journal;
  final bool isEditing;

  AddJournalScreen({Key? key, required this.journal, required this.isEditing})
      : super(key: key);

  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _contentController.text = journal.content;
    return Scaffold(
      appBar: AppBar(
        title: Text(WeekDay(journal.createdAt).toString()),
        actions: [
          IconButton(
            onPressed: () {
              registerJournal(context);
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          controller: _contentController,
          keyboardType: TextInputType.multiline,
          style: const TextStyle(fontSize: 24),
          expands: true,
          maxLines: null,
          minLines: null,
        ),
      ),
    );
  }

  registerJournal(BuildContext context) async {
    JournalService service = JournalService();
    journal.content = _contentController.text;
    if (isEditing) {
      service.register(journal).then((value) {
        Navigator.pop(context, value);
      });
    } else {
      service.edit(journal.id, journal).then((value) {
        Navigator.pop(context, value);
      });
    }
  }



}

enum DisposeStatus { exit, error, success }
