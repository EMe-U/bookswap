// Minimal Cloud Firestore stubs to allow compiling without firebase dependencies.
// Replace these with your own Firestore implementation when ready.

class FirebaseFirestore {
  FirebaseFirestore._internal();
  static final FirebaseFirestore instance = FirebaseFirestore._internal();

  CollectionReference collection(String name) =>
      CollectionReference(name: name);
  WriteBatch batch() => WriteBatch();
}

class CollectionReference {
  final String name;
  CollectionReference({this.name = ''});

  Future<DocumentReference> add(Map<String, dynamic> data) async {
    // Simulate creating a document with an auto-id
    final id = '${name}_doc_${DateTime.now().millisecondsSinceEpoch}';
    return DocumentReference(id: id, data: data);
  }

  DocumentReference doc([String? id]) =>
      DocumentReference(id: id ?? '${name}_doc');

  Query where(
    dynamic field, {
    dynamic isEqualTo,
    dynamic isNotEqualTo,
    dynamic arrayContains,
  }) => Query(collectionName: name);

  Query orderBy(String field, {bool descending = false}) =>
      Query(collectionName: name);

  Stream<QuerySnapshot> snapshots() => Stream<QuerySnapshot>.value(
    QuerySnapshot(docs: _seedForCollection(name)),
  );
}

class DocumentReference {
  final String id;
  final Map<String, dynamic>? initialData;
  DocumentReference({this.id = '', Map<String, dynamic>? data})
    : initialData = data;

  Future<DocumentSnapshot> get() async =>
      DocumentSnapshot(id: id, data: initialData ?? {}, reference: this);

  Future<void> update(Map<String, dynamic> data) async {}

  Future<void> delete() async {}

  CollectionReference collection(String name) =>
      CollectionReference(name: name);
}

class DocumentSnapshot {
  final String id;
  final Map<String, dynamic>? _data;
  final DocumentReference reference;
  DocumentSnapshot({
    this.id = '',
    Map<String, dynamic>? data,
    DocumentReference? reference,
  }) : _data = data,
       reference = reference ?? DocumentReference(id: id);
  Map<String, dynamic>? data() => _data;
  bool get exists => _data != null && _data!.isNotEmpty;
}

class Query {
  final String collectionName;
  Query({this.collectionName = ''});

  Stream<QuerySnapshot> snapshots() => Stream<QuerySnapshot>.value(
    QuerySnapshot(docs: _seedForCollection(collectionName)),
  );
  Future<QuerySnapshot> get() async =>
      QuerySnapshot(docs: _seedForCollection(collectionName));

  Query where(
    String field, {
    dynamic isEqualTo,
    dynamic isNotEqualTo,
    dynamic arrayContains,
  }) => this;
  Query orderBy(String field, {bool descending = false}) => this;
  DocumentReference doc([String? id]) =>
      DocumentReference(id: id ?? '${collectionName}_doc');
}

class QuerySnapshot {
  final List<DocumentSnapshot> docs;
  QuerySnapshot({this.docs = const []});
}

// Provide seeded sample documents for common collections so the UI can show mock data
List<DocumentSnapshot> _seedForCollection(String name) {
  if (name == 'books') {
    final now = DateTime.now();
    final doc1 = DocumentSnapshot(
      id: 'book_1',
      data: {
        'title': 'Hand Of Midas',
        'author': 'Shelley Marie',
        'condition': 'Like New',
        'coverImageUrl': 'https://picsum.photos/200/300?random=1',
        'userId': 'uid_1001',
        'userEmail': 'user1@example.com',
        'swapStatus': null,
        'createdAt': Timestamp.fromDate(now.subtract(const Duration(days: 1))),
        'updatedAt': Timestamp.fromDate(now.subtract(const Duration(days: 1))),
      },
    );

    final doc2 = DocumentSnapshot(
      id: 'book_2',
      data: {
        'title': 'Harry Potter',
        'author': 'J. K Rowling',
        'condition': 'Good',
        'coverImageUrl': 'https://picsum.photos/200/300?random=2',
        'userId': 'uid_1002',
        'userEmail': 'user2@example.com',
        'swapStatus': null,
        'createdAt': Timestamp.fromDate(now.subtract(const Duration(days: 2))),
        'updatedAt': Timestamp.fromDate(now.subtract(const Duration(days: 2))),
      },
    );

    return [doc1, doc2];
  }

  // Default: empty list for other collections
  return [];
}

class WriteBatch {
  final List<Function()> _ops = [];
  void update(DocumentReference ref, Map<String, dynamic> data) {
    _ops.add(() {});
  }

  Future<void> commit() async {}
}

class FirebaseException implements Exception {
  final String code;
  final String? message;
  FirebaseException({this.code = '', this.message});
}

class FieldPath {
  static final documentId = '__documentId__';
}

class Timestamp {
  Timestamp();
  static Timestamp fromDate(DateTime date) => Timestamp();
  DateTime toDate() => DateTime.now();
}
