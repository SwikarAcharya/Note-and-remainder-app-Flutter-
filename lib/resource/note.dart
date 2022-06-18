import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  Note(this.notes, this.selectedColor, this.wantRem, this.notificationDate);

  @HiveField(0)
  late String notes;

  @HiveField(1)
  late int selectedColor;

  @HiveField(2)
  late bool wantRem;

  @HiveField(3)
  late int notificationDate;
}
