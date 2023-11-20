import 'package:cloud_firestore/cloud_firestore.dart';

typedef FactoryConstructor<T> = T Function(Map<String, Object?> json);

abstract class JsonConvertible {
  Map<String, Object?> toJson();
}

base class CrudCollection<T extends JsonConvertible> {
  final String collectionPath;
  final FactoryConstructor<T> fromJson;
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference collectionRef;

  CrudCollection({
    required this.collectionPath,
    required this.fromJson,
  }) {
    this.collectionRef = _firestore.collection(collectionPath).withConverter(
      fromFirestore: (snapshot, _) {
        final data = snapshot.data()!..putIfAbsent('id', () => snapshot.id);
        return fromJson(data);
      },
      toFirestore: (value, _) {
        return (value! as JsonConvertible).toJson()..remove('id');
      },
    );
  }

  Future<String> createOne(T item) async {
    var newDocId = (await collectionRef.add(item)).id;
    return newDocId;
  }

  Future<T?> getById(String id) async {
    return (await collectionRef.doc(id).get()).data() as T?;
  }

  Future<List<T>> getAll() async {
    var items = await collectionRef.get();
    return items.docs.map((e) => e.data() as T).toList();
  }

  Future<List<T>> getWhere(Object field,
      {Object? isEqualTo,
      Object? isNotEqualTo,
      Object? isLessThan,
      Object? isLessThanOrEqualTo,
      Object? isGreaterThan,
      Object? isGreaterThanOrEqualTo,
      Object? arrayContains,
      Iterable<Object?>? arrayContainsAny,
      Iterable<Object?>? whereIn,
      Iterable<Object?>? whereNotIn,
      bool? isNull}) async {
    var items = await collectionRef
        .where(
          field,
          isEqualTo: isEqualTo,
          isNotEqualTo: isNotEqualTo,
          isLessThan: isLessThan,
          isLessThanOrEqualTo: isLessThanOrEqualTo,
          isGreaterThan: isGreaterThan,
          isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
          arrayContains: arrayContains,
          arrayContainsAny: arrayContainsAny,
          whereIn: whereIn,
          whereNotIn: whereNotIn,
        )
        .get();
    return items.docs.map((e) => e.data() as T).toList();
  }
}
