class Country {
  final String id;
  final String name;

  Country({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return 'Country(id: $id, name: $name)';
  }

  @override
  int get hashCode {
    return toString().hashCode;
  }

  @override
  bool operator ==(Object other) => other is Country && other.name == name;
}
