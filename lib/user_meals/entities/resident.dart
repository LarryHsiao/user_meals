class Resident {
  int id() => 0;

  String name() => "";

  int birthdayMillis() => 0;

  int age() => 0;
}

class ConstResident implements Resident {
  final int _age;
  final int _birthdayMillis;
  final int _id;
  final String _name;

  ConstResident(this._age, this._birthdayMillis, this._id, this._name);

  @override
  int age() => _age;

  @override
  int birthdayMillis() => _birthdayMillis;

  @override
  int id() => _id;

  @override
  String name() => _name;
}