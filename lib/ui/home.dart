import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/root/pallet.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> funcionarios = [];
  int indice = 0;

  @override
  void initState() {
    super.initState();
    carregarMockupJSON();
  }

  Future<void> carregarMockupJSON() async {
    String dados = await rootBundle.loadString(
      'assets/mockup/funcionarios.json',
    );

    setState(() {
      funcionarios = json.decode(dados);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Funcionários do Mês")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.p1,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.p2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<dynamic>(
                borderRadius: BorderRadius.circular(8),
                isExpanded: true,
                underline: const SizedBox.shrink(),
                value: funcionarios.isNotEmpty ? funcionarios[indice] : null,
                items: funcionarios.map((funcionario) {
                  return DropdownMenuItem<dynamic>(
                    value: funcionario,
                    child: Text(funcionario['nome']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    indice = funcionarios.indexOf(value);
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              funcionarios.isNotEmpty
                  ? funcionarios[indice]['nome']
                  : "Nome do Funcionário",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromARGB(255, 136, 180, 137),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.p2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),

                      child: funcionarios.isNotEmpty
                          ? Image.network(
                              funcionarios[indice]['avatar'],
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,

                              errorBuilder: (context, exception, stackTrace) {
                                return Image.asset(
                                  'assets/funcionarios.png',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              'assets/funcionarios.png',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      funcionarios.isNotEmpty
                          ? funcionarios[indice]['cargo']
                          : "",
                    ),

                    const SizedBox(height: 10),

                    Text(
                      funcionarios.isNotEmpty
                          ? "R\$ ${funcionarios[indice]['salario'].toStringAsFixed(3).replaceAll('.', ',')}"
                          : "R\$ 0,00",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: indice > 0
                      ? () {
                          setState(() {
                            indice--;
                          });
                        }
                      : null,
                  child: const Text("Anterior"),
                ),

                ElevatedButton(
                  onPressed: indice < funcionarios.length - 1
                      ? () {
                          setState(() {
                            indice++;
                          });
                        }
                      : null,
                  child: const Text("Próximo"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
