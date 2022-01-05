import 'package:dio/src/dio.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/model/venues_model.dart';

abstract class IMatchesRepository{
  Future<List<MatchesModel>> getLazyMatches();
  Future<MatchesModel> getMatch(String id);
}

class MatchesRepository extends IMatchesRepository{
  Dio _dio;
  MatchesRepository(this._dio);


  @override
  Future<List<MatchesModel>> getLazyMatches() async{
    List<MatchesModel> lazyList = [];
    var response =await _dio.get("path");
    response.data[""].map((item){
      lazyList.add(MatchesModel.fromJson(item));
    });
    return Future.value(lazyList);
    Future.value();
  }

  @override
  Future<MatchesModel> getMatch(String id) {
    // TODO: implement getMatche
    throw UnimplementedError();
  }

}