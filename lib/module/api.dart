// const base = "https://setesapi.herokuapp.com/";
const base = "https://apisetes.herokuapp.com/";

Uri getApi(s) => Uri.parse(base + 'ctaker/' + s);

String getImgProfile(s) => base + 'asset/ctaker/' + s;
String setUserProfile(v1, v2) =>
    base + "asset/members/" + v1.toString() + "/" + v2.toString();
String setUserPro(v) =>
    base + "asset/members/" + v['_id'] + "/" + v['img'];
