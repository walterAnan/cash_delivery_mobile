
class ModelClass {
  String title;
  String subtitle;
  String subtitle2;
  String image;
  String description;
  String status;
  String amount;
  String order;
  String date;
  String paymentType;
  String product;

  ModelClass(
      {this.title,
        this.subtitle,
        this.description,
        this.image,
        this.subtitle2,
        this.status,
        this.amount,
        this.order,
        this.paymentType,
        this.product,
        this.date
      });
}

//Select Vehicle
List<ModelClass> vehicleList =[
  ModelClass(title: "Car Delivery",),
  ModelClass(title: "Hel"),
  ModelClass(title: "Van"),
  ModelClass(title: "Cycle"),
  ModelClass(title: "Testcycle"),

];
