import 'dart:collection';

import 'package:flutter/material.dart';

import '../provider.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ProviderRoute(),
    ),
  ));
}

class Item {
  Item(this.price, this.count);
  double price;
  int count;
}

class CartModel extends ChangeNotifier {

  final List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  double get totalPrice => _items.fold(0, (previousValue, item) => previousValue + item.count * item.price);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}

class ProviderRoute extends StatefulWidget {
  @override
  _ProviderRouteState createState() => _ProviderRouteState();
}

class _ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<CartModel>(
        data: CartModel(),
        child: Builder(builder: (context) {
          return Column(children: [
            // Builder(builder: (context) {
            //   var cart = ChangeNotifierProvider.of<CartModel>(context);
            //   return Text('总价：${cart.totalPrice}');
            // }),
            Consumer<CartModel>(builder: (context, cart) {
              return Text('总价：${cart.totalPrice}');
            }),
            Builder(builder: (context) {
              return ElevatedButton(onPressed: () {
                ChangeNotifierProvider.of<CartModel>(context, listen: false).add(Item(20.0, 1));
              }, child: Text('添加商品'));
            })
          ],);
        }),
      )
    ,);
  }
}