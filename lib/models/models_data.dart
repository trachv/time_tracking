class Worker {
  String barcode;
  String fio;
  String photoId;
  String position;

  Worker(this.barcode, this.fio, this.photoId,this.position);

  Worker.fromMap(Map<String, dynamic> map) {
    fio = map['fio'];
    photoId = map['photo_id'];
    position = map['position']; 
  }
}
