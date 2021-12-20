import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 204,
          width: double.infinity,
          color: Color(0xFFBEDDFF),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Sophistication  ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'MODAL',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                ],
              ),
              Image.asset(
                'images/logo.png',
                alignment: AlignmentDirectional.bottomEnd,
              )
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: GridView(
            padding: EdgeInsets.symmetric(horizontal: 27, vertical: 13),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 160 / 94),
            children: [
              buildElevatedButton(context,route:'/employee_screen',iconImage: 'images/sales_report.png',label: 'Employees'),
              buildElevatedButton(context,route:'/department_screen',iconImage: 'images/sales_report.png',label: 'Departments'),
              buildElevatedButton(context,route:'/reports_screen',iconImage: 'images/sales_report.png',label: 'Reports'),
            ],
          ),
        )],);
  }
  ElevatedButton buildElevatedButton(BuildContext context, {required String route,required String iconImage, required String label}) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconImage,fit: BoxFit.fitHeight,),
          SizedBox(height: 8,),
          Text(label,style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),)
        ],
      ),
      style: ElevatedButton.styleFrom(
          primary: Color(0xFFFFFFFF),
          elevation: 1
      ),
    );
  }}


