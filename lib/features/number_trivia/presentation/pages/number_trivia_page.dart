import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_app/features/number_trivia/presentation/bloc/bloc/number_trivia_bloc.dart';
import 'package:number_app/features/number_trivia/presentation/pages/trivia_control_page.dart';
import 'package:number_app/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:number_app/features/number_trivia/presentation/widgets/message_widget.dart';
import 'package:number_app/features/number_trivia/presentation/widgets/trivia_widget.dart';
import 'package:number_app/injection_container.dart';

class NumberTriviaPage extends StatefulWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  State<NumberTriviaPage> createState() => _NumberTriviaPageState();
}

class _NumberTriviaPageState extends State<NumberTriviaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TDD & CA"),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => sl<NumberTriviaBloc>(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  // Top half
                  BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                    builder: (context, state) {
                      if (state is Empty) {
                        return const MessageWidget(
                          message: "Start searching !",
                        );
                      } else if (state is Error) {
                        return MessageWidget(
                          message: state.message,
                        );
                      } else if (state is Loading) {
                        return const LoadingWidget();
                      } else if (state is Loaded) {
                        return TriviaWidget(
                          numberTrivia: state.trivia,
                        );
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(height: 20),
                  // Bottom half
                  const TriviaControls(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
