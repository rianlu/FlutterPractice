import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Button'),
      ),
      body: Column(
        children: [
          RaisedButton(
            child: Text('RaisedButton'),
            onPressed: () {},
          ),
          FlatButton(
            child: Text('FlatButton'),
            onPressed: () {},
          ),
          OutlineButton(
            child: Text('OutlineButton'),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.thumb_up),
            onPressed: () {},
          ),
          // Icon Button
          RaisedButton.icon(
            icon: Icon(Icons.send),
            label: Text('Send'),
            onPressed: () {},
          ),
          FlatButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add'),
            onPressed: () {},
          ),
          OutlineButton.icon(
            icon: Icon(Icons.info),
            label: Text('Info'),
            onPressed: () {},
          ),
          // Custom Button
          RaisedButton(
            color: Colors.blue,
            highlightColor: Colors.blue[700],
            colorBrightness: Brightness.dark,
            splashColor: Colors.grey,
            child: Text('Submit'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            onPressed: () {},
          )
        ],
      ),
    ),
  ));
}
