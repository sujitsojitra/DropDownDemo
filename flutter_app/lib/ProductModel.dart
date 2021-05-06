class ProductCategoryModel {
  String categoryName;
  String categoryId;
  List<SubCategory> subcategory;

  ProductCategoryModel(
      {this.categoryName,
        this.categoryId,
        this.subcategory});

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    var list = json['children'] as List;
    print(list.runtimeType);
    List<SubCategory> subCategoryList =
    list.map((i) => SubCategory.fromJson(i)).toList();

    return ProductCategoryModel(
      categoryName: json['name'],
      categoryId: json['category_id'],
      subcategory: subCategoryList,
    );
  }
}

class SubCategory {
  String subCategoryId;
  String subCategoryName;

  SubCategory({this.subCategoryId, this.subCategoryName});

  factory SubCategory.fromJson(Map<String, dynamic> subJson) {
    return SubCategory(
      subCategoryId: subJson['SubCategoryModel'],
      subCategoryName: subJson['name'],
    );
  }
}