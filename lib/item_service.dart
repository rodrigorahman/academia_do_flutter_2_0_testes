import 'package:testes_unitarios/item_repository.dart';

import 'item.dart';

class ItemService {
  IItemRepository repository;

  ItemService({
    required this.repository,
  });

  Future<List<Item>> buscarTodos() => repository.buscarTodos();
  List<Item> buscarTodosSync() => repository.buscarTodosSync();
  Item buscarPorId(int id){
    return repository.buscarPorId(id+1);
    // return Item(nome: 'item', preco: 10);
  }
}
