import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex/model/pokedex.dart';

class PokemonDetail extends StatefulWidget {
  Pokemon pokemon;

  PokemonDetail({this.pokemon});

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  Color baskinRenk;
  PaletteGenerator paletteGenerator;

  @override
  void initState() {
    super.initState();
    BaskinRengiBul();
  }

  void BaskinRengiBul() {
    Future<PaletteGenerator> futurePaletteGenerator =
        PaletteGenerator.fromImageProvider(NetworkImage(widget.pokemon.img));

    futurePaletteGenerator.then((value) {
      paletteGenerator = value;
      //debugPrint(paletteGenerator.dominantColor.color.toString());

      setState(() {
        baskinRenk = paletteGenerator.dominantColor.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baskinRenk,
      appBar: AppBar(
        backgroundColor: baskinRenk,
        elevation: 0,
        title: Text(
          widget.pokemon.name,
          textAlign: TextAlign.center,
        ),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait)
          return dikeyBody(context);
        else
          return yatayBody(context);
      }),
    );
  }

  Stack dikeyBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          height: MediaQuery.of(context).size.height * (3.5 / 5),
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          top: MediaQuery.of(context).size.height * 0.1,
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 70),
                Text(widget.pokemon.name,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Height:" + widget.pokemon.height),
                Text("Weight:" + widget.pokemon.weight),
                Text(
                  "Types",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.type
                      .map((tip) => Chip(
                          label: Text(
                            tip,
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.deepOrange.shade300))
                      .toList(),
                ),
                Text(
                  "Pre Evolution",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.prevEvolution != null
                      ? widget.pokemon.prevEvolution
                          .map((prevEvolution) => Chip(
                              label: Text(
                                prevEvolution.name,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.deepOrange.shade300))
                          .toList()
                      : [
                          Chip(
                            label: Text("First Version"),
                            backgroundColor: Colors.red.shade700,
                          )
                        ],
                ),
                Text(
                  "Next Evolution",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.nextEvolution != null
                      ? widget.pokemon.nextEvolution
                          .map((evolution) => Chip(
                              label: Text(
                                evolution.name,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.deepOrange.shade300))
                          .toList()
                      : [
                          Chip(
                            label: Text("Last Version"),
                            backgroundColor: Colors.red.shade700,
                          )
                        ],
                ),
                Text(
                  "Weakness",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.weaknesses != null
                      ? widget.pokemon.weaknesses
                          .map((weakness) => Chip(
                              label: Text(
                                weakness,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.deepOrange.shade300))
                          .toList()
                      : [Chip(label: Text("Zayıflığı yok"))],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: widget.pokemon.img,
            child: Container(
              width: 150,
              height: 150,
              child: Image.network(
                widget.pokemon.img,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget yatayBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: MediaQuery.of(context).size.height * (3 / 4),
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.deepOrange),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Hero(
              tag: widget.pokemon.img,
              child: Container(
                width: 200,
                child: Image.network(
                  widget.pokemon.img,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(height: 70),
                  Text(widget.pokemon.name,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Text("Height:" + widget.pokemon.height),
                  Text("Weight:" + widget.pokemon.weight),
                  Text(
                    "Types",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.type
                        .map((tip) => Chip(
                            label: Text(
                              tip,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.deepOrange.shade300))
                        .toList(),
                  ),
                  Text(
                    "Pre Evolution",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.prevEvolution != null
                        ? widget.pokemon.prevEvolution
                            .map((prevEvolution) => Chip(
                                label: Text(
                                  prevEvolution.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.deepOrange.shade300))
                            .toList()
                        : [
                            Chip(
                              label: Text("First version"),
                              backgroundColor: Colors.red.shade700,
                            )
                          ],
                  ),
                  Text(
                    "Next Evolution",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.nextEvolution != null
                        ? widget.pokemon.nextEvolution
                            .map((evolution) => Chip(
                                label: Text(
                                  evolution.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.deepOrange.shade300))
                            .toList()
                        : [
                            Chip(
                              label: Text("Last Version"),
                              backgroundColor: Colors.red.shade700,
                            )
                          ],
                  ),
                  Text(
                    "Weakness",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.weaknesses != null
                        ? widget.pokemon.weaknesses
                            .map((weakness) => Chip(
                                label: Text(
                                  weakness,
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.deepOrange.shade300))
                            .toList()
                        : [Chip(label: Text("Zayıflığı yok"))],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
