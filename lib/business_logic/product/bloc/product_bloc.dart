import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:crocsclub_admin/data/models/product.dart';
import 'package:crocsclub_admin/data/repositories/addproducts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductService productservice = ProductService();
  ProductBloc() : super(ProductInitial()) {
    // on<FetchProducts>((event, emit) async {
    //   emit(ProductLoading());
    //   try {
    //     final products = await productservice.fetchProducts();
    //     emit(ProductLoaded(products: products));
    //   } catch (e) {
    //     emit(ProductError());
    //   }
    // });
    on<PostProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        final response = await productservice.addProduct(event.product);

        if (response.statusCode == 200 || response.statusCode == 201) {
          emit(ProductPosted());
        } else {
          print('the response is ${response.statusMessage}');
          emit(ProductError());
        }
      } catch (e) {
        emit(ProductError());
      }
    });

    on<PickImage>(
      (event, emit) async {
        final imagePicker = ImagePicker();
        final pickedImage =
            await imagePicker.pickImage(source: ImageSource.gallery);
        if (pickedImage != null) {
          emit(ImagePicked(imageFile: File(pickedImage.path)));
        }
      },
    );
  }
}
