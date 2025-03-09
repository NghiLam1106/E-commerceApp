import 'package:flutter/material.dart';
import 'package:front_end/core/constants/api_constants.dart';
import 'package:front_end/presentation/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController =
      TextEditingController(); // Controller để lưu giá trị mật khẩu
  final TextEditingController emailController =
      TextEditingController(); // Controller để lưu giá trị email
  final TextEditingController fullnameController =
      TextEditingController(); // Controller để lưu giá trị full name

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      // Gửi email và password lên server
      final response = await http.post(
        Uri.parse(ApiConstants.apiRegister),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'fullname': fullnameController.text.trim()
        }),
      );

      if (response.statusCode == 201) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Đăng ký thành công!')),
        //   );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
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
          padding: const EdgeInsets.all(20), // Khoảng cách xung quanh
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Căn giữa nội dung
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Đăng ký',
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
                    // Full name
                    TextFormField(
                      controller: fullnameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
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
                        } else if (!RegExp(r"^[a-zA-Z]+([ '-][a-zA-Z]+)*$")
                            .hasMatch(value)) {
                          return 'Username không hợp lệ';
                        }
                        return null;
                      },
                      // onChanged: (value) {
                      //   emailErrorText =
                      // },
                    ),
                    const SizedBox(height: 20),
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
                      // onChanged: (value) {
                      //   emailErrorText =
                      // },
                    ),
                    const SizedBox(height: 20),
                    // Password
                    TextFormField(
                      controller:
                          passwordController, // Gán controller cho password feild
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none),
                        ),
                        filled: true,
                        fillColor: Color(0xFFF1F4FF),
                      ),
                      obscureText: true, // Ẩn mật khẩu
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nhập đầy đủ thông tin';
                        } else if (value.length < 6) {
                          return 'Mật khẩu phải có ít nhất 6 ký tự';
                        } else if (!RegExp(r'^(?=.*[0-9])(?=.*[A-Z]).{7,50}$')
                            .hasMatch(value)) {
                          return 'Mật khẩu không hợp lệ';
                        }
                        return null;
                      },
                      // onSaved: (value) {
                      //   password = value!;
                      // },
                    ),
                    const SizedBox(height: 20),
                    // Confirm password
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none),
                        ), // Ẩn mật khẩu
                        filled: true,
                        fillColor: Color(0xFFF1F4FF),
                      ),
                      obscureText: true, // Ẩn mật khẩu
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nhập đầy đủ thông tin';
                        } else if (value.length < 6) {
                          return 'Mật khẩu phải có ít nhất 6 ký tự';
                        } else if (value != passwordController.text) {
                          return 'Mật khẩu không khớp';
                        }
                        return null;
                      },
                      // onSaved: (value) {
                      //   confirmPassword = value!;
                      // },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  _submit();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F41BB), // Màu nền
                  foregroundColor: Colors.white, // Màu chữ
                  padding:
                      const EdgeInsets.symmetric(horizontal: 135, vertical: 25),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                child: const Text('Đăng ký'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Đã có tài khoản? ',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      'Đăng nhập',
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
                      shadowColor: Colors.grey,
                    ),
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

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    fullnameController.dispose();
    super.dispose();
  }
}
