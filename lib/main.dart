import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/feature/gemini/repository/gemini_repository_impl.dart';
import 'package:flutter_gemini/feature/root_screen/root_screen.dart';
import 'package:flutter_gemini/feature/text_and_image/bloc/text_and_image_bloc.dart';
import 'package:flutter_gemini/feature/text_only/bloc/text_only_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gemini',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<TextOnlyBloc>(
            create: (context) =>
                TextOnlyBloc(geminiRepository: GeminiRepositoryImpl()),
          ),
          BlocProvider(
            create: (context) =>
                TextAndImageBloc(geminiRepository: GeminiRepositoryImpl()),
          )
        ],
        child: const RootScreen(),
      ),
    );
  }
}
