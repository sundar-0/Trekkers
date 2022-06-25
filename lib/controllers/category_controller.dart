import 'package:get/get.dart';
import 'package:trekkers_project/data/models/category.dart';


class CategoryController extends GetxController {
  var categories = <CategoriesModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     fetchCategories();
  }

  fetchCategories() async {
    await Future.delayed(Duration(seconds: 1));
    var categoriesResult = [
      CategoriesModel(
          cat_id: 1,
          cat_name:"Trek Bag" ,
          cat_img: "https://images.pexels.com/photos/1178525/pexels-photo-1178525.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
          ),
        CategoriesModel(
          cat_id: 2,
          cat_name:"Trek Stick" , 
          cat_img: "https://images.pexels.com/photos/7787404/pexels-photo-7787404.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
          ),
        CategoriesModel(
          cat_id: 3,
          cat_name:"Track/Trouser" ,
          cat_img: "https://images.pexels.com/photos/792668/pexels-photo-792668.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
          ),
          CategoriesModel(
          cat_id: 4,
          cat_name:"Jacket" ,
          cat_img: "https://images.pexels.com/photos/9971399/pexels-photo-9971399.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
          ),
          CategoriesModel(
          cat_id: 5,
          cat_name:"High Neck Sweater" ,
          cat_img: "https://5.imimg.com/data5/EL/GV/MY-42381219/ladies-sweater-500x500.jpg"
          ),

          CategoriesModel(
          cat_id: 6,
          cat_name:"Gloves" ,
          cat_img: "https://images.pexels.com/photos/1903760/pexels-photo-1903760.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
          ),
          CategoriesModel(
          cat_id: 7,
          cat_name:"Snacks" ,  
          cat_img: "https://images.pexels.com/photos/1301373/pexels-photo-1301373.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
          ),
       
       
    ];
    categories.value = categoriesResult;
  }
}