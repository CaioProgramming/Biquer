import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/specific_rect_clip.dart';

class Settings extends StatelessWidget {
  Settings({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(0.0, 756.0),
            child:
                // Adobe XD layer: 'Toolbar' (group)
                Stack(
              children: <Widget>[
                // Adobe XD layer: 'Rectangle 192' (shape)
                Container(
                  width: 375.0,
                  height: 56.0,
                  decoration: BoxDecoration(
                    color: const Color(0xfffba216),
                  ),
                ),
                Transform.translate(
                  offset: Offset(245.0, 20.0),
                  child:
                      // Adobe XD layer: 'Profile' (group)
                      Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(0.0, -354.0),
                        child:
                            // Adobe XD layer: 'Union 1' (group)
                            Stack(
                          children: <Widget>[
                            Transform.translate(
                              offset: Offset(4.0, 354.0),
                              child:
                                  // Adobe XD layer: 'Ellipse 3' (shape)
                                  Container(
                                width: 8.0,
                                height: 8.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(4.0, 4.0)),
                                  color: const Color(0xffffffff),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0.0, 364.0),
                              child:
                                  // Adobe XD layer: 'Path 6' (shape)
                                  SvgPicture.string(
                                _svg_rssq3g,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(179.0, 20.0),
                  child:
                      // Adobe XD layer: 'Explore' (group)
                      Stack(
                    children: <Widget>[
                      // Adobe XD layer: 'Path 103' (shape)
                      SvgPicture.string(
                        _svg_y85oin,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(36.0, 19.56),
                  child:
                      // Adobe XD layer: 'Icon ionic-md-home' (shape)
                      SvgPicture.string(
                    _svg_v1htpy,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 375.0,
            height: 392.0,
            decoration: BoxDecoration(
              color: const Color(0xfffba216),
            ),
          ),
          Transform.translate(
            offset: Offset(21.0, 28.0),
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(95.0, 46.0),
                  child: Container(
                    width: 140.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(70.0, 70.0)),
                      image: DecorationImage(
                        image: const AssetImage(''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(101.0, 204.0),
                  child: Text(
                    ' Kameron Krajcik',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.96,
                      fontWeight: FontWeight.w900,
                      height: 1.125,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(127.0, 224.0),
                  child: Text(
                    '+ 55 1195674321',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 10,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.6,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(126.0, 244.0),
                  child: Text(
                    'kameronKr@mail.com',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 10,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.6,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 372.0),
            child: Container(
              width: 375.0,
              height: 384.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color(0xfff8f8f8),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0.5, 406.0),
            child: SpecificRectClip(
              rect: Rect.fromLTWH(0, 0, 375, 196),
              child: UnconstrainedBox(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 375,
                  height: 197,
                  child: GridView.count(
                    primary: false,
                    padding: EdgeInsets.all(0),
                    mainAxisSpacing: 19,
                    crossAxisSpacing: 20,
                    crossAxisCount: 1,
                    childAspectRatio: 10.7143,
                    children: [
                      {
                        'text': 'Editar perfil',
                      },
                      {
                        'text': 'Solicitar suporte',
                      },
                      {
                        'text': 'Configurações de pagamento',
                      },
                      {
                        'text': 'Sair',
                      },
                    ].map((map) {
                      final text = map['text'];
                      return Transform.translate(
                        offset: Offset(-0.5, -406.0),
                        child: Stack(
                          children: <Widget>[
                            Transform.translate(
                              offset: Offset(31.0, 411.0),
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 20,
                                  color: const Color(0xff000000),
                                  letterSpacing: 1.2,
                                  height: 0.9,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0.5, 412.0),
                              child:
                                  // Adobe XD layer: 'Icon ionic-ios-arro…' (shape)
                                  SvgPicture.string(
                                _svg_vvyrj9,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_rssq3g =
    '<svg viewBox="0.0 364.0 16.0 6.0" ><path transform="translate(0.0, 354.0)" d="M 8 10 C 3.599999904632568 10 0 11.80000019073486 0 14 L 0 16 L 16 16 L 16 14 C 16 11.80000019073486 12.39999961853027 10 8 10 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_y85oin =
    '<svg viewBox="0.0 0.0 16.0 16.0" ><path transform="translate(-130.0, 0.0)" d="M 138 16 C 133.6000061035156 16 130 12.39999961853027 130 8 C 130 3.600000381469727 133.6000061035156 0 138 0 C 142.3999938964844 0 146 3.599999904632568 146 8 C 146 12.39999961853027 142.3999938964844 16 138 16 Z M 142 4 L 138.1000061035156 5.800000190734863 C 137.2000122070313 6.200000286102295 136.2000122070313 7.200000286102295 135.8000030517578 8.100000381469727 L 134 12 L 137.8999938964844 10.19999980926514 C 138.7999877929688 9.800000190734863 139.7999877929688 8.800000190734863 140.1999969482422 7.899999618530273 L 142 4 Z" fill="#ffffff" fill-opacity="0.3" stroke="none" stroke-width="1" stroke-opacity="0.3" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_v1htpy =
    '<svg viewBox="36.0 19.6 84.0 16.4" ><path transform="translate(32.63, 15.5)" d="M 9.52884578704834 20.5 L 9.52884578704834 15.16666698455811 L 13.22115421295166 15.16666698455811 L 13.22115421295166 20.5 L 16.97500038146973 20.5 L 16.97500038146973 12.5 L 19.375 12.5 L 11.375 4.5 L 3.375 12.5 L 5.775000095367432 12.5 L 5.775000095367432 20.5 L 9.52884578704834 20.5 Z" fill="#fcbe5c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(103.43, 19.0)" d="M 8.5625 0.5625 C 4.143145084381104 0.5625 0.5625 4.143145084381104 0.5625 8.5625 C 0.5625 12.98185539245605 4.143145084381104 16.5625 8.5625 16.5625 C 12.98185539245605 16.5625 16.5625 12.98185539245605 16.5625 8.5625 C 16.5625 4.143145084381104 12.98185539245605 0.5625 8.5625 0.5625 Z M 10.40443515777588 11.85604858398438 L 7.559273719787598 9.78830623626709 C 7.459274291992188 9.714113235473633 7.401209831237793 9.597983360290527 7.401209831237793 9.47540283203125 L 7.401209831237793 4.046370983123779 C 7.401209831237793 3.833467721939087 7.575403213500977 3.659274101257324 7.78830623626709 3.659274101257324 L 9.33669376373291 3.659274101257324 C 9.549596786499023 3.659274101257324 9.723790168762207 3.833467721939087 9.723790168762207 4.046370983123779 L 9.723790168762207 8.488306999206543 L 11.77217769622803 9.978630065917969 C 11.94637107849121 10.10443687438965 11.98185539245605 10.3463716506958 11.85604858398438 10.52056503295898 L 10.94637107849121 11.77217769622803 C 10.82056427001953 11.94314479827881 10.57862854003906 11.98185539245605 10.40443515777588 11.85604858398438 Z" fill="#ffffff" fill-opacity="0.3" stroke="none" stroke-width="1" stroke-opacity="0.3" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_vvyrj9 =
    '<svg viewBox="0.5 412.0 375.0 27.5" ><path transform="translate(336.75, 405.8)" d="M 17.54182052612305 14.07425975799561 L 11.57732391357422 8.114455223083496 C 11.13620471954346 7.673335075378418 11.13620471954346 6.96003532409668 11.57732391357422 6.523609161376953 C 12.01844310760498 6.087182998657227 12.73174285888672 6.08718204498291 13.1728630065918 6.523609161376953 L 19.9304370880127 13.27649116516113 C 20.35747718811035 13.70353126525879 20.36686325073242 14.38867473602295 19.96328544616699 14.82979393005371 L 13.17755508422852 21.62960433959961 C 12.95699596405029 21.85016441345215 12.66604518890381 21.95809745788574 12.37978649139404 21.95809745788574 C 12.09352779388428 21.95809745788574 11.80257701873779 21.85016441345215 11.58201694488525 21.62960433959961 C 11.14089775085449 21.18848419189453 11.14089775085449 20.47518730163574 11.58201694488525 20.03875923156738 L 17.54182052612305 14.07425975799561 Z" fill="#fba216" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.5, 439.5)" d="M 375 0 L 0 0" fill="none" fill-opacity="0.09" stroke="#707070" stroke-width="1" stroke-opacity="0.09" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
