class ReadOnly {
  //String readOnlyId;
  int remainingTime;

  ReadOnly({
    //required this.readOnlyId,
    required this.remainingTime,
  });

  factory ReadOnly.fromJson(dynamic json) => ReadOnly(
        //readOnlyId: json["readOnlyId"],
        remainingTime: json["remainingTime"],
      );
}
