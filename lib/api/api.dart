import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:ying_beauty/model/banner.dart';
import 'package:ying_beauty/model/base_result.dart';
import 'package:ying_beauty/model/cart.dart';
import 'package:ying_beauty/model/cart_detail.dart';
import 'package:ying_beauty/model/change_info.dart';
import 'package:ying_beauty/model/change_password_info.dart';
import 'package:ying_beauty/model/order.dart';
import 'package:ying_beauty/model/order_detail.dart';
import 'package:ying_beauty/model/product.dart';
import 'package:ying_beauty/model/product_detail.dart';
import 'package:ying_beauty/model/receiver_info.dart';
import 'package:ying_beauty/model/request/change_password.dart';
import 'package:ying_beauty/model/request/new_order.dart';
import 'package:ying_beauty/model/request/update_cart.dart';
import 'package:ying_beauty/model/sign_up_info.dart';
import 'package:ying_beauty/model/login_info.dart';
import 'package:ying_beauty/model/request/login_request.dart';
import 'package:ying_beauty/model/request/sign_up.dart';
part 'api.g.dart';

@RestApi(baseUrl: "https://ying-beauty-shop.herokuapp.com/public/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('/member/login')
  Future<BaseResult<LoginInfo>> login(@Body() LoginRequest req);
  @POST('/member/update-profile')
  Future<BaseResult<LoginInfo>> changeInfo(@Body() ChangeInfo req);
  @POST('/member/sign-up-member')
  Future<BaseResult<SignUpInfo>> signUp(@Body() SignUp req);
  @PATCH('/member/change-password/{id}')
  Future<BaseResult<ChangePasswordInfo>> changePass(
      @Path() int id, @Body() ChangePassword req);

  @GET('/api/products')
  Future<BaseResult<List<Product>>> getProductsType();
  @GET('/api/products/{id}')
  Future<BaseResult<Product>> getProductType(@Path() int id);
  @POST('/api/products')
  Future<BaseResult<Product>> addProductType(@Body() Product product);
  @PUT('/api/products/{id}')
  Future<BaseResult<Product>> updateProductType(
      @Path() int id, @Body() Product product);
  @DELETE('/api/products/{id}')
  Future<BaseResult> deleteProductType(@Path() int id);

  @GET('/api/products-detail')
  Future<BaseResult<List<ProductDetailt>>> getProducts();
  @GET('/api/products-detail/{id}')
  Future<BaseResult<ProductDetailt>> getProduct(@Path() int id);
  @POST('/api/products-detail')
  Future<BaseResult<ProductDetailt>> addProduct(@Body() ProductDetailt product);
  @POST('/api/products-detail/{id}')
  Future<BaseResult<ProductDetailt>> updateProduct(
      @Path() int id, @Body() ProductDetailt product);
  @DELETE('/api/products-detail/{id}')
  Future<BaseResult> deleteProduct(@Path() int id);

  @GET('/api/carts')
  Future<BaseResult<List<Cart>>> getCartsInfo();
  @GET('/api/carts/{id}')
  Future<BaseResult<Cart>> getCartInfo(@Path() int id);
  @POST('/api/carts')
  Future<BaseResult<Cart>> addCartInfo(@Body() Cart cart);
  @PUT('/api/carts')
  Future<BaseResult<Cart>> updateCartInfo(@Body() UpdateCart cart);
  @DELETE('/api/carts/{id}')
  Future<BaseResult> deleteCartInfo(@Path() int id);

  @GET('/api/carts-detail')
  Future<BaseResult<List<CartDetail>>> getCarts();
  @GET('/api/carts-detail/{id}')
  Future<BaseResult<CartDetail>> getCart(@Path() int id);
  @POST('/api/carts-detail')
  Future<BaseResult<CartDetail>> addCart(@Body() CartDetail cart);
  @PUT('/api/carts-detail/{id}')
  Future<BaseResult<CartDetail>> updateCart(
      @Path() int id, @Body() CartDetail cart);
  @DELETE('/api/carts-detail/{id}')
  Future<BaseResult> deleteCart(@Path() int id);

  @GET('/api/receivers-info')
  Future<BaseResult<List<ReceiverInfo>>> getReceiversInfo();
  @GET('/api/receivers-info/{id}')
  Future<BaseResult<ReceiverInfo>> getReceiverInfo(@Path() int id);
  @POST('/api/receivers-info')
  Future<BaseResult<ReceiverInfo>> addReceiverInfo(@Body() ReceiverInfo info);
  @PUT('/api/receivers-info/{id}')
  Future<BaseResult<ReceiverInfo>> updateReceiverInfo(
      @Path() int id, @Body() ReceiverInfo info);
  @DELETE('/api/receivers-info/{id}')
  Future<BaseResult> deleteReceiverInfo(@Path() int id);

  @GET('/api/orders-mb')
  Future<BaseResult<List<Order>>> getOrders();
  @GET('/api/orders-mb/{id}')
  Future<BaseResult<Order>> getOrder(@Path() int id);
  @POST('/api/orders-mb')
  Future<BaseResult<Order>> addOrder(@Body() NewOrder newOrder);

  @GET('/api/orders-detail-mb')
  Future<BaseResult<List<OrderDetail>>> getOrdersDetail();
  // @GET('/api/receivers-info/{id}')
  // Future<BaseResult<ReceiverInfo>> getReceiverInfo(@Path() int id);
  @POST('/api/orders-detail-mb')
  Future<BaseResult<OrderDetail>> addOrderDetail(
      @Body() OrderDetail orderDetail);
  @PUT('/api/orders-detail-mb/{id}')
  Future<BaseResult<OrderDetail>> updateOrderDetail(
      @Path() int id, @Body() OrderDetail orderDetail);

  @GET('/api/banners')
  Future<BaseResult<List<Banner>>> getBanners();
  @GET('/api/banners/{id}')
  Future<BaseResult<Banner>> getBanner(@Path() int id);
  @POST('/api/banners')
  Future<BaseResult<Cart>> addBanner(@Body() Banner banner);
  @PUT('/api/banners/{id}')
  Future<BaseResult<Cart>> updateBanner(@Path() int id, @Body() Banner banner);
  @DELETE('/api/banners/{id}')
  Future<BaseResult> deleteBanner(@Path() int id);
}
