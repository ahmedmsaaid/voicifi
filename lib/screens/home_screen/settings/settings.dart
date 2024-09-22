import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voicify/models/colors/app_colors.dart';

import '../../../data/cubits/data_cubit/date_cubit.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black, // أسود رمادي
            Color(0xFF6a1b9a), // لون أرجواني داكن
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          children: [
            CircleAvatar(
              radius: 65,
              backgroundColor: AppColors.blue,
              child: CircleAvatar(
                radius: 60,
                child: ClipOval(
                  child: Image.network(
                    'https://img.freepik.com/free-vector/young-bearded-man_24877-82119.jpg',
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover, // هنا يمكنك استخدام fit المناسب
                  ),
                ),
              ),
            ),
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    ' Ahmed Saaid',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Container(
              child: Column(
                children: [
                  item(
                    Icon(Icons.arrow_forward_ios_outlined),
                    "Ahmed Saaid",
                    "Name",
                  ),
                  item(
                    Icon(Icons.arrow_forward_ios_outlined),
                    "Ahmedsaaid908@gmail.com",
                    "Email",
                  ),
                  item(
                    DropdownButton<String>(
                      borderRadius: BorderRadius.circular(12),
                      dropdownColor: Colors.transparent.withOpacity(0.4),
                      value: DataCubit.get(context).localeId,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        if (value != null) {
                          DataCubit.get(context).setLange(value.toString());
                          print(DataCubit.get(context).localeId);
                        }
                      },
                      items: [
                        DropdownMenuItem<String>(
                          value: 'ar-EG',
                          onTap: () {},
                          child: const Text('عربي'),
                        ),
                        const DropdownMenuItem<String>(
                          value: 'en_US',
                          child: Text('English'),
                        ),
                      ],
                    ),
                    "العربيه",
                    "lang",
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          color: AppColors.transparent,
          height: 80.0,
          width: 120.0,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {},
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.transparent,
                    border: Border.all(color: AppColors.blue),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Log Out',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      size: 15,
                      Icons.logout,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget item(Widget icon, String title, String name) {
  return Padding(
    padding: EdgeInsets.all(12.0),
    child: Container(
      padding: EdgeInsets.zero,
      height: 50.h,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent),
      child: ListTile(
        trailing: icon,
        title: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        leading: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
      ),
    ),
  );
}
