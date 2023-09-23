class StringHelper{

  static String fistValueOfCommaSeparated({String? value}) {
    value ??= "";
    final split = value.split(',');
    for (int i = 0; i < split.length; i++){
      return split[i];
    }
    return defaultProductImage;
  }

  List<String> listOfCommaSeparated({ String? value }){
    value ??= "";
    List<String> list = [];
    if(value.isEmpty) return list;
    final split = value.split(',');
    for (int i = 0; i < split.length; i++){
      if(split[i].trim() != ""){
        list.add(split[i]);
      }
    }
    return list;
  }

  static bool isWithinLast10Days(String? date) {
    if(date == null) return false;
    try{
      DateTime currentDate = DateTime.now();
      DateTime givenDate = DateTime.parse(date);
      Duration difference = currentDate.difference(givenDate);
      return difference.inDays <= 10;
    }catch(e){
      return false;
    }
  }

   static String defaultProductImage = "http://192.168.29.24:3000/static/media/product_demo.043c7181673c49993cfe.png";
   static String termAndConditionLink = "";
   static String customerSupportNo = "";

}