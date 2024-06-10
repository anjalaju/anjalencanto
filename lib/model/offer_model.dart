class Offermodel
{
  String  image;
  String ? id;

  Offermodel({
   required this.image,
   this.id
  });

  Map<String,dynamic>tomap()=>{
"Image":image,
'id':id
  };
  factory Offermodel.fromMap(Map<String, dynamic> data) {
    return Offermodel(
     
      image: data["Image"],
      id: data["id"],
    );
  }
}