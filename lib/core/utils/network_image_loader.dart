class NetworkImageLoader{
  Future<String> fetchImageUrl(int randomNumber) async{
    String imageUrl = 'https://picsum.photos/200/300?random=$randomNumber';
    try{
      await Future.delayed(const Duration(seconds: 2));
      if(randomNumber %2 == 0){
        throw Exception("Error during get the url");
      }
      return imageUrl;
    }catch(e){
      throw Exception("Error fetching image!");
    }
  }
}