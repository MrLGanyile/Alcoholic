class MayBeFake {
  bool? isFake;

  MayBeFake({
    this.isFake = true,
  });

  Map<String, dynamic> toJson() => {
        'Is Fake': isFake! ? 'Yes' : 'No',
      };
}
