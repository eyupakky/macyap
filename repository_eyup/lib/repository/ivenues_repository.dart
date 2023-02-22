import 'package:dio/dio.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/comment.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/model/urunler_model.dart';
import 'package:repository_eyup/model/venues_detail_model.dart';
import 'package:repository_eyup/model/venues_model.dart';

import '../constant.dart';

abstract class IVenuesRepository {
  Future<VenusModel> getLazyVenues(String name);

  Future<VenusDetailModel> getVenue(int? id);
  Future<VenusDetailModel> getUrun(int? id);
  Future<UrunlerModel> getShopping();

  Future<BaseResponse> venueFollow(int? venueId);

  Future<MatchesModel> getUpComingGames(int? venueId);

  Future<Comment> getVenueComments(int? venueId);

  Future<BaseResponse> rateVenue(int? venueId, int? field);

  Future<RatingResponse> getVenueRates(int? venueId);

  Future<BaseResponse> addVenueComment(int? venueId,String comment);
}

class VenuesRepository extends IVenuesRepository {
  late final Dio _dio;

  VenuesRepository(this._dio);

  @override
  Future<VenusModel> getLazyVenues(String? name) async {
    var response =
        await _dio.post(Constant.baseUrl + Constant.getVenues, data: {
      "access_token": Constant.accessToken,
      "name": name ?? "",
    }).catchError((err) {
      print(err);
    });
    return Future.value(VenusModel.fromJson(response.data));
  }

  @override
  Future<VenusDetailModel> getVenue(int? id) async {
    var response =
        await _dio.post(Constant.baseUrl + Constant.getVenueDetail, data: {
      "access_token": Constant.accessToken,
      "venue_id": id,
    }).catchError((err) {
      print(err);
    });
    return Future.value(VenusDetailModel.fromJson(response.data));
  }

  @override
  Future<BaseResponse> venueFollow(int? venueId) async {
    var response =
        await _dio.post(Constant.baseUrl + Constant.venueFollow, data: {
      "access_token": Constant.accessToken,
      "venue_id": venueId,
    }).catchError((err) {
      print(err);
    });
    return Future.value(BaseResponse.fromJson(response.data));
  }

  @override
  Future<MatchesModel> getUpComingGames(int? venueId) async {
    var response =
        await _dio.post(Constant.baseUrl + Constant.getUpComingGames, data: {
      "access_token": Constant.accessToken,
      "venue_id": venueId,
    }).catchError((err) {
      print(err);
    });
    return Future.value(MatchesModel.fromJson(response.data));
  }

  @override
  Future<Comment> getVenueComments(int? venueId) async {
    var response =
        await _dio.post(Constant.baseUrl + Constant.getVenueComments, data: {
      "access_token": Constant.accessToken,
      "venue_id": venueId,
    }).catchError((err) {
      print(err);
    });
    return Future.value(Comment.fromJson(response.data));
  }

  @override
  Future<BaseResponse> rateVenue(int? venueId, int? field) async {
    print("");
    var response =
        await _dio.post(Constant.baseUrl + Constant.rateVenue, data: {
      "access_token": Constant.accessToken,
      "venue_id": venueId,
      "field": field,
    }).catchError((err) {
      print(err);
    });
    return Future.value(BaseResponse.fromJson(response.data));
  }

  @override
  Future<RatingResponse> getVenueRates(int? venueId) async {
    var response = await _dio.post(Constant.baseUrl + Constant.getVenueRates,
        data: {
          "access_token": Constant.accessToken,
          "venue_id": venueId
        }).catchError((err) {
      print(err);
    });
    return Future.value(RatingResponse.fromJson(response.data));
  }

  @override
  Future<BaseResponse> addVenueComment(int? venueId, String comment)async {
    var response = await _dio.post(Constant.baseUrl + Constant.addVenueComment,
        data: {
          "access_token": Constant.accessToken,
          "venue_id": venueId,
          "comment": comment
        }).catchError((err) {
      print(err);
    });
    return Future.value(BaseResponse.fromJson(response.data));
  }

  @override
  Future<UrunlerModel> getShopping()async {
    var response = await _dio.post(Constant.testBaseUrl + Constant.urunlerList,
        data: {
          "access_token": Constant.accessToken
        }).catchError((err) {
      print(err);
    });
    return Future.value(UrunlerModel.fromJson(response.data));
  }

  @override
  Future<VenusDetailModel> getUrun(int? id) async{
    var response = await _dio.post(Constant.testBaseUrl + Constant.urunlerDetails,
        data: {
          "access_token": Constant.accessToken,
          "urun_id": id
        }).catchError((err) {
      print(err);
    });
    return Future.value(VenusDetailModel.fromJson(response.data));
  }
}
