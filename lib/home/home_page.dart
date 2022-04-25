import 'package:flutter/material.dart';
import 'package:getcep/home/bloc/seach_cep_bloc.dart';
import 'package:getcep/home/bloc/search_cep_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchCepBloc = SearchCepBloc();
    final _textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca CEP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              controller: _textController,
              decoration: const InputDecoration(
                label: Text('digite o CEP'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                searchCepBloc.searchCep.add(_textController.text);
              },
              child: const Text(
                'Buscar',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<SearchCepState>(
              stream: searchCepBloc.cepResult,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                var state = snapshot.data!;

                if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is SearchCepError) {
                  return Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                state = state as SearchCepSucess;
                return Text("Cidade é ${state.data['localidade']}");
              },
            ),
          ],
        ),
      ),
    );
  }
}
