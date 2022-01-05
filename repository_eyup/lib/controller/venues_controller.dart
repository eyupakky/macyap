import 'package:dio/dio.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/model/venues_model.dart';
import 'package:repository_eyup/repository/imatches_repository.dart';
import 'package:repository_eyup/repository/ivenues_repository.dart';

class VenuesController {
  IVenuesRepository iVenuesRepository = VenuesRepository(Dio());
  late List<VenusModel> venuesList = [];

  Future<List<VenusModel>> getLazyVenues() async {
    if (venuesList.isEmpty) {
      venuesList = await iVenuesRepository.getLazyVenues();
    }
    return venuesList;
  }
}
