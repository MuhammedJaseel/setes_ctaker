const base = "https://setes.in:8000/";

Uri wsUrl(s) => Uri.parse('wss://setes.in:8000/ctakers/' + s);

Uri getApi(s) => Uri.parse(base + 'ctaker/' + s);

String getImgProfile(s) => base + 'asset/ctaker/' + s;
String setUserProfile(v1, v2) =>
    base + "asset/members/" + v1.toString() + "/" + v2.toString();
String setUserPro(v) => base + "asset/members/" + v['_id'] + "/" + v['img'];
