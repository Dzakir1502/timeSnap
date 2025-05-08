import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesnap/app/presentation/home/home_notifier.dart';
import 'package:timesnap/core/helper/global_helper.dart';
import 'package:timesnap/core/widget/app_widget.dart';

class HomePage extends AppWidget<HomeNotifier, void, void> {
  @override
  Widget bodyBuild(BuildContext context) {
    return SafeArea(child: Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              child: Icon(
                Icons.person,
                size: 40,
              ),
              backgroundColor: GlobalHelper.getColorScheme(context).primaryContainer,
              radius: 30,
            ),
            SizedBox(width: 10,),
            Expanded(
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama Pegawai',
                    style: GlobalHelper.getTextStyle(
                              context,
                              appTextStyle: AppTextStyle.HEADLINE_SMALL,
                            ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                          Icon(Icons.location_city),
                          SizedBox(width: 5,),
                          Text('Office'),
                          ],
                        )
                      ),
                          Expanded(
                        child: Row(
                          children: [
                          Icon(Icons.access_time),
                          Text('Siang'),
                          SizedBox(width: 5,),
                          
                          ],
                        )
                      ),
                    ],
                  )
              
                ],
              ),
            ),
            SizedBox(width: 10,),
            IconButton(onPressed: (){}, icon: Icon(Icons.logout))
          ],

        )
      ],
    ));
  }
}
