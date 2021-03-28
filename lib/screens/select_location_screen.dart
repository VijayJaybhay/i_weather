import 'package:flutter/material.dart';

class SelectLocationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SelectLocationScreenState();
  }
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  Widget _title = Text('Add City');
  Icon actionIcon = new Icon(Icons.search);
  String _cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title,
        actions: [
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.add);
                  _title = new TextField(
                    onChanged: (value) {
                      _cityName = value;
                    },
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Type city name",
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                } else {
                  this.actionIcon = new Icon(Icons.search);
                  this._title = new Text("Add City");
                  Navigator.pop(context, _cityName);
                }
              });
            },
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Text('Home Screen'),
        ),
      ),
    );
  }
}
