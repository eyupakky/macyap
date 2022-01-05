import 'package:dio/dio.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/repository/imatches_repository.dart';

class HomeController {
  IMatchesRepository iMatchesRepository = MatchesRepository(Dio());
  late List<MatchesModel> matchesList=[];
  Future<List<MatchesModel>> getLazyMatches()async{
    if(matchesList.isEmpty) {
      matchesList = await iMatchesRepository.getLazyMatches();
    }
    return matchesList;
  }
}