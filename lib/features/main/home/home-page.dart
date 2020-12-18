import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:refactory_mobile/base/base-state.dart';
import 'package:refactory_mobile/constants.dart';
import 'package:refactory_mobile/features/main/home/home-presenter.dart';
import 'package:refactory_mobile/model/alumni-model.dart';
import 'package:refactory_mobile/model/media-model.dart';
import 'package:refactory_mobile/model/partner-model.dart';
import 'package:refactory_mobile/tools/webview-page.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends BaseStatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage,HomePresenter> implements HomeContract {

  List<PartnerModel> dataPartner;
  List<MediaModel> dataMedia;
  List<AlumniModel> dataAlumni;
  bool progressPartner = false;
  bool progressAlumni = false;
  bool progressMedia = false;

  @override
  void initMvp() {
    // TODO: implement initMvp
    super.initMvp();
    presenter = HomePresenter();
    presenter.setView(this);
    presenter.getPartnerList();
    presenter.getMediaList();
    presenter.getAlumniList();
  }

  @override
  fetchPartnerData(List<PartnerModel> data) {
    setState(() {
      dataPartner = data;
    });
  }

  @override
  progressDataPartner(bool loading) {
    setState(() {
      progressPartner = loading;
    });
  }

  @override
  fetchMediaData(List<MediaModel> data) {
    setState(() {
      dataMedia = data;
    });
  }

  @override
  progressDataMedia(bool loading) {
    setState(() {
      progressMedia = loading;
    });
  }

  @override
  fetchAlumniData(List<AlumniModel> data) {
    setState(() {
      dataAlumni = data;
    });
  }

  @override
  progressDataAlumni(bool loading) {
    setState(() {
      progressAlumni = loading;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(DefaultImageLocation.HomeBg,width: MediaQuery.of(context).size.width,height: 370,fit: BoxFit.cover,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 370,
                      decoration: BoxDecoration(
                        color: DefaultColor.primaryColor.withOpacity(0.7)
                      ),
                    ),
                    Container(
                      height: 370,
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Empowering ',
                                    style: TextStyle(
                                        color: Colors.white,
                                    )
                                ),
                                TextSpan(
                                    text: '\nPeople ',
                                    style: TextStyle(
                                      color: Colors.orange,
                                    )
                                ),
                                TextSpan(text: '\nThrough Programming '),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: TextStyle(
                                fontSize: 16
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Refactory ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                                TextSpan(
                                    text: 'adalah perusahaan edukasi dan teknologi yang menyediakan layanan lengkap berupa  ',
                                    style: TextStyle(
                                        color: Colors.white,
                                    )
                                ),
                                TextSpan(
                                    text: ' course ',
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontStyle: FontStyle.italic
                                    )
                                ),
                                TextSpan(text: ' maupun'),
                                TextSpan(
                                    text: ' custom training',
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontStyle: FontStyle.italic
                                    )
                                ),
                                TextSpan(text: '  yang materinya dapat disesuaikan dengan kebutuhan teknologi dan bisnis perusahaan Anda.'),

                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.orange,width: 2)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Temukan Solusi Anda",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.orange,width: 2)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Tingkatkan Skill Anda",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                            "Partner Eksklusif Kami",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                    )
                  ],
                ),
                progressPartner?Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Shimmer.fromColors(
                    baseColor: DefaultColor.primaryColor,
                    highlightColor: DefaultColor.primaryColor.withOpacity(0.8),
                    child: Container(
                      height:100,
                      width:MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: DefaultColor.primaryColor,
                      ),
                    ),
                  ),
                ):CarouselSlider(
                  items: dataPartner.map((fileImage) {
                    return Container(
                      decoration: BoxDecoration(
                        color: DefaultColor.primaryColor
                      ),
                      child: Image.network(
                        fileImage.imagePath,
                        width: MediaQuery.of(context).size.width,
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    height: 100
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Apa Yang Refactory \nDapat Bantu?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                        ),
                      ),
                      SizedBox(height: 20,),
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(DefaultImageLocation.Stronger,width: 25,height: 25,),
                              SizedBox(width: 10,),
                              RichText(
                                text: TextSpan(
                                  text: '',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Memperkuat Tim ',
                                        style: TextStyle(
                                        )
                                    ),
                                    TextSpan(
                                        text: ' Engineer ',
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontStyle: FontStyle.italic
                                        )
                                    ),
                                    TextSpan(text: ' Anda'),

                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Bisnis di jaman modern membutuhkan keterampilan pengembangan terbaik untuk meningkatkan skala produk. Kami dapat mempersiapkan course dan juga dapat menyediakan tim yang menangani kebutuhan digital Anda.",
                            style: TextStyle(
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(DefaultImageLocation.Power,width: 25,height: 25,),
                              SizedBox(width: 10,),
                              RichText(
                                text: TextSpan(
                                  text: '',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Wujudkan ',
                                        style: TextStyle(
                                        )
                                    ),
                                    TextSpan(
                                        text: ' Software ',
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontStyle: FontStyle.italic
                                        )
                                    ),
                                    TextSpan(text: ' Impian Anda'),

                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Kami adalah perusahaan One-Stop IT Solution untuk proyek Anda, membantu di setiap tahap mulai dari menyusun ide, melalui desain dan pengembangan aplikasi seluler, situs web dan aplikasi desktop, hingga peluncuran produk.",
                            style: TextStyle(
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "As Seen On",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22
                        ),
                      ),
                      SizedBox(height: 20,),
                      progressMedia?Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.2),
                          highlightColor: Colors.grey.withOpacity(0.8),
                          child: Container(
                            height:100,
                            width:MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ),
                      ):Container(
                        height: 55 * dataMedia.length.toDouble(),
                        child: GridView.count(
                         crossAxisCount: 2,
                          physics: NeverScrollableScrollPhysics(),
                          childAspectRatio: 2,
                          children: List.generate(dataMedia.length, (index) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return WebviewPage(dataMedia[index].name, dataMedia[index].linkUrl);
                                }));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                ),
                                child: Center(
                                    child: Image.network(dataMedia[index].photoUrl,width: 80,height: 80,)
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Review",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: '',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Read what our alumni said on ',
                                style: TextStyle(
                                )
                            ),
                            TextSpan(
                                text: ' Course Report ',
                                style: TextStyle(
                                    color: Colors.orange,
                                  fontWeight: FontWeight.bold
                                )
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      progressAlumni?Container(
                          height: 280,
                          child: ListView.builder(
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,position){
                              return Container(
                                margin: EdgeInsets.only(left: position == 0?0:10,top: 10,bottom: 10,right: 10),
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 9,
                                      offset: Offset(0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Shimmer.fromColors(
                                        baseColor: Colors.grey.withOpacity(0.3),
                                        highlightColor: Colors.grey.withOpacity(0.5),
                                        period: Duration(milliseconds: 2100),
                                        child: Container(
                                          width: 200,
                                          height: 165 * (MediaQuery.of(context).size.width / 450),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                        )
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Shimmer.fromColors(
                                              baseColor: Colors.grey.withOpacity(0.3),
                                              highlightColor: Colors.grey.withOpacity(0.5),
                                              period: Duration(milliseconds: 2100),
                                              child: Container(
                                                width: 170,
                                                height: 20,
                                                margin: EdgeInsets.only(right: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: Colors.white,
                                                ),
                                              )
                                          ),
                                          SizedBox(height: 10,),
                                          Shimmer.fromColors(
                                              baseColor: Colors.grey.withOpacity(0.3),
                                              highlightColor: Colors.grey.withOpacity(0.5),
                                              period: Duration(milliseconds: 2100),
                                              child: Container(
                                                width: 190,
                                                height: 20,
                                                margin: EdgeInsets.only(right: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: Colors.white,
                                                ),
                                              )
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                      ):Container(
                          height: 300,
                          child: ListView.builder(
                            itemCount: dataAlumni.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,position){
                              return GestureDetector(
                                onTap: (){
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: position == 0?0:10,top: 10,bottom: 10,right: 10),
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 9,
                                        offset: Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: 165 * (MediaQuery.of(context).size.width / 450),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                                            color: Colors.grey
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                                          child: Image.network(
                                            dataAlumni[position].user.photoUrl,
                                            fit: BoxFit.cover,
                                            width: 200,
                                            height: 165 * (MediaQuery.of(context).size.width / 450),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                dataAlumni[position].user.name,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontFamily: DefaultFont.PoppinsFont,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 170,
                                              child: Text(
                                                dataAlumni[position].user.from,
                                                maxLines:2,
                                                style: TextStyle(
                                                    fontFamily: DefaultFont.PoppinsFont,
                                                    fontSize: 12
                                                ),
                                              ),
                                            ),
                                            RatingBar.builder(
                                              initialRating: dataAlumni[position].star.toDouble(),
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              updateOnDrag: false,
                                              itemCount: 5,
                                              itemSize: 20,
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                size: 5,
                                                color: Colors.amber,
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            Container(
                                              width: 170,
                                              child: Text(
                                                dataAlumni[position].title,
                                                maxLines:2,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
