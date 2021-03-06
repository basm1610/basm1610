import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/modules/web_view/web_view_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: ()
        {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function ? onSubmit,
  Function ? onChange,
  Function ? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData ? suffix,
  Function ? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted :(s)
      {
        onSubmit!(s);
      },
      onChanged: (s)
      {
        onChange!(s);
      },
      onTap: ()
      {
        onTap!();
      },
      validator: (s)
      {
        validate(s);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: ()
          {
            suffixPressed!();
          },
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );
Widget buildTaskItem(Map model, BuildContext context) =>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 40.0,
        child: Text(
          '${model['time']}',
        ),
      ),
      SizedBox(
        width: 20,
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${model['title']}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${model['date']}',
            style: TextStyle(
              color:  Colors.grey,
            ),
          ),
        ],
      ),
    ],
  ),
);

Widget tasksBuilder({
  required List<Map> tasks,
}) => BuildCondition (
  condition: tasks.length > 0,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index)
    {
      return buildTaskItem(tasks[index], context);
    },
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    ),
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet, Please Add Some Tasks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);
Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(article,context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(
  
      padding: const EdgeInsets.all(20.0),
  
      child: Row(
  
        children: [
  
          Container(
  
            width: 120.0,
  
            height: 120.0,
  
            decoration: BoxDecoration(
  
              borderRadius: BorderRadius.circular(10.0),
  
              image: DecorationImage(
  
                image: NetworkImage('${article['urlToImage']}'),
  
                fit: BoxFit.cover,
  
              ),
  
            ),
  
          ),
  
          SizedBox(
  
            width: 20.0,
  
          ),
  
          Expanded(
  
            child: Container(
  
              height: 120.0,
  
              child: Column(
  
                mainAxisSize:MainAxisSize.min,
  
                crossAxisAlignment: CrossAxisAlignment.start,
  
                children: [
  
                  Expanded(
  
                    child: Text(
  
                      '${article['title']}',
  
                      style: Theme.of(context).textTheme.bodyText1,
  
                      maxLines: 3,
  
                      overflow: TextOverflow.ellipsis,
  
                    ),
  
                  ),
  
                  Text(
  
                    '${article['publishedAt']}',
  
                    style: TextStyle(
  
                      color: Colors.grey,
  
                    ),
  
                  ),
  
                ],
  
              ),
  
            ),
  
          ),
  
        ],
  
      ),
  
    ),
);

Widget articleBuilder(list,context, { bool? isSearch}) => BuildCondition(
  condition: list.length>0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context , index) =>buildArticleItem(list[index],context),
    separatorBuilder: (context , index) => myDivider(),
    itemCount: 10,
  ),
  fallback: (context) =>Center(child: CircularProgressIndicator()),


);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);


