import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil {

  checkFirstvisit() async {
    // Memeriksa apakah app pernah dijalankan sebelumnya (first visit or no?)
    bool _firstVisit = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Kalau belum ada variabel first_visit, buat dan lalu set true
    _firstVisit = (prefs.getBool('first_visit') ?? true);
    // Setelah baris ini berarti sudah bukan first visit lagi
    prefs.setBool('first_visit', false);
    // Tetap return hasil pengecekan terakhir
    return _firstVisit;
  }

  // Periksa apakah sedang login
  // Level Hi: login dan valid? (pakenya checkToken), buat kebutuhan auth/penting
  // Level Low: cek true/false login aja, buat kebutuhan lite
  checkLogin() async {
    bool _login = false;
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    _login = (prefs.getBool('login') ?? false);
    //_login = true;
    return _login;
  }

  // Logout
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', false);
  }

  getUsername() async {
    String _username;
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    _username = (prefs.getString('username'));
    prefs.setString('username', _username);
    return _username;
  }

  getPassword() async {
    String _password;
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    _password = (prefs.getString('password'));
    prefs.setString('password', _password);
    return _password;
  }

  getNama() async{
    String _nama;
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    _nama = (prefs.getString('nama'));
    prefs.setString('nama', _nama);
    return _nama;
  }

   getFoto() async{
    String _foto;
     SharedPreferences prefs = await SharedPreferences.getInstance(); 
    _foto = (prefs.getString('foto'));
    prefs.setString('foto', _foto);
    return _foto;  
  }

  // Mengambil variable general (untuk passing parameter)
  getVariable(String namaVariable) async {
    String _valueVariable;
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    _valueVariable = (prefs.getString(namaVariable));
    return _valueVariable; 
  }

  // Mengambil variable general (untuk passing parameter)
  getBoolVariable(String namaVariable) async {
    bool _valueVariable;
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    _valueVariable = (prefs.getBool(namaVariable));
    return _valueVariable; 
  }

  // Menyimpan variable general (untuk passing parameter)
  saveVariable(String namaVariable, String valueVariable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(namaVariable, valueVariable);
  }

  // Menyimpan variable general (untuk passing parameter)
  saveBoolVariable(String namaVariable, bool valueVariable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(namaVariable, valueVariable);
  }

  // Menyimpan variable general (untuk passing parameter)
  destroyVariable(String namaVariable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(namaVariable);
  }

}