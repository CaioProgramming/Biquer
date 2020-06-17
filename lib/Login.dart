import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatelessWidget {
  Login({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(24.0, 630.0),
            child:
                // Adobe XD layer: 'Continue' (group)
                Stack(
              children: <Widget>[
                // Adobe XD layer: 'Rectangle 119' (shape)
                Container(
                  width: 327.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: const Color(0xff2699fb),
                  ),
                ),
                Transform.translate(
                  offset: Offset(133.0, 19.0),
                  child:
                      // Adobe XD layer: 'CONTINUE' (text)
                      SizedBox(
                    width: 62.0,
                    child: Text(
                      'COMEÇAR',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 10,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Adobe XD layer: 'Header' (group)
          Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(-19.0, -322.0),
                child:
                    // Adobe XD layer: 'Title' (group)
                    Stack(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(50.0, 469.0),
                      child:
                          // Adobe XD layer: 'Ut labore et dolore…' (text)
                          SizedBox(
                        width: 313.0,
                        height: 43.0,
                        child: Text(
                          'Antes de começar a anunciar seus serviços, precisamos que realize o cadastro, ok? 😉',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            color: const Color(0xff000000),
                            height: 1.7142857142857142,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(50.0, 397.67),
                      child:
                          // Adobe XD layer: 'Main Title' (text)
                          SizedBox(
                        width: 313.0,
                        height: 45.0,
                        child: SingleChildScrollView(
                            child: Text(
                          'Bico',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 40,
                            color: const Color(0xfffba216),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Transform.translate(
            offset: Offset(24.0, 242.94),
            child:
                // Adobe XD layer: 'Input' (group)
                Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(0.0, 0.0),
                  child:
                      // Adobe XD layer: 'Input' (group)
                      Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(0.0, 0.06),
                        child:
                            // Adobe XD layer: 'Rectangle 85' (shape)
                            Container(
                          width: 327.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            border: Border.all(
                                width: 1.0, color: const Color(0xfff2d3a1)),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(20.0, 8.06),
                        child:
                            // Adobe XD layer: 'Full Name' (text)
                            Text(
                          'Nome completo',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 14,
                            color: const Color(0xffd7dbde),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(0.0, 56.0),
                  child:
                      // Adobe XD layer: 'Input' (group)
                      Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(0.0, 0.06),
                        child:
                            // Adobe XD layer: 'Rectangle 85' (shape)
                            Container(
                          width: 327.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            border: Border.all(
                                width: 1.0, color: const Color(0xfff2d3a1)),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(20.0, 16.06),
                        child:
                            // Adobe XD layer: 'Email' (text)
                            Text(
                          'Email',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 14,
                            color: const Color(0xffd7dbde),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(0.0, 120.0),
                  child:
                      // Adobe XD layer: 'Input' (group)
                      Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(0.0, 0.06),
                        child:
                            // Adobe XD layer: 'Rectangle 85' (shape)
                            Container(
                          width: 327.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            border: Border.all(
                                width: 1.0, color: const Color(0xfff2d3a1)),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(20.0, 16.06),
                        child:
                            // Adobe XD layer: 'Password' (text)
                            Text(
                          'Password',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 14,
                            color: const Color(0xffd7dbde),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(0.0, 184.0),
                  child:
                      // Adobe XD layer: 'Input' (group)
                      Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(0.0, 0.06),
                        child:
                            // Adobe XD layer: 'Rectangle 85' (shape)
                            Container(
                          width: 327.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            border: Border.all(
                                width: 1.0, color: const Color(0xfff2d3a1)),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(20.0, 16.06),
                        child:
                            // Adobe XD layer: 'Confirm Password' (text)
                            Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 14,
                            color: const Color(0xffd7dbde),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(62.0, 580.33),
            child:
                // Adobe XD layer: 'By creating an acco…' (text)
                SizedBox(
              width: 252.0,
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 10,
                    color: const Color(0xff2699fb),
                    height: 2,
                  ),
                  children: [
                    TextSpan(
                      text: 'Ao criar uma conta você concorda com nossos \n',
                    ),
                    TextSpan(
                      text: 'Termos de Serviço e Política de privacidade',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(-6.0, 58.0),
            child:
                // Adobe XD layer: 'Social' (group)
                Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(72.0, 12.0),
                  child:
                      // Adobe XD layer: 'g+' (group)
                      Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(88.0, 449.0),
                        child:
                            // Adobe XD layer: 'Ellipse 41' (shape)
                            Container(
                          width: 56.0,
                          height: 56.0,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(28.0, 28.0)),
                            border: Border.all(
                                width: 1.0, color: const Color(0xffbce0fd)),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(105.0, 464.0),
                        child:
                            // Adobe XD layer: 'g+' (group)
                            Stack(
                          children: <Widget>[
                            Transform.translate(
                              offset: Offset(0.0, 0.0),
                              child:
                                  // Adobe XD layer: 'Rectangle 121' (shape)
                                  Container(
                                width: 27.0,
                                height: 27.0,
                                decoration: BoxDecoration(),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0.0, 5.03),
                              child:
                                  // Adobe XD layer: 'Path 51' (shape)
                                  SvgPicture.string(
                                _svg_zbz3jp,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(174.0, 493.33),
            child:
                // Adobe XD layer: 'By creating an acco…' (text)
                SizedBox(
              width: 16.0,
              child: Text(
                'ou',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 10,
                  color: const Color(0xff2699fb),
                  height: 2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_zbz3jp =
    '<svg viewBox="0.0 5.0 26.8 17.1" ><path transform="translate(0.0, 5.03)" d="M 26.8402099609375 7.381057739257813 L 26.8402099609375 9.897327423095703 L 24.32394027709961 9.897327423095703 L 24.32394027709961 12.41359710693359 L 21.80767059326172 12.41359710693359 L 21.80767059326172 9.729576110839844 L 19.29140090942383 9.729576110839844 L 19.29140090942383 7.381057739257813 L 21.80767059326172 7.381057739257813 L 21.80767059326172 4.864788055419922 L 24.32394027709961 4.864788055419922 L 24.32394027709961 7.381057739257813 L 26.8402099609375 7.381057739257813 Z M 8.555316925048828 7.381057739257813 L 16.60737991333008 7.381057739257813 C 16.60737991333008 7.884312152862549 16.77513122558594 8.219814300537109 16.77513122558594 8.723069190979004 C 16.77513122558594 13.58785724639893 13.58785724639893 17.11063575744629 8.555316925048828 17.11063575744629 C 3.858280181884766 17.11063385009766 0 13.25235366821289 0 8.555316925048828 C 0 3.858280181884766 3.858280181884766 0 8.555316925048828 0 C 10.90383529663086 0 12.74909973144531 0.8387565612792969 14.25886154174805 2.180767059326172 L 11.91034317016602 4.529285430908203 C 11.23933792114258 3.858280181884766 10.23283004760742 3.187275171279907 8.555316925048828 3.187275171279907 C 5.703544139862061 3.187275171279907 3.187274694442749 5.535793781280518 3.187274694442749 8.555317878723145 C 3.187274694442749 11.57484149932861 5.535792827606201 13.92335891723633 8.555316925048828 13.92335891723633 C 11.91034317016602 13.92335891723633 13.25235271453857 11.5748405456543 13.42010498046875 10.23283100128174 L 8.555316925048828 10.23283100128174 L 8.555316925048828 7.381057739257813 Z" fill="#2699fb" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
