import 'package:admob/src/admob/adstate.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final AdState adState = Provider.of<AdState>(context);

    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState.listener,
        )..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AdMob Test"),
      ),
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text("Teste admob"),
            ),
          ),
          if (banner != null)
            Container(
              height: 50,
              color: Colors.white,
              child: AdWidget(
                ad: banner!,
              ),
            )
          else
            const SizedBox(
              height: 1,
            )
        ],
      ),
    );
  }
}
