import 'package:flutter_test/flutter_test.dart';

void main() {
  test('testando herança', () async {
    List<T> listaDeT = [
      Y(att2: "435",att: "323"),
      E(att2: "435",att: "323"),
      Y(att2: "435",att: "323"),
    ];

    for (var item in listaDeT) {
      if (item is Y) {
        print('O item é uma instância de Y');
        // Você pode até converter o tipo para acessar métodos específicos de Y
        (item).metodoDeY();
      } else if (item is E) {
        print('O item é uma instância de E');
      } else      print('O item é uma instância de T');
    
    }
    final instance = listaDeT[0];

    expect(listaDeT[0], isA<T>());
    expect(listaDeT[0], equals(instance));
  });
}

// Classe mãe
sealed class T {
  T({
    required this.att,
    required this.att2,
  });

  String att;
  String att2;
  void metodoDeT() {
    print('Este é um T');
  }
}

// Classe filha que herda de T
class Y extends T {


  Y({required super.att, required super.att2});
  void metodoDeY() {
    print('Este é um Y');
  }
}

// Outra classe filha que herda de T
class E extends T {
  E({required super.att, required super.att2});

  void metodoDeE() {
    print('Este é um E');
  }
}
