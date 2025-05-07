import 'package:flutter/material.dart';
import 'package:timesnap/app/presentation/intro/login_notifier.dart';
import 'package:timesnap/core/helper/global_helper.dart';
import 'package:timesnap/core/widget/app_widget.dart';

class LoginPage extends AppWidget<LoginNotifier, void, void> {
  @override
  Widget bodyBuild(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF0E3C53), // Darker navy blue that matches the image
      ),
      child: Stack(
        children: [
          // Login text at top
          Positioned(
            top: MediaQuery.of(context).size.height * 0.13,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/Logo.png',
                width: 220, // Adjust the width as needed
                height: 50, // Adjust the height as needed
              ),
            ),
          ),

          // Wave-like curved background
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.8,
              ),
              painter: CurvedBackgroundPainter(),
            ),
          ),

          // Content inside the white area
          Positioned(
            top: MediaQuery.of(context).size.height * 0.42,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome text
                    Text(
                      "Login ",
                      style: GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0E3C53),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Enter Your Email",
                      style: GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0E3C53),
                      ),
                    ),
                    TextField(
                      style: GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(fontSize: 14, color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: "Your email",
                        hintStyle: GlobalHelper.getTextStyle(
                          context,
                          appTextStyle: AppTextStyle.BODY_SMALL,
                        )?.copyWith(fontSize: 14, color: Colors.grey[400]),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF0E3C53)),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 24),

                    // Password field
                    Text(
                      "Password",
                      style: GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0E3C53),
                      ),
                    ),
                    TextField(
                      style: GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(fontSize: 14, color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: "Your password at least 8 character",
                        hintStyle: GlobalHelper.getTextStyle(
                          context,
                          appTextStyle: AppTextStyle.BODY_SMALL,
                        )?.copyWith(fontSize: 14, color: Colors.grey[400]),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF0E3C53)),
                        ),
                        // suffixIcon: IconButton(
                        //   icon: Icon(
                        //     _obscurePassword
                        //         ? Icons.visibility_off
                        //         : Icons.visibility,
                        //     color: Colors.grey,
                        //     size: 20,
                        //   ),

                        // ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Sign Up button
                    Container(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: _onPressLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0E3C53),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Sign In",
                          style: GlobalHelper.getTextStyle(
                            context,
                            appTextStyle: AppTextStyle.BODY_SMALL,
                          )?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // Add more space at the bottom to match the image
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onPressLogin(){}
}









// import 'package:flutter/material.dart';

// import 'package:timesnap/core/helper/global_helper.dart'; 

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _obscurePassword = true;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();   
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           color: Color(0xFF0E3C53), // Darker navy blue that matches the image
//         ),
//         child: Stack(
//           children: [
//             // Login text at top
//             Positioned(
//               top: MediaQuery.of(context).size.height * 0.13,
//               left: 0,
//               right: 0,
//               child: Center(
//                 child: Image.asset(
//                   'assets/images/Logo.png',
//                   width: 220, // Adjust the width as needed
//                   height: 50, // Adjust the height as needed
//                 ),
//               ),
//             ),
            
//             // Wave-like curved background
//             Positioned(
//               top: MediaQuery.of(context).size.height * 0.2,
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: CustomPaint(
//                 size: Size(MediaQuery.of(context).size.width, 
//                           MediaQuery.of(context).size.height * 0.8),
//                 painter: CurvedBackgroundPainter(),
//               ),
//             ),
            
//             // Content inside the white area
//             Positioned(
//               top: MediaQuery.of(context).size.height * 0.42,
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Welcome text
//                       Text(
//                         "Login ",
//                               style:
//                               GlobalHelper.getTextStyle(  
//                               context,
//                         appTextStyle: AppTextStyle.BODY_SMALL,

//                       )?.copyWith(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                         color:const Color(0xFF0E3C53),
//                       ),

//                       ),
//                       const SizedBox(height: 40),
//                       Text(
//                         "Enter Your Email",
//                         style: GlobalHelper.getTextStyle(  
//                         context,
//                         appTextStyle: AppTextStyle.BODY_SMALL,

//                       )?.copyWith(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: const Color(0xFF0E3C53),
//                       ),

//                       ),
//                       TextField(
//                         controller: _emailController,
//                           style: GlobalHelper.getTextStyle(  
//                           context,
//                           appTextStyle: AppTextStyle.BODY_SMALL,
//                         )?.copyWith(
//                             fontSize: 14,
//                             color: Colors.black87,
//                         ),
//                         decoration: InputDecoration(
//                           hintText: "Your email",
//                           hintStyle: GlobalHelper.getTextStyle(  
//                           context,
//                           appTextStyle: AppTextStyle.BODY_SMALL,
//                         )?.copyWith(                  
//                             fontSize: 14,
//                             color: Colors.grey[400],
//                         ),
//                           contentPadding: const EdgeInsets.symmetric(vertical: 0),
//                           enabledBorder: const UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: const UnderlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xFF0E3C53)),
//                           ),
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                       ),
                      
//                       const SizedBox(height: 24),
                      
//                       // Password field
//                       Text(
//                         "Password",
//                         style: GlobalHelper.getTextStyle(  
//                           context,
//                           appTextStyle: AppTextStyle.BODY_SMALL,
//                         )?.copyWith(
//                             fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: const Color(0xFF0E3C53),
//                         ),

//                       ),
//                       TextField(
//                         controller: _passwordController,
//                         obscureText: _obscurePassword,
//                         style: GlobalHelper.getTextStyle(  
//                           context,
//                           appTextStyle: AppTextStyle.BODY_SMALL,
//                         )?.copyWith(
//                           fontSize: 14,
//                           color: Colors.black87,
//                         ),
//                         decoration: InputDecoration(
//                           hintText: "Your password at least 8 character",
//                           hintStyle:GlobalHelper.getTextStyle(  
//                           context,
//                           appTextStyle: AppTextStyle.BODY_SMALL,
//                         )?.copyWith(
//                             fontSize: 14,
//                             color: Colors.grey[400],
//                         ),
//                           contentPadding: const EdgeInsets.symmetric(vertical: 0),
//                           enabledBorder: const UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: const UnderlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xFF0E3C53)),
//                           ),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                               color: Colors.grey,
//                               size: 20,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _obscurePassword = !_obscurePassword;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
                      
//                       const SizedBox(height: 40),
                      
//                       // Sign Up button
//                       Container(
//                         width: double.infinity,
//                         height: 48,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Add sign up logic here
//                             print("Sign Up button pressed");
//                             print("Email: ${_emailController.text}");
//                             print("Password: ${_passwordController.text}");
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF0E3C53),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: Text(
//                             "Sign In",
//                             style:GlobalHelper.getTextStyle(  
//                           context,
//                           appTextStyle: AppTextStyle.BODY_SMALL,
//                         )?.copyWith(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white,
//                         ),
//                           ),
//                         ),
//                       ),
                      
//                       // Add more space at the bottom to match the image
//                       const SizedBox(height: 80),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Custom painter to create the wave-like background with 3-4 layers of curves
class CurvedBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Multi-layer curved background with different shades of blue
    _drawCurve(canvas, size, const Color.fromARGB(255, 28, 79, 109), 0.0); // Darker blue layer
    _drawCurve(canvas, size, const Color.fromARGB(255, 71, 135, 167), 0.03); // Medium blue layer  
    _drawCurve(canvas, size, const Color.fromARGB(255, 203, 221, 230), 0.06); // Lighter blue layer
    _drawCurve(canvas, size, Colors.white, 0.09); // White base layer
  }
  
  void _drawCurve(Canvas canvas, Size size, Color color, double offset) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final path = Path();
    
    // Starting point
    path.moveTo(0, size.height * (0.18 + offset));
    
    // Create the curved top
    path.quadraticBezierTo(
      size.width * 0.5, // Control point x
      size.height * (0.0 + offset), // Control point y - this creates the curve
      size.width, // End point x
      size.height * (0.18 + offset), // End point y
    );
    
    // Complete the shape
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}