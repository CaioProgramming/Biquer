import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DocumentsScreen extends StatelessWidget {
  DocumentsScreen({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(24.0, 685.0),
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
                  offset: Offset(128.0, 19.0),
                  child:
                      // Adobe XD layer: 'CONTINUE' (text)
                      SizedBox(
                    width: 72.0,
                    child: Text(
                      'CONTINUAR',
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
          Transform.translate(
            offset: Offset(0.0, 0.0),
            child:
                // Adobe XD layer: 'Navigation Bar' (group)
                Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(-4907.0, -1089.0),
                  child:
                      // Adobe XD layer: 'Merged bar' (group)
                      Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(4907.0, 1089.0),
                        child:
                            // Adobe XD layer: 'Rectangle 68' (shape)
                            Container(
                          width: 375.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: const Color(0xfffba216),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(4907.0, 1109.0),
                        child:
                            // Adobe XD layer: 'Rectangle 69' (shape)
                            Container(
                          width: 375.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: const Color(0xfffba216),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(148.0, 37.0),
                  child:
                      // Adobe XD layer: 'SIGN UP' (text)
                      SizedBox(
                    width: 80.0,
                    child: Text(
                      'CADASTRO',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 12,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(16.0, 36.0),
                  child:
                      // Adobe XD layer: 'Backward arrow' (group)
                      Stack(
                    children: <Widget>[
                      // Adobe XD layer: 'Path 10' (shape)
                      SvgPicture.string(
                        _svg_pkfj6b,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(24.0, 92.0),
            child: SizedBox(
              width: 327.0,
              height: 140.0,
              child: Text(
                'Precisamos agora de uma foto frente e verso de seus documentos, não se preocupe os seus dados serão protegidos e coletamos apenas para sua segurança e a segurança dos clientes.\nLembre-se de fotografar corretamente, para que sua aprovação ocorra o mais rápido possível.',
                style: TextStyle(
                  fontFamily: 'Adobe Clean',
                  fontSize: 16,
                  color: const Color(0xff505050),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(24.0, 277.0),
                child: Container(
                  width: 327.0,
                  height: 162.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13.0),
                    color: const Color(0xfff3f3f3),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(160.76, 327.56),
                child:
                    // Adobe XD layer: 'Icon metro-file-ima…' (shape)
                    SvgPicture.string(
                  _svg_nx8zoq,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
              Transform.translate(
                offset: Offset(4.0, 248.17),
                child: SizedBox(
                  width: 240.0,
                  child: Text(
                    'Frente do documento',
                    style: TextStyle(
                      fontFamily: 'Adobe Clean',
                      fontSize: 22,
                      color: const Color(0xff323232),
                      fontWeight: FontWeight.w700,
                      height: 1.300000017339533,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          Transform.translate(
            offset: Offset(0.0, 209.0),
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(24.0, 277.0),
                  child: Container(
                    width: 327.0,
                    height: 162.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.0),
                      color: const Color(0xfff3f3f3),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(160.76, 327.56),
                  child:
                      // Adobe XD layer: 'Icon metro-file-ima…' (shape)
                      SvgPicture.string(
                    _svg_nx8zoq,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Transform.translate(
                  offset: Offset(9.0, 248.17),
                  child: SizedBox(
                    width: 230.0,
                    child: Text(
                      'Verso do documento',
                      style: TextStyle(
                        fontFamily: 'Adobe Clean',
                        fontSize: 22,
                        color: const Color(0xff323232),
                        fontWeight: FontWeight.w700,
                        height: 1.300000017339533,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_pkfj6b =
    '<svg viewBox="0.0 0.0 16.0 16.0" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 16.0, 16.0)" d="M 8 0 L 6.545454978942871 1.454545497894287 L 12.05194854736328 6.961039066314697 L 0 6.961039066314697 L 0 9.038961410522461 L 12.05194854736328 9.038961410522461 L 6.545454978942871 14.54545497894287 L 8 16 L 16 8 L 8 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_nx8zoq =
    '<svg viewBox="160.8 327.6 53.0 61.9" ><path transform="translate(158.19, 325.36)" d="M 53.24672317504883 15.32123184204102 C 53.89110565185547 15.96561241149902 54.44346237182617 16.84013938903809 54.90379333496094 17.9448127746582 C 55.3641242980957 19.04948616027832 55.5942497253418 20.06209182739258 55.59416961669922 20.98263359069824 L 55.59416961669922 60.75024032592773 C 55.59416961669922 61.67078018188477 55.27197647094727 62.45323944091797 54.62759780883789 63.09761810302734 C 53.98321533203125 63.74200439453125 53.20075225830078 64.06418609619141 52.28021240234375 64.06419372558594 L 5.884689331054688 64.06419372558594 C 4.964148998260498 64.06419372558594 4.181687831878662 63.74200439453125 3.537305355072021 63.09761810302734 C 2.892923355102539 62.45323944091797 2.570732116699219 61.67077255249023 2.570732116699219 60.75023651123047 L 2.570732116699219 5.517457962036133 C 2.570732116699219 4.596918106079102 2.892923355102539 3.814457178115845 3.537305355072021 3.170074701309204 C 4.181687831878662 2.525692701339722 4.964148998260498 2.20350193977356 5.884689331054688 2.203501462936401 L 36.81503677368164 2.203501462936401 C 37.73557662963867 2.203501462936401 38.74818420410156 2.433646440505981 39.85285568237305 2.8939368724823 C 40.95752716064453 3.35422682762146 41.83207321166992 3.906563520431519 42.47649765014648 4.550945281982422 L 53.24672317504883 15.32123184204102 Z M 37.91965103149414 6.898208618164063 L 37.91965103149414 19.87790107727051 L 50.89934158325195 19.87790107727051 C 50.66921615600586 19.21052169799805 50.41609191894531 18.73873329162598 50.13997650146484 18.4625358581543 L 39.33495330810547 7.657632827758789 C 39.05879592895508 7.381475448608398 38.58700561523438 7.12833309173584 37.91958999633789 6.898208618164063 Z M 51.17547607421875 59.6455078125 L 51.17547607421875 24.29652786254883 L 36.81497573852539 24.29652786254883 C 35.89443206787109 24.29652786254883 35.11197280883789 23.97433853149414 34.46759033203125 23.3299560546875 C 33.82320785522461 22.68557357788086 33.50101852416992 21.90311241149902 33.50101852416992 20.98257255554199 L 33.50101852416992 6.6220703125 L 6.989300727844238 6.6220703125 L 6.989300727844238 59.6455078125 L 51.17559814453125 59.6455078125 Z M 46.75690460205078 44.18033599853516 L 46.75690460205078 55.22687911987305 L 11.40799045562744 55.22687911987305 L 11.40799045562744 48.59896469116211 L 18.03590393066406 41.97105026245117 L 22.45453643798828 46.38967895507813 L 35.71048736572266 33.1337890625 L 46.75690460205078 44.18033599853516 Z M 18.03584289550781 37.55241775512695 C 16.19476318359375 37.55241775512695 14.62984180450439 36.90803527832031 13.34107685089111 35.6192741394043 C 12.05231189727783 34.33050918579102 11.40792942047119 32.76558685302734 11.40792942047119 30.92450141906738 C 11.40792942047119 29.08342170715332 12.05231189727783 27.51849746704102 13.34107685089111 26.22973442077637 C 14.62984180450439 24.94097137451172 16.19476318359375 24.29658889770508 18.03584289550781 24.29658699035645 C 19.87692260742188 24.29658508300781 21.44184875488281 24.94096946716309 22.73061370849609 26.22973442077637 C 24.01937866210938 27.51849937438965 24.66376113891602 29.08342361450195 24.66376113891602 30.92450141906738 C 24.66376113891602 32.76558303833008 24.01937866210938 34.33050537109375 22.73061370849609 35.6192741394043 C 21.44184875488281 36.90803909301758 19.87692260742188 37.55242156982422 18.03584289550781 37.55241775512695 Z" fill="#858585" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
