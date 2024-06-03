import 'package:taska/ui/views/home/home_viewmodel.dart';

extension TaskTypeExtension on TaskType{
  bool isCurrent() => this == TaskType.upcoming;

  String getTaskMessage(int number){
    return switch (this){
      TaskType.upcoming => number <= 0
          ? 'No tasks scheduled'
          : '$number ${number == 1 ? 'task' : 'tasks'} scheduled',
      TaskType.completed => number <= 0
          ? 'No tasks completed'
          : '$number ${number == 1 ? 'task' : 'tasks'} completed',
    };
  }

  String getEmptyTitle(){
    return switch (this){
      TaskType.upcoming => 'No upcoming tasks for today!',
      TaskType.completed => 'No tasks completed yet',
    };
  }

  String getEmptyContent(){
    return switch (this){
      TaskType.upcoming => 'Add some tasks to plan your day. Tap on the + button to get started.',
      TaskType.completed => "You haven't completed any tasks yet today.",
    };
  }
}