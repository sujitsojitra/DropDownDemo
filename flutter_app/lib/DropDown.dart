import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ProductListInfo.dart';

import 'ProductModel.dart';
import 'main.dart';

class DropDown extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DropDownState();
  }

}




class DropDownState extends State<DropDown> {
  var random = new Random();
  String _chosenValue;
  ProductCategoryModel selectedCategory;
  List<ProductCategoryModel> productList=[];
  String pinfo="";

  final fieldText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: ListView(
          children: [
            // DropdownButton<String>(
            //   focusColor:Colors.white,
            //   value: _chosenValue,
            //   //elevation: 5,
            //
            //   style: TextStyle(color: Colors.white),
            //   iconEnabledColor:Colors.black,
            //   items: <DropdownMenuItem<String>>[
            //     new DropdownMenuItem(
            //       child: new Text('My Page'),
            //       value: 'one',
            //     ),
            //   ],
            //   hint:Text(
            //     "Please choose a Product",
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 14,
            //         fontWeight: FontWeight.w500),
            //   ),
            //   onChanged: (String value) {
            //     print(value);
            //     setState(() {
            //       //_chosenValue = value;
            //     });
            //   },
            // ),
            DropdownButton<ProductCategoryModel>(
              value: selectedCategory,
              onChanged: (ProductCategoryModel newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              hint:Text(
                  "Please choose a Product",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              items: productList.map((ProductCategoryModel Product) {
                return new DropdownMenuItem<ProductCategoryModel>(
                  value: Product,
                  child: Text(
                    Product.categoryName,
                  ),
                );
              }).toList(),
            ),
            TextField(
              controller: fieldText,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: false,
                labelText: 'value',
                hintText: "Enter value",
              ),
            ),
            TextButton(onPressed: (){
              if(selectedCategory!=null){
                var p= productList.firstWhere((item) => item.categoryId == selectedCategory.categoryId);
                setState(() => p.subcategory.add(SubCategory(
                  subCategoryId: random.nextInt(100).toString(),
                  subCategoryName: fieldText.text
                )) );
              }else{
                productList.add(ProductCategoryModel(
                    categoryName:fieldText.text,
                    categoryId:random.nextInt(100).toString(),
                    subcategory: []
                ));
                setState(() {
                });
              }
                fieldText.clear();
            },
                child: Text("Add")),
            TextButton(onPressed: (){

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return SignUpScreen();
              //     },
              //   ),
              // );

              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ProductListInfo(productList);
              }));

            },
            child: Text("Next Page"))
          ],
        ),
      )
    );
  }
}