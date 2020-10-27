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
        image: DecorationImage(
            image: AssetImage('assets/images/profilebg.jpg'),
            fit: BoxFit.cover),
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
                  'Profile',
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
                                color: Colors.white70,
                                fontFamily: 'TimeBurner',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              'Aman Srivastava',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'TimeBurner',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
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
