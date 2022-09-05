import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';
import 'package:submissionform/DbHelper.dart';
import 'package:submissionform/viewpage.dart';

class firstpage extends StatefulWidget {
  // const firstpage({Key? key}) : super(key: key);

  Map? m;

  firstpage({this.m});

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  String gvalue = "";

  bool _password = true;
  bool _password1 = true;

  /* bool C = false;
  bool Cplusplus = false;
  bool JAVA = false;
  bool DART = false;
  bool FLUTTER = false;
*/
  TextEditingController _name = TextEditingController();
  TextEditingController _contact = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _pass1 = TextEditingController();

  int _c = 0;
  int _cplus = 0;
  int _java = 0;
  int _dart = 0;
  int _flutter = 0;

  Database? db;

  @override
  void initState() {
    super.initState();

    DbHelper().createDatabase().then((value) {
      db = value;
    });

    if (widget.m != null) {
      _name.text = widget.m!['name'];
      _contact.text = widget.m!['contact'];
      _email.text = widget.m!['email'];
      _pass.text = widget.m!['password'];
      _pass1.text = widget.m!['confirmpassword'];
      gvalue = widget.m!['gender'];
      _c = widget.m!['c'];
      _cplus = widget.m!['c1'];
      _java = widget.m!['java'];
      _dart = widget.m!['dart'];
      _flutter = widget.m!['flutter'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(title: Text("SUBMISSION FORM")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 11),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _name,
                  cursorHeight: 30,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Username",
                      helperText: "Enter First Character in Capital",
                      prefixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.account_circle_rounded, size: 30))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _email,
                  cursorHeight: 30,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email-id",
                      helperText: "Enter Your Email Id",
                      prefixIcon:
                      IconButton(onPressed: () {}, icon: Icon(Icons.email))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _contact,
                  cursorHeight: 30,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Mobile Number",
                      helperText: "Enter Your Mobile Number",
                      prefixIcon:
                      IconButton(onPressed: () {}, icon: Icon(Icons.phone))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _pass,
                  obscureText: _password,
                  cursorHeight: 30,
                  keyboardType: TextInputType.name,
                  maxLength: 8,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      helperText: "Create Your Password",
                      prefixIcon:
                      IconButton(onPressed: () {}, icon: Icon(Icons.lock)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _password = !_password;
                            });
                          },
                          icon: Icon(_password
                              ? Icons.visibility_off
                              : Icons.visibility))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                    controller: _pass1,
                    obscureText: _password1,
                    cursorHeight: 30,
                    keyboardType: TextInputType.name,
                    maxLength: 8,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Confirm Your Password",
                        helperText: "Enter Your Password",
                        prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.lock_outline_sharp)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _password1 = !_password1;
                              });
                            },
                            icon: Icon(_password1
                                ? Icons.visibility_off
                                : Icons.visibility)))),
                SizedBox(
                  height: 0,
                ),
                Row(
                  children: [
                    Text(
                      "Gender :",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Radio(
                      onChanged: (value) {
                        setState(() {
                          gvalue = value.toString();
                        });
                      },
                      value: "Male",
                      groupValue: gvalue,
                    ),
                    Text(
                      "Male",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    Radio(
                      onChanged: (value) {
                        setState(() {
                          gvalue = value.toString();
                        });
                      },
                      value: "Female",
                      groupValue: gvalue,
                    ),
                    Text(
                      "Female",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    Radio(
                      onChanged: (value) {
                        setState(() {
                          gvalue = value.toString();
                        });
                      },
                      value: "Others",
                      groupValue: gvalue,
                    ),
                    Text(
                      "Others",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),

                // SizedBox(
                //   height: 2,
                // ),

                SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Text(
                          "Languages :",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              Checkbox(
                                onChanged: (value) {
                                  // print(value);
                                  setState(() {
                                    _c = value! ? 1 : 0;
                                  });
                                },
                                value: _c == 1 ? true : false,
                              ),
                              Text(
                                "C Language",
                                style:
                                TextStyle(fontSize: 16, color: Colors.black),
                              ),
                              Checkbox(
                                onChanged: (value) {
                                  // print(value);
                                  setState(() {
                                    _cplus = value! ? 1 : 0;
                                  });
                                },
                                value: _cplus == 1 ? true : false,
                              ),
                              Text(
                                "C++ Language",
                                style:
                                TextStyle(fontSize: 16, color: Colors.black),
                              ),
                              Checkbox(
                                onChanged: (value) {
                                  // print(value);
                                  setState(() {
                                    _java = value! ? 1 : 0;
                                  });
                                },
                                value: _java == 1 ? true : false,
                              ),
                              Text(
                                "JAVA Language",
                                style:
                                TextStyle(fontSize: 16, color: Colors.black),
                              ),
                              Checkbox(
                                onChanged: (value) {
                                  // print(value);
                                  setState(() {
                                    _dart = value! ? 1 : 0;
                                  });
                                },
                                value: _dart == 1 ? true : false,
                              ),
                              Text(
                                "DART Language",
                                style:
                                TextStyle(fontSize: 16, color: Colors.black),
                              ),
                              Checkbox(
                                onChanged: (value) {
                                  // print(value);
                                  setState(() {
                                    _flutter = value! ? 1 : 0;
                                  });
                                },
                                value: _flutter == 1 ? true : false,
                              ),
                              Text(
                                "FLUTTER Language",
                                style:
                                TextStyle(fontSize: 16, color: Colors.black),
                              ),
                            ]),
                          ),
                        ),
                        // CheckboxListTile(value: value, onChanged: onChanged)
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      String name = _name.text;
                      String contact = _contact.text;
                      String email = _email.text;
                      String password = _pass.text;
                      String conpass = _pass1.text;

                      if (widget.m == null) {
                        String qry =
                            "insert into Test (name,email,contact,password,confirmpassword,gender,c,c1,java,dart,flutter) values('$name','$email','$contact','$password','$conpass','$gvalue','$_c','$_cplus','$_java','$_dart','$_flutter')";

                        int a = await db!.rawInsert(qry);

                        print(a);

                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return viewpage();
                          },
                        ));
                      } else {
                        int id = widget.m!['id'];

                        String qry =
                            "update Test set name='$name',email='$email',contact='$contact',password='$password',confirmpassword='$conpass',gender='$gvalue',c='$_c',c1='$_cplus',java='$_java',dart='$_dart',flutter='$_flutter',C='$_c' where id = '$id'";

                        int a = await db!.rawUpdate(qry);

                        print(a);

                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return viewpage();
                          },
                        ));
                      }
                    },
                    child: Text(
                      widget.m != null ? "SUBMIT" : "Save",
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
          ),
        ),
      ),
    ), onWillPop: goback);
  }


  Future<bool> goback() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return viewpage();
    },));
    return Future.value();
  }
}
/*  Demo on Textfiled ->
*
*             TextField(
              obscureText: false,
              // textAlign: TextAlign.center,
              keyboardType: TextInputType.name,
              textDirection: TextDirection.ltr,
              textCapitalization: TextCapitalization.words,
              // maxLength: 10 ,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
                  // errorText: "Enter Your Full Name",
                  hintText: "Username",
                  helperText: "Enter First Character in Capital",
                  fillColor: Colors.black12,
                  filled: true,
                  prefix: Text("Mr. "),
                  // prefixText:  "hello",
                // iconColor: Colors.black,
                  prefixIcon: IconButton(onPressed: () {

                  }, icon: Icon(Icons.email_outlined,),
              ),
                suffix: IconButton(onPressed: () {

                }, icon: Icon(Icons.visibility))
            ),
            ),
 */
