class Offermodel
{
  String  image;
  String ? id;
  DateTime timestamp; 
  Offermodel({
   required this.image,
   this.id, required this.timestamp,
  });

  Map<String,dynamic>tomap()=>{
"Image":image,
'id':id,
 "timestamp": timestamp.toIso8601String(),
  };
  factory Offermodel.fromMap(Map<String, dynamic> data) {
    return Offermodel(
     
      image: data["Image"],
      id: data["id"],
      timestamp: DateTime.parse(data["timestamp"]), 
      
    );
  }
}