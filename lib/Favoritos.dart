class Favoritos {
  String id;

  Favoritos({this.id});
}
/// todo: local storage for fav.
var favoritosController = FavoritosController;

class FavoritosController{
  var _favList = <Favoritos>[];

  getall(){
    return _favList;
  }

  add(id){
    return _favList.add(Favoritos(id:id));
  }

  remove(id){
    for (var ids in _favList){
      if (ids.id == id){
        _favList.remove(ids);
      }
    }
  }



}