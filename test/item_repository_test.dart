import 'package:test/test.dart';
import 'package:testes_unitarios/item.dart';
import 'package:testes_unitarios/item_repository.dart';

void main() {
  test('Buscar todos asyncrono forma 1', () async {
    // Preparação
    var repository = ItemRepository();

    // Ação/execução
    var items = await repository.buscarTodos();

    // Verificação
    expect(items, isNotEmpty);
  });

  test('Buscar todos asyncrono forma 2', () {
    // preparação
    var repository = ItemRepository();

    // Ação/execução
    var buscarTodos = repository.buscarTodos;

    // Verificação
    expect(buscarTodos(), completion(isNotEmpty));
  });

  test('Buscar item por id', () {
    // preparação
    var repository = ItemRepository();

    // Ação/execução
    var item = repository.buscarPorId(1);

    // Verificação
    expect(item, isNotNull);
    expect(item, Item(nome: 'Iphone', preco: 10000));
    // expect(
    //     item,
    //     allOf([
    //       isNotNull,
    //       equals(Item(nome: 'Iphone', preco: 10000)),
    //     ]));
  });
}
