import 'package:cloud_firestore/cloud_firestore.dart';

class LibroModel {
  final String? id; 
  final String titulo;
  final String autor;
  final int paginas; 
  final DateTime updatedAt;
  final bool pendingSync;

  const LibroModel({
    this.id,
    required this.titulo,
    required this.autor,
    required this.paginas,
    required this.updatedAt,
    required this.pendingSync,
  });

  LibroModel copyWith({
    String? id, 
    String? titulo,
    String? autor,
    int? paginas,
    DateTime? updatedAt,
    bool? pendingSync,
  }) {
    return LibroModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      autor: autor ?? this.autor,
      paginas: paginas ?? this.paginas,
      updatedAt: updatedAt ?? this.updatedAt,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  Map<String, dynamic> toFirestore() {
  return {
    'Titulo': titulo, 
    'Autor': autor,
    'Paginas': paginas,
    'updatedAt': Timestamp.fromDate(updatedAt), 
    };
  }

  factory LibroModel.fromFirestore(Map<String, dynamic> map, String id) {
  return LibroModel(
    id: id,
    titulo: map['Titulo'] as String? ?? 'Sin título',
    autor: map['Autor'] as String? ?? 'Autor desconocido',
    paginas: map['Paginas'] as int? ?? 0,
    updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    pendingSync: false,
    );
  }
}
