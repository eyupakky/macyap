import 'package:dio/dio.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/comment.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/model/siparisler.dart';
import 'package:repository_eyup/model/urunler_model.dart';
import 'package:repository_eyup/model/venues_detail_model.dart';
import 'package:repository_eyup/model/venues_model.dart';
import 'package:repository_eyup/repository/imatches_repository.dart';
import 'package:repository_eyup/repository/ivenues_repository.dart';

import '../model/urun_details.dart';

class VenuesController {
  IVenuesRepository iVenuesRepository = VenuesRepository(Dio());
  late VenusModel venuesList=VenusModel();
  String lastSearch = "";
  Future<VenusModel> getLazyVenues(String? name) async {
    if(venuesList.success==null || name!.isNotEmpty || lastSearch.isNotEmpty) {
      venuesList = await iVenuesRepository.getLazyVenues(name!);
    }
    lastSearch = name;
    return venuesList;
  }
  Future<UrunlerModel> getShoppingList(){
    return Future.value(iVenuesRepository.getShopping());
  }
  Future<SiparisList> siparisler(){
    return Future.value(iVenuesRepository.siparisler());

  }
  Future<VenusDetailModel> getVenuesDetail(int? id) async {
    return Future.value(iVenuesRepository.getVenue(id));
  }
  Future<UrunDetailModel> getShoppingDetail(int? id) async {
    return Future.value(iVenuesRepository.getUrun(id));
  }
  Future<BaseResponse2> siparisVer(int urunId, int bedenId, int adet, String adres){
    return Future.value(iVenuesRepository.siparisVer(urunId,bedenId,adet,adres));
  }
  Future<BaseResponse> venuesFavorite(int? venueId) async {
    return Future.value(iVenuesRepository.venueFollow(venueId));
  }

  Future<MatchesModel> getUpComingGames(int? venueId) async {
    return Future.value(iVenuesRepository.getUpComingGames(venueId));
  }

  Future<Comment> getVenueComments(int? venueId) async {
    return Future.value(iVenuesRepository.getVenueComments(venueId));
  }

  Future<BaseResponse> rateVenue(int? venueId, int? field) async {
    return Future.value(iVenuesRepository.rateVenue(venueId, field));
  }

  Future<RatingResponse> getVenueRates(int? venueId) async {
    return Future.value(iVenuesRepository.getVenueRates(venueId));
  }

  Future<BaseResponse> addVenueComment(int? venueId, String comment) async {
    return Future.value(iVenuesRepository.addVenueComment(venueId, comment));
  }
}
