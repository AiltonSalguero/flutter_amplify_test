import 'package:flutter/material.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterAwsAmplifyCognito.initialize().then((UserStatus status) {
      switch (status) {
        case UserStatus.GUEST:
          break;
        case UserStatus.SIGNED_IN:
          // TODO: Handle this case.
          break;
        case UserStatus.SIGNED_OUT:
          print("ESTADO DE SIGNT OU");
          break;
        case UserStatus.SIGNED_OUT_FEDERATED_TOKENS_INVALID:
          // TODO: Handle this case.
          break;
        case UserStatus.SIGNED_OUT_USER_POOLS_TOKENS_INVALID:
          // TODO: Handle this case.
          break;
        case UserStatus.UNKNOWN:
          // TODO: Handle this case.
          break;
        case UserStatus.ERROR:
          // TODO: Handle this case.
          break;
      }
    }).catchError((error) {
      print(error);
    });

    FlutterAwsAmplifyCognito.confirmSignUp("jesus.baza.loz@gmail.com", "194557")
        .then((SignUpResult result) {
      if (!result.confirmationState) {
        final UserCodeDeliveryDetails details = result.userCodeDeliveryDetails;
        print(details.destination);
      } else {
        print("Sign up Done");
      }
    }).catchError((error) {
      print(error);
    });
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  signup() {
    final username = "jesus.baza.loz@gmail.com";
    final password = "Number123";

    Map<String, String> userAttributes = Map<String, String>();
    userAttributes['email'] = 'jesus.baza.loz@gmail.com';

    FlutterAwsAmplifyCognito.signUp(username, password, userAttributes)
        .then((SignUpResult result) {
      if (!result.confirmationState) {
        final UserCodeDeliveryDetails details = result.userCodeDeliveryDetails;
        print(details.destination);
      } else {
        print('Sign Up Done!');
      }
    }).catchError((error) {
      print(error);
    });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
