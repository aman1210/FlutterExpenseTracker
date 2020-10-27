import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color.fromRGBO(114, 30, 224, 1),
            const Color.fromRGBO(160, 46, 185, 1),
          ],
          stops: [0.2, 0.9],
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 10,
            spreadRadius: 4,
            color: Colors.black38,
          )
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Text(
                  'Profile Page',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'TimeBurner',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      fontSize: 40),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Image.network(
                          'https://icons-for-free.com/iconfiles/png/512/home+page+profile+user+icon-1320184041392976124.png'),
                      backgroundColor: Colors.grey[100],
                      maxRadius: 35,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white60,
                                  fontFamily: 'TimeBurner',
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Aman Srivastava',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'TimeBurner',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: CircleAvatar(
                        backgroundColor: Colors.black38,
                        radius: 20,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
