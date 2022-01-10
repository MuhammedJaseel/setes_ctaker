// const base = "https://setesapi.herokuapp.com/";
const base = "https://apisetes.herokuapp.com/";

getApi(s) => Uri.parse(base + 'ctaker/' + s);

getImgProfile(s) => Uri.parse(base + 'asset/ctaker/' + s);
