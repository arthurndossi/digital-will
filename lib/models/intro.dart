class Intro {
  String title;
  String image;
  String subTitle;
  String buttonText;

  Intro(this.title, this.image, this.subTitle, this.buttonText);

  @override
  String toString() {
    return 'Intro(title: ${this.title}, image: ${this.image}, subTitle: ${this.subTitle}, buttonText: ${this.buttonText})';
  }
}