import 'package:bemtevi_app/pages/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:visa/auth-data.dart';
import 'package:visa/discord.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onDone(AuthData authData) {
      print('Logged in!');
      print(authData);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(authData: authData)));
      //TODO: Write redirect to main screen
    }

    final clientID =
        dotenv.env['bemtevi_client_id']; //OAuth client ID (developer portal)
    final clientSecret =
        dotenv.env['bemtevi_client_secret']; //OAuth secret (developer portal)
    final redirectUri = dotenv
        .env['bemtevi_redirect_uri']; //OAuth redirect url (developer portal)
    final scope =
        dotenv.env['bemtevi_app_scopes']; //OAuth scopes (that the url requires)
    final state = 'discordAuth'; //OAuth state (whatever you want)
    return Scaffold(
      body: DiscordAuth().visa.authenticate(
          clientID: clientID,
          clientSecret: clientSecret,
          redirectUri: redirectUri,
          state: state,
          scope: scope,
          onDone: onDone),
    );
  }
}
