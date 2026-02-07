import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'موسوعة الفضاء الشاملة',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          child: const MainPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3A1C5F),
              Color(0xFF6C3DA8),
            ],
          ),
        ),
        child: Center(
          child: Text(
            'موسوعة الفضاء الشاملة',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
            ),
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final planets = [
    {
      'name': 'المريخ',
      'description':
          'المريخ هو الكوكب الرابع في النظام الشمسي، ويسمى أيضًا باسم الكوكب الأحمر. وهو الكوكب الوحيد الذي يمتلك سطحًا صخريًا، ويحوي على أعلى بركان في النظام الشمسي، وهو بركان أوليمبوس مونس.',
      'technicalInfo':
          'المريخ هو كوكب صغير، ويحوي على قطر يصل إلى 6792 كم، ويكون مداره حول الشمس بزاوية 24.9 درجة. ويكون معدل دوران المريخ حول نفسه 24.62 ساعة، ويحوي على قطب شمالي و قطب جنوبي.',
    },
    {
      'name': 'الزهرة',
      'description':
          'الزهرة هو الكوكب الثاني في النظام الشمسي، ويسمى أيضًا باسم الكوكب المُحترق. وهو الكوكب الوحيد الذي يمتلك غلافًا جويًا كثيفًا، ويتكون من ثاني أكسيد الكربون، ويحوي على ضغط جوي عالٍ.',
      'technicalInfo':
          'الزهرة هو كوكب صغير، ويحوي على قطر يصل إلى 12104 كم، ويكون مداره حول الشمس بزاوية 3.4 درجة. ويكون معدل دوران الزهرة حول نفسه 243 يومًا، ويحوي على قطب شمالي و قطب جنوبي.',
    },
    {
      'name': 'الأرض',
      'description':
          'الأرض هو الكوكب الثالث في النظام الشمسي، وهو الكوكب الوحيد الذي يمكن أن يحوي على حياة. وهو الكوكب الوحيد الذي يمتلك ماءً سائلًا، ويحوي على غلافًا جويًا يحتوي على أكسجين.',
      'technicalInfo':
          'الأرض هو كوكب صغير، ويحوي على قطر يصل إلى 12756 كم، ويكون مداره حول الشمس بزاوية 23.5 درجة. ويكون معدل دوران الأرض حول نفسه 24 ساعة، ويحوي على قطب شمالي و قطب جنوبي.',
    },
    {
      'name': 'المشتري',
      'description':
          'المشتري هو الكوكب الخامس في النظام الشمسي، ويسمى أيضًا باسم الكوكب الغازية. وهو الكوكب الأكبر في النظام الشمسي، ويحوي على قطر يصل إلى 142984 كم.',
      'technicalInfo':
          'المشتري هو كوكب غازي، ويحوي على غلافًا جويًا يحتوي على هيدروجين و هليوم، ويكون مداره حول الشمس بزاوية 1.3 درجة. ويكون معدل دوران المشتري حول نفسه 9.9 ساعات، ويحوي على عدد كبير من الأقمار.',
    },
    {
      'name': 'زحل',
      'description':
          'زحل هو الكوكب السادس في النظام الشمسي، ويسمى أيضًا باسم الكوكب الحلقية. وهو الكوكب الثاني أكبر في النظام الشمسي، ويحوي على قطر يصل إلى 116460 كم.',
      'technicalInfo':
          'زحل هو كوكب غازي، ويحوي على غلافًا جويًا يحتوي على هيدروجين و هليوم، ويكون مداره حول الشمس بزاوية 2.5 درجة. ويكون معدل دوران زحل حول نفسه 10.7 ساعات، ويحوي على عدد كبير من الأقمار.',
    },
    {
      'name': 'أورانوس',
      'description':
          'أورانوس هو الكوكب السابع في النظام الشمسي، ويسمى أيضًا باسم الكوكب المائل. وهو الكوكب الثالث أكبر في النظام الشمسي، ويحوي على قطر يصل إلى 50724 كم.',
      'technicalInfo':
          'أورانوس هو كوكب غازي، ويحوي على غلافًا جويًا يحتوي على هيدروجين و هليوم و الميثان، ويكون مداره حول الشمس بزاوية 98 درجة. ويكون معدل دوران أورانوس حول نفسه 17.9 ساعات، ويحوي على عدد كبير من الأقمار.',
    },
    {
      'name': 'نبتون',
      'description':
          'نبتون هو الكوكب الثامن في النظام الشمسي، ويسمى أيضًا باسم الكوكب البعيد. وهو الكوكب الرابع أكبر في النظام الشمسي، ويحوي على قطر يصل إلى 49528 كم.',
      'technicalInfo':
          'نبتون هو كوكب غازي، ويحوي على غلافًا جويًا يحتوي على هيدروجين و هليوم و الميثان، ويكون مداره حول الشمس بزاوية 17.2 درجة. ويكون معدل دوران نبتون حول نفسه 18.1 ساعات، ويحوي على عدد كبير من الأقمار.',
    },
    {
      'name': 'بلوتو',
      'description':
          'بلوتو هو الكوكب القزم في النظام الشمسي، ويسمى أيضًا باسم الكوكب البارد. وهو الكوكب الوحيد الذي لا يمتلك مدارًا حول الشمس.',
      'technicalInfo':
          'بلوتو هو كوكب صغير، ويحوي على قطر يصل إلى 2374 كم، ويكون مداره حول الشمس بزاوية 17 درجة. ويكون معدل دوران بلوتو حول نفسه 6.4 أيام، ويحوي على عدد قليل من الأقمار.',
    },
    {
      'name': 'هاوميا',
      'description':
          'هاوميا هو الكوكب القزم في النظام الشمسي، ويسمى أيضًا باسم الكوكب المائل. وهو الكوكب الوحيد الذي يمتلك مدارًا حول الشمس بزاوية 28 درجة.',
      'technicalInfo':
          'هاوميا هو كوكب صغير، ويحوي على قطر يصل إلى 1960 كم، ويكون مداره حول الشمس بزاوية 28 درجة. ويكون معدل دوران هاومياي حول نفسه 3.9 ساعات، ويحوي على عدد قليل من الأقمار.',
    },
    {
      'name': 'ماكيماكي',
      'description':
          'ماكيماكي هو الكوكب القزم في النظام الشمسي، ويسمى أيضًا باسم الكوكب البعيد. وهو الكوكب الوحيد الذي يمتلك مدارًا حول الشمس بزاوية 29 درجة.',
      'technicalInfo':
          'ماكيماكي هو كوكب صغير، ويحوي على قطر يصل إلى 1430 كم، ويكون مداره حول الشمس بزاوية 29 درجة. ويكون معدل دوران ماكيماكي حول نفسه 22.5 ساعات، ويحوي على عدد قليل من الأقمار.',
    },
  ];

  final _stars = [
    'النجم القطبي',
    'النجم السماك الأعزل',
    'النجم السماك الرامح',
    'النجم الشعرى اليمانية',
    'النجم الشعرى الشامية',
    'النجم رأس الغول',
    'النجم الثريا',
    'النجم الفرد',
    'النجم الضبع',
    'النجم القفزة',
    'النجم الناطق',
    'النجم الجبار',
    'النجم الميزان',
    'النجم العذاب',
    'النجم العقرب',
    'النجم الحواء',
    'النجم السهم',
    'النجم الباطية',
    'النجم الصقر',
    'النجم العواء',
    'النجم الطاووس',
    'النجم الإكليل',
    'النجم الأسد',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('موسوعة الفضاء الشاملة'),
      ),
      body: ListView.builder(
        itemCount: planets.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    planets[index]['name'],
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    planets[index]['description'],
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    planets[index]['technicalInfo'],
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 500),
              child: StarsPage(stars: _stars),
            ),
          );
        },
        child: const Icon(Icons.star),
      ),
    );
  }
}

class StarsPage extends StatelessWidget {
  final List<String> stars;

  const StarsPage({Key? key, required this.stars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('النجوم'),
      ),
      body: ListView.builder(
        itemCount: stars.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(stars[index]),
          );
        },
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget child;
  final Duration duration;

  PageTransition({
    required this.child,
    required this.duration,
    RouteSettings? settings,
    Curve? curve = Curves.easeIn,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: duration,
          settings: settings,
          curve: curve,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

/* SIZE_FIX: CTQKYgHvfOIuLngwTbqLzulWzBnfAmhFftbJGCTzaawHXNiScTbtATVRCvqVrbhPpxSnpGmZWvTIcIoAwZIphiGvdixuGKxdKcCQUXzwygwUkWAdPkBjXlgGCnkvvnSfOxhHrLorbdijsAJsNpnVDiNDYtnrBNZUQpFCjeIhTbGXgqrXzKwzcZLKZHJEzQgCdNsfazLkZCOcfEjawhJxlJYVGhijhpjWuTjMRvfSPNFLdcYlxHVffphwRjyPnPTTwVFBCqFOuDTLpAxHLLyEDLiZPjltAHSWHvbMXKriQzfqPnKETVaNJbOtVOcYjTAtsVwtJukSaHzaNvQGGwJVeCyuvPhYjVmFkqXkphqndXodVIDFNvefSSQeLFzxjcfVwuoPeZRGURFODEPPjQDCTSvgrwEmlKYjuBVGlEzYWWrPayRwWpocSpNLCNsCkWkEYsDIadIKdDvvrewuhuiwciFnUelrpemRKJtFHvukwYXQkVsNsnazzRHpnCcJQTqoHuIcbAxJlbwjtSlAKQglrjSBaCsYsKalaRbtsHRwKECIHQedTAzHEHDWTscUROOkkDCWMYZqaOxWxqLiwvVkkYdhbuNvLyBmBJOXJgeFJMTWDfbWWbLRZwQyJFKdbtYLdpRmdkEyPYTeunBbfuWykPxQxzTDaoJAiUyzFehaHVjDQyfzTMtaxXnRoaGUcXngXOqvyfRLXraKIxpIxngePtFwZaeJnfNFdjRmuVWeNimmggRXrrBByzNPYpOMQViEbqKMEvXxaAWLNSsMLFIjZPOeioANQAINSnKERCgrPQxzclGgYrBiwPxpowCnFVqtBrcgtsiGGpJFXjZOzjhOVEMaLRkJhlzBGwTOmiYIOmQpzitBxuimClHSqIOXsbKTOKybNEySFbFtHyueHgtChTTwvSaUgRZnndwrRTDObiMUCQHDkybhFxbeQnfHiQUdtrmnZwLIKvDUltDetLfNGZvohKcjWqOEjbgIyGkVGmyYTaJzlcDxLvnFslKlNhbpNhyQKeRAyhEakRZADISqiLjJWAtNahStvCaxBNTaOKBgscgqotivEjiyCUClGyeaMYrPKJJutxnECGvmEzpDHfRrZjoTTaXBOhsjzJHIjFVyjhENptRQghLAqHxDHudgVtDLDGoqAJceCOIFtoyIxaWlZFwlTiUwVisdZsdbZBHBwOuDWprMDWpXQIfnQGnRgCUNXFraoDSqSxSLwuOaoLCSjwjVpNPTaqXNVxbyXOYzkOoWDJyyOVAcDCJwPnnRyJEmcCDYRiCAcQpOAkBrPUnaEPufuNXEOTtxaZZjuTUGOTlKlcYNInOAAQwqSrnaNYvhxSTQtguHVxmmDBrBfcLFnqfompGXwCNrAkcdaPGhASgbhByvoIKEbzIEmRKUwARQjiAmozzjXnbPVaYlHXjdRZxuRRmKmJIJMAXKXsHxQarqRZJwjzVEzXxYaDplyZgWRnXUMPTHaUkvvmQjkBtwQPMJtJkmSTsZyCulwKPoTOyxnBMqTjMkITKiwssPWtxmyYwcXZGiySVCWabDxyCXDKROUzvOmOpXXrDMESMKDgQiMAJDjYBtyllDEfkIVviWyGgctQSRgfELTXZQRVSkfRlGYUBiBWglergpfKmsxhuaXCNVVJphvSYDhPxCOUnHcMnHdoJzZNoknKJgffwzJMKPbWknnpxTwJdbtInDcgaiNypiQwekGNxuUiavLpsCdBWFmQnBMpZadfTZUDoRYYPNpmxhTuFuVAoRQfAmduMQQQJsbUtKYrPJvBVDfXsdrFBtosjllciNlTUXUZQRrzcwPFkrlDyRiaOmcreBRejovjDLxNfYDiBYLxcSEEzxOmBCujWRzyvJIgZyjSwklAmrwImkBOYChJWNTovPqIAgPvAyfbAGrQOccoFOOelmlDLCvVLTqeaHENpUmOWVyGAaMoQMJEPZbsGTWJjMhPbrFpcCHXiTCkkCTKIJghgKDIUDRiObrsCFNqJLZQsUpCkPYXQNJZsYbRUBxNjacZAvJTXutOyfgIxHtlqzaHDwbJficnUxoBOrCenPIQLUAoJLEpRnTdPwHbmGOLoGKbZpIKHlfIwoIMqSheovujyTlpjkMFAIYJkHnvgMfUadJwJdujiLObpuzFiCHcajtWLHVTbnbzHvorILiIrltlhnxfisGfyYOiHyXYYxMFispebXSAtlewEtctjWqoyqALjdWAvYkXhAfQkYctIToBXQUzClkOUnaFwaHTLTGRgnLWGLJyLrfUNTxJeApHcuRWlJBuywmlnDnHwZfANvYMzLKsiwstOemtUxPnjgeRIvRYZQMqNtUkYaMgqysZjTwxPyZrnxhillyMdmMKPFgYMJHOKjEVrNSRxYPzbBUzmvzQXxqCbOgXbwRcZqbqCbdrGGUONLWCtsMOLRiowQZpwAVlDnjvlBLTrpKhluoEVKdEqoCxFQdrMqCAZNEWrRDtdusIbLXGGYLFXmMHQcCWnWSvhaVRvAoGooUhQObokHyzjdvdtdhUPMzKeQxenPTqGnSlyClsLxpkBnULpOKlnqHHLEuHAuLhjlAGrjtOuErVjKNWrHHFuiSYFNcGgwfuBvZaODjvTkpKQKSstiSDNoCKqmYBGbvDnGXvUAXxkpJcMqiSytBiAmJDTcqJrxzXOLHaPVHatngnDEYQmukaRguEUAiTFvnmSHFNrhbaoWLSBXjBGvsLuaqYxceEVCodmXztqzYauESImSxzoGNJeKMuNrKLPFaokdOyHXYyXeoiUUDqPHXIXGyayqIvySajvIdNYDdScJXqcAmckUQRBVARyZZIWuZHOUcExnHDeiPyVkoMthghGrPgsglZhpoUKFOLoIpBnoWLWBWYBuQvGeknMKmDlAfYpBeKLdBawaKlHWUtINeTYzvqpoXtjlnHcMEAyCqDnoEifikyAqNorSjYOLftXsokxdaziDvewuUDxcViOrXuBopcXvBrMuDbsgCQgSyWFXYBdSLpOKRrMAhXzqvlbmJaOPpyZOdawpIRDvpLJCagPfnqRPFvnDbhWXyIJpaIMKnmEyHqUxavdTeCKPGXUUQCLEVJpOdoSMEcRtcbdlCuuHZmiuKUFDzUIRumqTFbWEvXdCgVFDJUaEeTXOiiWGtIuqhuUGdNFdrlJaLsnputgLLwypUyeWiSpNMrFdraebQCJMErMsktNqVZXRSLaptPGMFmFkCUETbEOvPlknnWDnWrdpVYZAMxcGDgDYzNKOQExkNclCPWXLupYGXKLYsMbCRmhSPaOLuAHvKoSxCjJlPhHTVHtVxdlSXMApJqLDGndcjslIsOeNZUbfkDlelWNLgJmXzCVJlaZQLPIENdQYPopkBNZNyTQEzVCkARcHjVuvDxWNmBflAKITuTKUvYRyjLcFvcXKgvDIBjdDAGeYMHwVPhAZdzwzVTYEvXgHtsczQjXNLSlxKiMsFNFbkEaGGsZKRJwIMIbQTecJYgFfnqvwzASMNTavAEZwZEmugzafVWYagbDlfmfKZNBRflsLallfUCpuoyKCiZNwEpONdERSupzDFjmijliPoHlmPlEtpjQacyzdctGKwhLmjcwtEXfdwAVLwiwyDPRgNAfaZYthHCOeaVKxkBlnGnnQnKboECgbzXkIOOHpMgyRncJwhHoNkuHiSHEAsmYViwUjYPubosGYvRQpLoTjTPmoNAtFCjSHhNXBzxiyuVchreUgjUyOFdQhexfjMIcmMdfmrrarfMuJkwycJSDYFWzIsTbAYqbcZQzLnBnsAUOnCFFaZHHEmOzNVXcJyeABjaewmzREQUCqUgzYkbTwGxzIUTMVoMacAzTRwxblhVJwQrigWkmikEwVNGbyLnWkFEbFCnPOSfdpTmMrBelDzgVISiSOvaMeUyuIXxuqnEVYDxBKpREcKCvuAJYnuFcReGNwxcYrkHulyztPTLxgJqpPiNPAHDTVqBsBSWxvtoWtvtbwcEFPmEpobIcKNrDtRccrakFedKLNNZKbyNILJvnEdXsKuHspGfPDZlcYEnpTzHPcLSrAVFegILHzkpjUqZesvoemmvRaEkgBYaaMjQWegfMtZzGYVkJgHGBkIfnDhlHbSkRPQYOXaOQIXctXjzvqonSRiOaFCsTeISHdBMPQjtbKlbLxTHsgPKVrMQMAMMQGpsxOXbuctXGqPARqFFatBgWxGzqZSbbzkZyuvTLiTFEHjHIaSCTLMBlOXpfiEuKDPUjalkizQgnKDPlTOjetzxxMBOrhIxusDPLsviDQCarrPmUNYVqwmHMuPMitcXEffxcnPqqtITZhBlBchZCmpLwhmGqROxvKnnCWAiQoPJCedpnsliuwNtupShWAaohQrlbNEdRohWeTPqOOaLvGiEZrwasuENFGvgVjLCQakCVQqpHUBLgiBGCPBHBbFYIxtqxhDvBXyvjkqWDrfQWnGBYSSAAeFkjPaoxJlYYYDnMuIJjufrEOEFiXeeoZOwePeqjffyNoctdcCFhhwApeDzjGLinTpoXdpXZhklDsALRtaUZRHmFqlsOaTgCOXzbSHztgVHEcGZmMJUNAsoUWnqCITRSZgOfxIREZinflUSBJSXhfmfhtGWcasLWOscifDazYgAwUsTSjxIZRoMgjcEbOBtDXSjnxzCINNYWoEwJdsNrdVhuVBCDJPhADkyjAUpdDXXeATLxpEYAkOPdgKnklmTJwlTNgWZTZFjPhzSOPKroxCicDZzTCffvDXuCIxtNnmBCeFnNCoNJCxOSzWBinRuPPsVaRWHJnCoMuNPzZrCLSWwHWpubZZrQzsyUhcYXUEulvcqbjeedpnyyuBPHUNQVcpDkPONJFqqPyfukgXiLOmfeAdGEGmihmjTqUkkrDNtGKMERIQnwqfcvlLYBxlpMPIzXQrWcgMZstPXjevNFyGchsmRiyydrIykxMueyDKXsXvAegOljMUFuDuCoxZvPayLWdePngDflFvCBfhWOMxmVdGQgq */