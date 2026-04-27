import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/libro_model.dart';

class FirebaseService {
  // Referencia central a la colección
  final CollectionReference _db = FirebaseFirestore.instance.collection('valentina_eritz');

  // CREATE: Guardar un libro nuevo
  Future<void> addLibro(LibroModel libro) async {
    await _db.add(libro.toFirestore());
  }

  // READ: Obtener todos los libros en tiempo real
  Stream<List<LibroModel>> getLibros() {
    return _db.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return LibroModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // UPDATE: Actualizar datos de un libro existente
  Future<void> updateLibro(LibroModel libro) async {
    if (libro.id != null) {
      await _db.doc(libro.id!).update(libro.toFirestore());
    }
  }

  // DELETE: Eliminar un libro
  Future<void> deleteLibro(String id) async {
    await _db.doc(id).delete();
  }

  // SEARCH: Buscar por nombre (sensible a mayúsculas)
  Stream<List<LibroModel>> buscarLibro(String nombre) {
    return _db
        .where('Titulo', isGreaterThanOrEqualTo: nombre)
        .where('Titulo', isLessThanOrEqualTo: '$nombre\uf8ff')
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => LibroModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }
}