import 'package:hive_flutter/hive_flutter.dart';
import 'package:remainder_app_project/resource/note.dart';

const NOTES = '_notes';

class HiveManager {
  static initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteAdapter());
    return true;
  }

  static onAddNotes(
      {required String notes,
      required bool notification,
      required int selectedColor,
      required int date}) async {
    try {
      await Hive.openBox<Note>(NOTES);
      Box<Note> addNote = Hive.box<Note>(NOTES);
      await addNote.add(Note(notes, selectedColor, notification, date));
    } catch (e) {
      print(e);
    } finally {
      Hive.close();
      print('added');
      return true;
    }
  }

  static onGetNotes() async {
    try {
      await Hive.openBox<Note>(NOTES);
      final box = await Hive.openBox<Note>(NOTES);
      List note = <Note>[];
      note = box.values.toList();
      return note;
    } catch (e) {
      print(e);
    } finally {
      Hive.close();
    }
  }
}
