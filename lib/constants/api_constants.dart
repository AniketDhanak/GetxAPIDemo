class UrlConstants{
  static const baseUrl = "http://localhost:3000/";
  // static const baseUrl = "http://localhost:3001/api/";
  static const createUser = "";


  static getAllData({required int pageIndex}){
   return 'getAllData?pageIndex=$pageIndex';
  }

  static getAllRegisteredSociety(){
   return 'getAllRegisteredSociety';
  }


}