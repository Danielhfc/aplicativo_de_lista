import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:aplicativo_de_lista/app/models/item_model.dart';
import 'package:aplicativo_de_lista/components/home_controller.dart';

import '../../item_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  _dialog() {
    var model = ItemModel();

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Adicionar item"),
            content: TextField(
              onChanged: model.setTitle,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Novo item',
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar'),
              ),
              FlatButton(
                onPressed: () {
                  controller.addItem(model);
                  Navigator.pop(context);
                },
                child: Text('Salvar'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: controller.setFilter,
          decoration: InputDecoration(hintText: "Filtrar..."),
        ),
        actions: <Widget>[
          Observer(builder: (_) {
            return IconButton(
              icon: Text(controller.totalChecked.toString()),
              onPressed: () {},
            );
          }),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (controller.output.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: controller.output.data.length,
            itemBuilder: (_, index) {
              var item = controller.output.data[index];
              return ItemWidget(
                item: item,
                removeClicked: () {
                  controller.removeItem(item);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _dialog();
        },
      ),
    );
  }
}
