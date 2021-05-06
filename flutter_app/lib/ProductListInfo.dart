import 'package:flutter/material.dart';
import 'package:flutter_app/ProductModel.dart';

class ProductListInfo extends StatefulWidget{
  List<ProductCategoryModel> productLists;
  ProductListInfo(this.productLists);

  @override
  State<StatefulWidget> createState() {
    return ProductListInfoState(this.productLists);
  }
}

class ProductListInfoState extends State<ProductListInfo>{
  List<ProductCategoryModel> productLists;
  ProductListInfoState(this.productLists);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          (productLists!=null)?ListView.builder
            (
              shrinkWrap: true,
              itemCount: productLists.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 4,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Category : "+productLists[index].categoryName),
                      ),
                      (productLists[index].subcategory!=null&&productLists[index].subcategory.length>0)?
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: productLists[index].subcategory.length,
                          itemBuilder: (BuildContext ctxt, int indexIner){
                            return Card(
                              elevation: 1,
                              color: Colors.white70,
                              margin: EdgeInsets.only(left: 10,bottom: 5,right: 5),
                              child: ListTile(
                                title: Text(productLists[index].subcategory[indexIner].subCategoryName),
                              ),
                            );
                          }):Container()
                    ],
                  ),
                );
              }
          ):Container(),
        ],
      )
    );
  }
}


