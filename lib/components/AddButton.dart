import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddButtonWidget extends StatefulWidget {
  const AddButtonWidget({super.key, required this.addButton});

  final void Function(String) addButton;

  @override
  State<AddButtonWidget> createState() => _AddButtonWidgetState();
}

class _AddButtonWidgetState extends State<AddButtonWidget> {
  bool change = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: change ? ElevatedButton(
        child: Text('+', style: TextStyle(fontSize: 30)),
          style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(40),
        ),
        onPressed:() {
          setState(() {
            change = false;
          });
        },
      )
      :
      Container(
        alignment: Alignment.bottomCenter,
        child:Form(
          child: Row(
          children: [
            Expanded(
              flex: 5,
              child: TextFormField(
                autofocus: true,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
                
              ),
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name';
                }
                return null;
            },),),
            Expanded(
              child: ElevatedButton(
                onPressed:() {
                  setState(() {
                    change = true;
                    widget.addButton(nameController.text);
                  });
                }, child: Text('+'), 
                style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(25),
        ),))
          ]
        )
      ),)
    );
  }
}