import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:crocsclub_admin/domain/models/product.dart';
import 'package:crocsclub_admin/data/services/addproducts.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/main.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductService productservice = ProductService();
  ProductBloc() : super(ProductInitial()) {
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

    on<FetchProducts>((event, emit) async {
      print('the length of productlist is ');
      emit(ProductLoading());
      try {
        final productslist = await productservice.getProducts();
        print('the length of productlist from is ${productslist}');
        emit(ProductLoaded(products: productslist));
        print('emitted product loaded');
      } catch (e) {
        emit(ProductError());
      }
    });

    on<UpdateStockEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final response =
            await productservice.updateStock(event.productId, event.newStock);

        if (response.statusCode == 200 || response.statusCode == 201) {
          final productslist = await productservice.getProducts();
          print('the length of productlist from is ${productslist}');
          emit(ProductLoaded(products: productslist));
          emit(ProductStockUpdated());
        } else {
          print('Failed to update stock: ${response.statusMessage}');
          emit(ProductError());
        }
      } catch (e) {
        print('Error updating stock: $e');
      }
    });

    on<DeleteProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final response = await productservice.deleteInventory(event.productId);

        if (response.statusCode == 200) {
          final productslist = await productservice.getProducts();
          emit(ProductLoaded(products: productslist));
          emit(ProductDeleted());
        } else {
          print('Failed to delete product: ${response.statusMessage}');
          emit(ProductError());
        }
      } catch (e) {
        print('Error deleting product: $e');
        emit(ProductError());
      }
    });

    on<UploadImagesEvent>((event, emit) async {
      emit(ImageUploadLoading());
      print('upload image event is caled');
      try {
        final token = await getToken();
        final url =
            Uri.parse('http://10.0.2.2:8080/admin/inventories/uploadimages');
        final multipartRequest = MultipartRequest('POST', url);
        multipartRequest.fields['inventory_id'] = event.inventoryId.toString();
        for (final image in event.images) {
          final bytes = await image.readAsBytes();
          final multipartFile =
              MultipartFile.fromBytes('image', bytes, filename: image.name);
          multipartRequest.files.add(multipartFile);
        }
        multipartRequest.headers['Authorization'] = token!;
        final response = await httpClient.send(multipartRequest);
        if (response.statusCode == 200) {
          print('upload image is succesful');
          emit(ImageUploadSuccess(message: 'Image sucessfully added'));
        } else {
          emit(ImageUploadFailure(error: 'Could not add images'));
          print('upload image is not succesful');
        }
      } catch (e) {
        emit(ImageUploadFailure(error: 'Could not add images'));
      }
    });
  }
}
