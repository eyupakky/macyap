import 'package:dio/dio.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/comment.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/model/siparisler.dart';
import 'package:repository_eyup/model/urun_details.dart';
import 'package:repository_eyup/model/urunler_model.dart';
import 'package:repository_eyup/model/venues_detail_model.dart';
import 'package:repository_eyup/model/venues_model.dart';

import '../constant.dart';

abstract class IVenuesRepository {
  Future<VenusModel> getLazyVenues(String name);

  Future<VenusDetailModel> getVenue(int? id);
  Future<UrunDetailModel> getUrun(int? id);
  Future<BaseResponse2> siparisVer(int urunId,int bedenId,int adet,String adres);
  Future<UrunlerModel> getShopping();
  Future<SiparisList> siparisler();

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
    var response = await _dio.post(Constant.baseUrl + Constant.urunlerList,
        data: {
          "access_token": Constant.accessToken
        }).catchError((err) {
      print(err);
    });
    return Future.value(UrunlerModel.fromJson(response.data));
  }

  @override
  Future<UrunDetailModel> getUrun(int? id) async{
    var response = await _dio.post(Constant.baseUrl + Constant.urunlerDetails,
        data: {
          "access_token": Constant.accessToken,
          "urun_id": id
        }).catchError((err) {
      print(err);
    });
    //response.data = '"{\"success\":true,\"detail\":{\"id\":12,\"Baslik\":\"FENERBAHÇE-KONYASPORMAÇBİLETİ\",\"Aciklama\":\"FENERBAHÇE-KONYASPORMAÇBİLETİ\",\"Img\":\"adf21fed-70d4-4d99-813f-e6b6b9870471.jpg\",\"Img2\":\"07f1c6f4-8a33-4ad9-be7e-62cf7dd7451b.jpg\",\"Img3\":\"c480399d-7d78-4bf2-971f-510a9292f4ab.jpg\",\"Img4\":\"01686b6b-f78a-4fa1-b033-5b8e8e3d77c7.jpg\",\"Fiyat\":599.9,\"Barkod\":\"b4ccab3e-1d2c-450e-b056-131d8838d014\",\"Date\":\"2023-02-22T13:54:35.517\",\"UpdatedDate\":\"2023-02-22T16:01:33.743\",\"Active\":1},\"bedenList\":[{\"id\":68,\"UrunId\":12,\"UrunFiyat\":599.9,\"BedenId\":0,\"Stok\":1,\"Beden\":\"BEDENSİZ\"}]}"';

    return Future.value(UrunDetailModel.fromJson(response.data));
  }

  @override
  Future<BaseResponse2> siparisVer(int urunId, int bedenId, int adet, String adres)async {
    var response = await _dio.post(Constant.baseUrl + Constant.siparisVer,
        data: {
          "access_token": Constant.accessToken,
          "urun_id": urunId,
          "bedenid":bedenId,
          "adet":adet,
          "adres":adres,
        }).catchError((err) {
      print(err);
    });
    return Future.value(BaseResponse2.fromJson(response.data));
  }

  @override
  Future<SiparisList> siparisler()async {
    var response = await _dio.post(Constant.baseUrl + Constant.siparisler,
        data: {
          "access_token": Constant.accessToken
        }).catchError((err) {
      print(err);
    });
    //response.data = '"{\"success\":true,\"detail\":{\"id\":12,\"Baslik\":\"FENERBAHÇE-KONYASPORMAÇBİLETİ\",\"Aciklama\":\"FENERBAHÇE-KONYASPORMAÇBİLETİ\",\"Img\":\"adf21fed-70d4-4d99-813f-e6b6b9870471.jpg\",\"Img2\":\"07f1c6f4-8a33-4ad9-be7e-62cf7dd7451b.jpg\",\"Img3\":\"c480399d-7d78-4bf2-971f-510a9292f4ab.jpg\",\"Img4\":\"01686b6b-f78a-4fa1-b033-5b8e8e3d77c7.jpg\",\"Fiyat\":599.9,\"Barkod\":\"b4ccab3e-1d2c-450e-b056-131d8838d014\",\"Date\":\"2023-02-22T13:54:35.517\",\"UpdatedDate\":\"2023-02-22T16:01:33.743\",\"Active\":1},\"bedenList\":[{\"id\":68,\"UrunId\":12,\"UrunFiyat\":599.9,\"BedenId\":0,\"Stok\":1,\"Beden\":\"BEDENSİZ\"}]}"';

    return Future.value(SiparisList.fromJson(response.data));
  }
}
