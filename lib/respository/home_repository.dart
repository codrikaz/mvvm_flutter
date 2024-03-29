import 'package:mvvm_flu/data/network/BaseApiServices.dart';
import 'package:mvvm_flu/data/network/NetworkApiService.dart';
import 'package:mvvm_flu/model/movies_model.dart';
import 'package:mvvm_flu/res/app_url.dart';

class HomeRepository {

  BaseApiServices _apiServices = NetworkApiService() ;

  Future<MovieListModel> fetchMoviesList()async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response = MovieListModel.fromJson(response);

    }catch(e){
      throw e ;
    }
  }

}