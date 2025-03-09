import 'package:flutter/material.dart';
import 'package:front_end/core/constants/api_constants.dart';
import 'package:front_end/presentation/pages/register_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // String _inputText = '';

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      // Gửi email và password lên server
      final response = await http.post(
        Uri.parse(ApiConstants.apiLogin),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng nhập thành công!')),
        );
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (context) => const LoginScreen()),
        // );
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Đăng ký thất bại!')),
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height, // Chiều cao toàn màn hình
          padding: const EdgeInsets.all(20), // Khoảng cách xung quanh
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Căn giữa nội dung
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Đăng nhập',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // Email
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none),
                        ),
                        filled: true,
                        fillColor: Color(0xFFF1F4FF),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nhập đầy đủ thông tin';
                        } else if (!RegExp(
                                r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                          return 'Email không hợp lệ';
                        }
                        return null;
                      },
                      // onSaved: (value) {
                      //   _inputText = value!;
                      // },
                    ),
                    const SizedBox(height: 20),
                    // Password
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF1F4FF),
                      ),
                      obscureText: true, // Ẩn mật khẩu
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nhập đầy đủ thông tin';
                        } else if (value.length < 6) {
                          return 'Mật khẩu phải có ít nhất 6 ký tự';
                        }
                        return null;
                      },
                      // onSaved: (value) {
                      //   _inputText = value!;
                      // },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Logic khi nhấn nút
                  },
                  child: Text(
                    'Quên mật khẩu?',
                    style: TextStyle(color: Color(0xFF1F41BB)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _submit();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F41BB), // Màu nền
                  foregroundColor: Colors.white, // Màu chữ
                  padding:
                      const EdgeInsets.symmetric(horizontal: 125, vertical: 25),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                child: const Text('Đăng nhập'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Chưa có tài khoản? ',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegisterScreen()));
                    },
                    child: const Text(
                      'Đăng ký',
                      style: TextStyle(color: Color(0xFF1F41BB)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Center(
                child: const Text(
                  'Hoặc đăng nhập bằng',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // Logic khi nhấn nút
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Màu nền
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // Bo góc
                        ),
                        padding: const EdgeInsets.all(25),
                        shadowColor: Colors.grey),
                    child: Icon(
                      Icons.facebook,
                      color: Color(0xFF1F41BB),
                      size: 25,
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Logic khi nhấn nút
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Màu nền
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // Bo góc
                        ),
                        padding: const EdgeInsets.all(25),
                        shadowColor: Colors.grey),
                    child: Icon(
                      Icons.email,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
