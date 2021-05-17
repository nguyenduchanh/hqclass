
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hqclass/Domains/models/country.dart';

class CountryProvider with ChangeNotifier{
  List<Country> _countries = [];
  List<Country> get countries =>_countries;
  List<Country> _searchResults = [];
  List<Country> get searchResults => _searchResults;
  set searchResults(List<Country> value){
    _searchResults = value;
    notifyListeners();
  }
  Country _selectedCountry = Country();
  Country get selectedCountry => _selectedCountry;
  set selectedCountry(Country value) {
    _selectedCountry = value;
    notifyListeners();
  }
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  CountryProvider(){
    loadCountriesFromJson();
    searchController.addListener(_search);
  }
  Future loadCountriesFromJson() async{
    try{

    }catch(err){

    }
  }
  void _search(){
    String query = searchController.text;
    if(query.length == 0 || query.length == 1){
      searchResults = countries;
    }else{
      List<Country> _results = [];
      countries.forEach((Country c) {
        if(c.toString().toLowerCase().contains(query.toLowerCase())){
          _results.add(c);
        }
      });
      searchResults = _results;
    }
  }
  void resetSearch() {
    searchResults = countries;
  }
}