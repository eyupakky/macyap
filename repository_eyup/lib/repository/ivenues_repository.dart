import 'package:dio/dio.dart';
import 'package:repository_eyup/model/venues_model.dart';

abstract class IVenuesRepository{
  Future<List<VenusModel>>getLazyVenues();
  Future<VenusModel>getVenue(String id);
}
class VenuesRepository extends IVenuesRepository{
  late final Dio _dio;
  VenuesRepository(this._dio);
  @override
  Future<List<VenusModel>> getLazyVenues()async {
    List<VenusModel> lazyList = [];
    var response =await _dio.get("path");
    response.data[""].map((item){
      lazyList.add(VenusModel.fromJson(item));
    });
    return Future.value(lazyList);
  }

  @override
  Future<VenusModel> getVenue(String id) {
    // TODO: implement getVenue
    throw UnimplementedError();
  }

}