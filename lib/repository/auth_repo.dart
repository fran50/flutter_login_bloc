import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  login(String email, String password) async {
    var res = await http.post("http://192.168.1.128:3000/login",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({"email": email, "password": password}));

    final data = json.decode(res.body);

    if (data['ok'] == true) {
      print('bien');
      print(data);
      return data;
    } else {
      print('mal');
      print(data);
      return "tenemos un fallo en la Api";
    }
  }
}
