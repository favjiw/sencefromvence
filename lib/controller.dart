class Controller {
  String plus7Hour(String datetime) {
    List<String> temp = datetime.split(" ");
    String time = temp[1];

    List<String> iterate = time.split(":");

    iterate[0] = "${int.parse(iterate[0]) + 7}";

    if (iterate[0].length == 1) {
      iterate[0] = "0${iterate[0]}";
    }

    return "${temp[0]} ${iterate.join(":")}";
  }

  String minus7Hour(String datetime) {
    List<String> temp = datetime.split(" ");
    String time = temp[1];

    List<String> iterate = time.split(":");

    iterate[0] = "${int.parse(iterate[0]) - 7}";

    if (iterate[0].length == 1) {
      iterate[0] = "0${iterate[0]}";
    }

    return "${temp[0]} ${iterate.join(":")}";
  }
}