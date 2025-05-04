import 'package:flutter/material.dart';
import 'package:timesnap/core/helper/global_helper.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.home, 'Home', true),
          _buildNavItem(context, Icons.watch_later_outlined, 'Attendance', false),
          _buildNavItem(context, Icons.calendar_today_outlined, 'Schedule', false),
          _buildNavItem(context, Icons.person_outline, 'Profile', false),
        ],
      ),
    );
  }

  Widget _buildNavItem( BuildContext context,IconData icon, String label, bool isActive) {
    final Color activeColor = const Color(0xFF0A3256); // Dark blue to match the app theme
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive ? activeColor.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isActive ? activeColor : Colors.grey,
            size: 22,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GlobalHelper.getTextStyle(  
                  context,
                  appTextStyle: AppTextStyle.BODY_SMALL,

                )?.copyWith(
                  fontSize: 12,fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  color: isActive ? activeColor : Colors.grey,
                ),
          // TextStyle(
          //   fontSize: 11,
          //   fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          //   color: isActive ? activeColor : Colors.grey,
          // ),
        ),
      ],
    );
  }
}