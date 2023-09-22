import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileText extends Text {
  final String type;
  static const TextStyle _fieldStyle =
      TextStyle(color: Colors.black, fontSize: 18.0);

  static const TextStyle _valueStyle =
      TextStyle(color: Colors.black54, fontSize: 16.0);

  const ProfileText(
    String? data, {
    super.key,
    this.type = 'value',
  }) : super(
          data ?? '',
          style: (type == 'field') ? _fieldStyle : _valueStyle,
        );
}

class ListItem extends StatelessWidget {
  final String field;
  final String? value;
  const ListItem({super.key, required this.field, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: ProfileText(field, type: 'field'),
        trailing: ProfileText(value, type: 'value'));
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ListItem> tiles = <ListItem>[
      ListItem(field: 'Username'.tr, value: 'Leo'),
      ListItem(field: 'Gender'.tr, value: 'Male'),
      ListItem(field: 'Age'.tr, value: '27'),
      ListItem(field: 'Country'.tr, value: 'Japan'),
      ListItem(field: 'ID'.tr, value: '1122334455'),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text('personalInformation'.tr),
        ),
        body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return tiles[index];
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.grey[300],
              thickness: 1.0,
            );
          },
          itemCount: tiles.length,
        ));
  }
}
