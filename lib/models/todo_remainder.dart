// TODO: convertir en adapter de Hive y utilizar build runner para generar el adapter
import 'package:hive/hive.dart';
part 'todo_remainder.g.dart';//pon esto, guarda, y ejecuta biuld runnen (aunque marque error esta parte)


@HiveType(typeId: 0)//tipo de dato
class TodoRemainder {
  @HiveField(0)//su comportamiento: nunca lo sabremos.jpg

  final String todoDescription;

  @HiveField(1)
  final String hour;

  TodoRemainder({
    this.todoDescription,
    this.hour,
  });
}
