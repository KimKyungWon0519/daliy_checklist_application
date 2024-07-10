enum TasksType {
  today('오늘 할 일'),
  future('앞으로 할 일'),
  postpone('지난 할 일'),
  all('모든 할 일'),
  completed('완료된 일');

  final String name;

  const TasksType(this.name);
}
