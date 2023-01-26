class DailyMeal {
  int id() => 0;

  int residentId() => 0;

  bool breakfast() => false;

  bool lunch() => false;

  bool dinner() => false;
}

class ConstDailyMeal implements DailyMeal {
  final bool _breakfast;
  final bool _dinner;
  final int _id;
  final bool _lunch;
  final int _residentId;

  ConstDailyMeal(
    this._breakfast,
    this._dinner,
    this._id,
    this._lunch,
    this._residentId,
  );

  @override
  bool breakfast() => _breakfast;

  @override
  bool dinner() => _dinner;

  @override
  int id() => _id;

  @override
  bool lunch() => _lunch;

  @override
  int residentId() => _residentId;
}

class UpdatedDailyMeal implements DailyMeal {
  final DailyMeal _original;
  final bool? _breakfast;
  final bool? _dinner;
  final bool? _lunch;

  UpdatedDailyMeal(
    this._original,
    this._breakfast,
    this._lunch,
    this._dinner,
  );

  @override
  bool breakfast() {
    return _breakfast ?? _original.breakfast();
  }

  @override
  bool dinner() {
    return _dinner ?? _original.dinner();
  }

  @override
  int id() {
    return _original.id();
  }

  @override
  bool lunch() {
    return _lunch ?? _original.lunch();
  }

  @override
  int residentId() {
    return _original.residentId();
  }
}
