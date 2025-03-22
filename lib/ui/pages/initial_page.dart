import 'package:flutter/material.dart';
import 'package:trabalho_flutter/ui/pages/about_page.dart';
import 'package:trabalho_flutter/ui/widgets/field_text.dart';
import 'package:carousel_slider/carousel_slider.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final _heightController = TextEditingController();
  final _wheightController = TextEditingController();

  void _calcularIMC(BuildContext context) {
    if (_wheightController.text.isEmpty) {
      // Exibe um AlertDialog informando que o peso está vazio
      _showErrorDialog(context, 'Peso sem valor !!!');
      return;
    }

    if (_heightController.text.isEmpty) {
      // Exibe um AlertDialog informando que a altura está vazia
      _showErrorDialog(context, 'Altura sem valor !!!');
      return;
    }

    // Verifica se a altura tem um ponto (.) para ser considerada um número decimal
    if (!_heightController.text.contains('.') ||
        _heightController.text.endsWith('.')) {
      // Exibe um AlertDialog informando que a altura não está no formato correto
      _showErrorDialog(
        context,
        'Digite a altura no formato correto (ex: 1.50)',
      );
      return;
    }

    // Tenta converter os valores para double
    try {
      double peso = double.parse(_wheightController.text);
      double altura = double.parse(_heightController.text);

      // Verifica se a altura é válida (não pode ser zero ou negativa)
      if (altura <= 0) {
        // Exibe um AlertDialog informando que a altura é inválida
        _showErrorDialog(context, 'Altura inválida');
        return;
      }

      // Calcula o IMC
      double imc = peso / (altura * altura);

      // Mostra o resultado com um AlertDialog
      _showResultDialog(context, imc);
    } catch (e) {
      // Se ocorrer um erro na conversão dos valores
      _showErrorDialog(context, 'Valor inválido');
    }
  }

  // Função para exibir o AlertDialog com o resultado
  void _showResultDialog(BuildContext context, double imc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Align(
            alignment: Alignment.center, 
            child: Text(
              'Resultado do IMC',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Seu IMC é:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                imc.toStringAsFixed(2),                 style: TextStyle(
                  fontSize: 30,
                  color: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                _getIMCMessage(imc),
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurpleAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                },
                child: Text(
                  'Fechar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Estilo do texto
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Função para categorizar o IMC
  String _getIMCMessage(double imc) {
    if (imc < 18.5) {
      return 'Você está abaixo do peso.';
    } else if (imc >= 18.5 && imc <= 24.9) {
      return 'Você está com o peso normal.';
    } else if (imc >= 25 && imc <= 29.9) {
      return 'Você está com sobrepeso.';
    } else {
      return 'Você está obeso.';
    }
  }

  // Função para exibir o AlertDialog de erro
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Align(
            alignment: Alignment.center, // Centraliza o título
            child: Text(
              'ERROR',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          content: Text(
            message,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                },
                child: Text(
                  'Fechar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Estilo do texto
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _abrirTelaSobre() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Trabalho Flutter',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
          actions: [
            IconButton(
              onPressed: _abrirTelaSobre,
              icon: Icon(Icons.help_outline),
              color: Colors.white,
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                items: [
                  Image.asset('assets/images/img1.jpg', fit: BoxFit.cover),
                  Image.asset('assets/images/img2.png', fit: BoxFit.cover),
                ],
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,

                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  autoPlayInterval: const Duration(seconds: 3),
                ),
              ),
              const SizedBox(height: 20),
              // Campos Peso e Altura
              FieldText(
                _wheightController,
                'Peso(Kg)',
                icon: Icon(
                  Icons.fitness_center,
                  color: Colors.deepPurpleAccent,
                ),
              ),
              FieldText(
                _heightController,
                'Altura(Metro e cm,separado por ponto)',
                icon: Icon(Icons.height, color: Colors.deepPurpleAccent),
              ),
              ElevatedButton(
                onPressed: () => _calcularIMC(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                ),
                child: Text('Calcular IMC', style: TextStyle(fontSize: 15)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
