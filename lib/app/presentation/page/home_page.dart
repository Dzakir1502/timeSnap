import 'package:flutter/material.dart';
import 'package:timesnap/core/widget/bottom_nav_dart.dart';
import 'package:timesnap/core/helper/global_helper.dart'; // Sesuaikan path ini dengan struktur proyek Anda

class Homepage extends StatelessWidget {
  const Homepage({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF0E3C53,
      ), // Dark blue background matching the image
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            children: [
              const HeaderSection(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: const [
                        SizedBox(height: 16),
                        DashboardCard(),
                        SizedBox(height: 16),
                        WorkingTimeSection(),
                        SizedBox(height: 16),
                        ActivitySection(),
                        SizedBox(height: 80), // Add bottom padding for scroll
                      ],
                    ),
                  ),
                ),
              ),
              const BottomNavBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFF0E3C53), // Dark blue background
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white, // White background
            radius: 20,
            child: Icon(
              Icons.person,
              color: Color(0xFF0E3C53), // Dark blue icon
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Abdullah Asshiddiqi',
                  style: GlobalHelper.getTextStyle(
                    context,
                    appTextStyle: AppTextStyle.BODY_MEDIUM,
                  )?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Employee · 2017122EPY',
                  style: GlobalHelper.getTextStyle(
                    context,
                    appTextStyle: AppTextStyle.BODY_SMALL,
                  )?.copyWith(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.settings_outlined,
            color: Colors.white, // White icon
            size: 22,
          ),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Friday, 23 May 2025',
            style: GlobalHelper.getTextStyle(
              context,
              appTextStyle: AppTextStyle.TITLE_MEDIUM,
            )?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCircularProgress(
                context,
                '20',
                'Presence',
                0.8,
                const Color.fromARGB(255, 18, 126, 33),
              ),
              _buildCircularProgress(
                context,
                '10',
                'Sick',
                0.6,
                const Color.fromARGB(255, 250, 4, 4),
              ),
              _buildCircularProgress(
                context,
                '4',
                'Permission',
                0.3,
                const Color.fromARGB(255, 251, 255, 0),
              ),
            ],
          ),
          const SizedBox(height: 16),

        ],
      ),
    );
  }

  Widget _buildCircularProgress(
    BuildContext context,
    String value,
    String label,
    double percentage,
    Color color,
  ) {
    return Column(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Stack(
            children: [
              CircularProgressIndicator(
                value: percentage,
                strokeWidth: 12,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
              Center(
                child: Text(
                  value,
                  style: GlobalHelper.getTextStyle(
                    context,
                    appTextStyle: AppTextStyle.TITLE_MEDIUM,
                  )?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: GlobalHelper.getTextStyle(
            context,
            appTextStyle: AppTextStyle.BODY_SMALL,
          )?.copyWith(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }


}

class WorkingTimeSection extends StatelessWidget {
  const WorkingTimeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Working Time',
            style: GlobalHelper.getTextStyle(
              context,
              appTextStyle: AppTextStyle.TITLE_MEDIUM,
            )?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTimeItem(context, Icons.access_time, '5.5 Hours', Colors.black),
              Container(height: 40, width: 1, color: Colors.grey[300]),
              _buildTimeItem(
                context,
                Icons.directions_car,
                '40 Min',
                const Color(0xFFD32F2F),
              ), // More accurate red color
              Container(height: 40, width: 1, color: Colors.grey[300]),
              _buildTimeItem(context, Icons.watch_later_outlined, '--:--', Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeItem(BuildContext context, IconData icon, String text, Color textColor) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24,
          color: textColor == Colors.grey
              ? Colors.grey
              : (textColor == Colors.black ? const Color(0xFF0E3C53) : textColor),
        ),
        const SizedBox(height: 6),
        Text(
          text,
          style: GlobalHelper.getTextStyle(
            context,
            appTextStyle: AppTextStyle.BODY_MEDIUM,
          )?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }
}

class ActivitySection extends StatelessWidget {
  const ActivitySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Your Activity',
              style: GlobalHelper.getTextStyle(
                context,
                appTextStyle: AppTextStyle.TITLE_MEDIUM,
              )?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text for dark background
              ),
            ),
            Text(
              'See More',
              style: GlobalHelper.getTextStyle(
                context,
                appTextStyle: AppTextStyle.LABEL_MEDIUM,
              )?.copyWith(
                fontSize: 12,
                color: Colors.lightBlue[100], // Closer match to design
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          context,
          icon: Icons.phone_android,
          iconColor: const Color(0xFF0E3C53),
          title: 'Check-In',
          time: '08.50 AM',
          date: 'Friday, 23 May 2025',
          status: 'On-Time',
        ),
        const SizedBox(height: 10),
        _buildActivityItem(
          context,
          icon: Icons.directions_car,
          iconColor: const Color(0xFFD32F2F),
          title: 'Break',
          time: '11.50 AM',
          date: 'Friday, 23 May 2025',
          status: 'Too Early',
          isBreak: true,
        ),
        const SizedBox(height: 10),
        _buildActivityItem(
          context,
          icon: Icons.home_outlined,
          iconColor: Colors.grey,
          title: 'Check-Out',
          time: '--:--',
          date: 'Friday, 23 May 2025',
          status: '--:--',
          isPending: true,
        ),
      ],
    );
  }

  Widget _buildActivityItem(BuildContext context,{
    required IconData icon,
    required Color iconColor,
    required String title,
    required String time,
    required String date,
    required String status,
    bool isBreak = false,
    bool isPending = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_MEDIUM,
                      )?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      time,
                      style: GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_MEDIUM,
                      )?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isBreak
                            ? const Color(0xFFD32F2F)
                            : (isPending ? Colors.grey : Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                    Text(
                      status,
                      style: GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(
                        fontSize: 12,
                        color: isBreak ? const Color(0xFFD32F2F) : Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}