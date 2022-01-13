import 'package:dio/dio.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/comment.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/model/venues_detail_model.dart';
import 'package:repository_eyup/model/venues_model.dart';
import 'package:repository_eyup/repository/imatches_repository.dart';
import 'package:repository_eyup/repository/ivenues_repository.dart';

class VenuesController {
  IVenuesRepository iVenuesRepository = VenuesRepository(Dio());
  late VenusModel venuesList;

  Future<VenusModel> getLazyVenues(String? name) async {
    venuesList = await iVenuesRepository.getLazyVenues(name!);
    return venuesList;
  }

  Future<VenusDetailModel> getVenuesDetail(int? id) async {
    return Future.value(iVenuesRepository.getVenue(id));
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
