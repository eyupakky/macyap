import 'package:dio/dio.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/repository/imatches_repository.dart';

class HomeController {
  IMatchesRepository iMatchesRepository = MatchesRepository(Dio());
  Map<String,List<Match>>matchesList = {};
  late bool temp = true;

  Future<List<Match>> getLazyMatches(Map<String, String> map) async {
    String? tarih =map["tarih"];
    if (temp) {
      temp = false;
      var response = await iMatchesRepository.getLazyMatches(map);
      if(tarih!=null && tarih!=""){
        matchesList[tarih]=response;
      }
      temp = true;
    }
    return Future.value(matchesList[tarih]);
  }
}
