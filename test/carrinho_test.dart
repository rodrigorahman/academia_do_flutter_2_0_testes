import 'package:test/test.dart';
import 'package:testes_unitarios/carrinho.dart';
import 'package:testes_unitarios/item.dart';

void main() {
  group('Testes de calculo de valor total do carrinho', () {
    test('Deve calcular o valor total do carrinho', () {
      // Preparação
      final items = [
        Item(nome: 'Galaxy J1', preco: 2000),
        Item(nome: 'Iphone 12', preco: 10000),
        Item(nome: 'Carregador de tomada', preco: 200),
      ];
      final carrinho = Carrinho(items: items);

      // Ação ou Execução
      var valorTotalDoCarrinho = carrinho.totalCarrinho();

      // Verificação
      expect(valorTotalDoCarrinho, 12200);
    });

    test('Deve calcular o valor total do carrinho para carrinho vazio ', () {
      // Preparação
      final items = <Item>[];
      final carrinho = Carrinho(items: items);

      // Ação ou Execução
      var valorTotalDoCarrinho = carrinho.totalCarrinho();

      // Verificação
      expect(valorTotalDoCarrinho, 0);
    });
  });

  group('Teste de calculo de valor total de carrinho com imposto', () {
    test('Deve calcular o valor total do carrinho com imposto de 10%', () {
      // Preparação
      final items = [
        Item(nome: 'Galaxy J1', preco: 2000),
        Item(nome: 'Iphone 12', preco: 10000),
        Item(nome: 'Carregador de tomada', preco: 200),
      ];

      final carrinho = Carrinho(items: items);

      // Executar
      var valorTotalComImposto = carrinho.totalCarrinhoComImposto();

      expect(valorTotalComImposto, 13420);
    });

    // Se o valor for menor que 5 mil não cobra imposto.
    test('Deve retornar o valor sem imposto caso seja menor que 5000', () {
      // Preparação
      final items = [
        Item(nome: 'Galaxy J1', preco: 2000),
        Item(nome: 'Fone de ouvido', preco: 2900),
      ];

      final carrinho = Carrinho(items: items);

      // Executar
      var valorTotal = carrinho.totalCarrinhoComImposto();

      // Verificação
      expect(valorTotal, 4900);
    });

    test('Deve retornar o valor com imposto caso seja igual a 5000', () {
      // Preparação
      final items = [
        Item(nome: 'Galaxy J1', preco: 2000),
        Item(nome: 'Fone de ouvido', preco: 3000),
      ];

      final carrinho = Carrinho(items: items);

      // Executar
      var valorTotal = carrinho.totalCarrinhoComImposto();

      expect(valorTotal, 5500);
    });

    // Se o valor for maior que 20 mil então cobra imposto de 20%
    test(
        'Deve retornar o valorTotal com 20% de imposto para carrinho com valor maior que 20.000,00',
        () {
      // Preparação
      final items = [
        Item(nome: 'Galaxy J1', preco: 2000),
        Item(nome: 'IPhone', preco: 10000),
        Item(nome: 'IPhone', preco: 10000),
      ];

      final carrinho = Carrinho(items: items);

      // Executar
      var valorTotal = carrinho.totalCarrinhoComImposto();

      expect(valorTotal, 26400);
    });

    test(
        'Deve retornar o valorTotal com 10% de imposto para carrinho com valor igual que 20.000,00',
        () {
      // Preparação
      final items = [
        Item(nome: 'IPhone', preco: 10000),
        Item(nome: 'IPhone', preco: 10000),
      ];

      final carrinho = Carrinho(items: items);

      // Executar
      var valorTotal = carrinho.totalCarrinhoComImposto();

      expect(valorTotal, 22000);
    });
  });

  group('Teste de igualdade', () {
    test('Teste de igualdade', () {
      final iphone = Item(nome: 'Iphone 12', preco: 10000);

      final items = [
        Item(nome: 'Galaxy J1', preco: 2000),
        iphone,
        Item(nome: 'Carregador de tomada', preco: 200),
      ];

      final carrinho = Carrinho(items: items);

      // print(Item(nome: 'Iphone 12', preco: 10000) == Item(nome: 'Iphone 12', preco: 10000));

      expect(
          carrinho.items,
          contains(
            iphone,
          ));
    });

    test('Teste de igualdade 2', () {
      final items = [
        Item(nome: 'Galaxy J1', preco: 2000),
        Item(nome: 'Iphone 12', preco: 10000),
        Item(nome: 'Carregador de tomada', preco: 200),
      ];

      final carrinho = Carrinho(items: items);

      // print(Item(nome: 'Iphone 12', preco: 10000) == Item(nome: 'Iphone 12', preco: 10000));

      expect(
          carrinho.items,
          contains(
            Item(nome: 'Iphone 12', preco: 10001),
          ));
    });

    test('Teste de igualdade por tipo', () {
      final items = [
        Item(nome: 'Galaxy J1', preco: 2000),
        Item(nome: 'Iphone 12', preco: 10000),
        Item(nome: 'Carregador de tomada', preco: 200),
      ];

      final carrinho = Carrinho(items: items);

      // print(Item(nome: 'Iphone 12', preco: 10000) == Item(nome: 'Iphone 12', preco: 10000));

      expect(carrinho.items, isA<List<Item>>());
    });

    test('Teste de exceptions', () {
      final items = <Item>[];

      final carrinho = Carrinho(items: items);

      var call = carrinho.totalCarrinho;

      expect(() => call(), throwsFormatException);
    });

    test('Teste de exceptions customizada', () {
      final items = <Item>[];

      final carrinho = Carrinho(items: items);

      var call = carrinho.totalCarrinho;

      expect(() => call(), throwsA(isA<CarrinhoException>()));
    });

    test('Teste de exceptions customizada 2', () {
      final items = <Item>[];

      final carrinho = Carrinho(items: items);

      try {
        carrinho.totalCarrinho();
      } on CarrinhoException {
        print('Sucesso');
      } catch(e) {
        fail('retornou outra exception ($e)');
      }

    });
  });
}
