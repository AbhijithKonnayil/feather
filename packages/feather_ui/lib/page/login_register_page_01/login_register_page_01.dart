import 'package:feather_core/feather_core.dart';
import 'package:feather_ui/component/text_field_01/text_field_01.dart';
import 'package:flutter/material.dart';

part 'login_register_page_01.example.dart';

@PageMeta(
  id: 'login_register_page_01',
  name: 'LoginRegisterPage01',
  description: 'A simple LoginRegisterPage01 component for demo',
  files: [],
  screens: [Screens.mobile, Screens.desktop],
  types: [
    PageType.authPage,
  ],
  categories: [PageCategory.auth],
)
class LoginRegisterPage01 extends StatefulWidget {
  const LoginRegisterPage01({super.key});

  @override
  State<LoginRegisterPage01> createState() => _LoginRegisterPage01State();
}

class _LoginRegisterPage01State extends State<LoginRegisterPage01> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  int currentIndex = 0;
  Alignment tabPosition = Alignment.centerLeft;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.bottomCenter,
                image: AssetImage('assets/images/waves.png'),
              ),
            ),
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 30),
                _buildTabSelector(),
                const SizedBox(height: 20),
                Expanded(
                  child: currentIndex == 0
                      ? _buildLoginTab()
                      : _buildRegisterTab(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 125,
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.bottomRight,
            child: Placeholder(
              fallbackHeight: 200,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSelector() {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          Row(
            children: [
              _buildTabButton('LOGIN', 0),
              _buildTabButton('REGISTER', 1),
            ],
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            alignment: tabPosition,
            child: Container(
              height: 6,
              width: 125,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    final isSelected = currentIndex == index;
    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            currentIndex = index;
            tabPosition = index == 0
                ? Alignment.centerLeft
                : Alignment.centerRight;
          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginTab() {
    return Form(
      key: loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextField(
            emailController,
            'Email',
            false,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          _buildTextField(passwordController, 'Password', true),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: _buildRoundButton(Icons.arrow_forward_ios, _onEmailSignIn),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterTab() {
    return Form(
      key: registerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextField(
            emailController,
            'Email',
            false,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          _buildTextField(passwordController, 'Password', true),
          const SizedBox(height: 10),
          _buildTextField(
            confirmPasswordController,
            'Confirm Password',
            true,
            validator: (value) => value != passwordController.text
                ? 'Passwords do not match'
                : null,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: _buildRoundButton(Icons.arrow_forward_ios, _onRegister),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    bool obscureText, {
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextField01(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      hint: hint,
    );
  }

  Widget _buildRoundButton(IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
      ),
      child: Icon(icon, size: 20),
    );
  }

  void _onEmailSignIn() {
    if (loginFormKey.currentState?.validate() ?? false) {
      debugPrint('Login submitted with email: ${emailController.text}');
    }
  }

  void _onRegister() {
    if (registerFormKey.currentState?.validate() ?? false) {
      debugPrint('Register submitted with email: ${emailController.text}');
    }
  }
}
