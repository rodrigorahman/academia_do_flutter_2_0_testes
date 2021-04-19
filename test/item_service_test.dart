import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:testes_unitarios/item.dart';
import 'package:testes_unitarios/item_repository.dart';
import 'package:testes_unitarios/item_service.dart';

// !NÃO FAZER DESSA FORMA
// class ItemRepositoryFake implements IItemRepository {
//   @override
//   Item buscarPorId(int id) {
//     return Item(nome: 'Item teste', preco: 10);
//   }

//   @override
//   Future<List<Item>> buscarTodos() async {
//     return <Item>[];
//   }

//   @override
//   List<Item> buscarTodosSync() {
//     return [];
//   }
// }

// class ItemRepositoryFakeException implements IItemRepository {
//   @override
//   Item buscarPorId(int id) {
//     return Item(nome: 'Item teste', preco: 10);
//   }

//   @override
//   Future<List<Item>> buscarTodos() async {
//     throw Exception();
//   }

//   @override
//   List<Item> buscarTodosSync() {
//     return [];
//   }
// }

class ItemRepositoryFake extends Mock implements IItemRepository {}

void main() {
  late IItemRepository itemRepository;

  setUp(() {
    // Preparação
    itemRepository = ItemRepositoryFake();
  });

  test('Buscar todos os items', () async {
    when(() => itemRepository.buscarTodos()).thenAnswer((_) async => <Item>[]);
    var service = ItemService(repository: itemRepository);

    final items = await service.buscarTodos();

    expect(items, <Item>[]);
  });

  test('Buscar todos os items retorna uma exception', () async {
    when(() => itemRepository.buscarTodos()).thenThrow(Exception());
    var service = ItemService(repository: itemRepository);

    final call = service.buscarTodos;

    expect(() => call(), throwsException);
  });

  test('Busca por id any', (){
    when(() => itemRepository.buscarPorId(any())).thenReturn(Item(nome: 'Item X', preco: 10));
    var service = ItemService(repository: itemRepository);

    var item = service.buscarPorId(1);

    verify(() => itemRepository.buscarPorId(any())).called(1);
    expect(item, isNotNull);
  });

  test('Busca por id ', (){
    // preparaçao
    when(() => itemRepository.buscarPorId(any())).thenReturn(Item(nome: 'Item X', preco: 10));
    var service = ItemService(repository: itemRepository);
    var id = 1;

    // ação/execução
    var item = service.buscarPorId(id);

    // Verificação / Validação
    verify(() => itemRepository.buscarPorId(id+1)).called(1);
    expect(item, isNotNull);
  });
}
