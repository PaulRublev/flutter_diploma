import 'package:flutter/material.dart';

class ArtistAboutPage extends StatelessWidget {
  const ArtistAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Ivan'),
              centerTitle: true,
              background: Image.network(
                'https://i.postimg.cc/1tf6qqQP/grozny.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Text(
                "Voluptate tempor sit reprehenderit "
                "Ut Lorem et sint sint mollit eiusmod labore aliqua occaecat. Ex irure in adipisicing nisi dolor consequat velit id do amet magna sint. Anim sunt proident sint sunt et ex qui do incididunt ea adipisicing officia commodo aliquip. Tempor id esse eu esse nulla consectetur commodo proident duis reprehenderit commodo eu. Nisi sit consectetur culpa anim aute.Fugiat sunt amet deserunt incididunt reprehenderit. Officia minim magna magna irure. Mollit enim minim laboris eu laboris exercitation ad. Dolor consequat ut incididunt irure nisi aute nisi aute minim cillum veniam nisi veniam. Consectetur quis aliquip nostrud elit consectetur incididunt exercitation aute aute consequat sunt.Irure nulla cupidatat proident culpa incididunt dolore minim deserunt in quis est deserunt ex quis. Mollit deserunt id occaecat eu nulla eiusmod. Consectetur fugiat adipisicing et proident labore aute culpa nulla aliquip labore exercitation amet dolore. Commodo exercitation nostrud tempor magna sit ea voluptate.Duis irure dolore officia cupidatat nostrud aute aliqua voluptate. Exercitation voluptate ex ipsum aliqua eu do magna eu ad veniam. Reprehenderit in ipsum est ipsum sit. Anim consectetur Lorem quis ex aute in. Non consequat sint veniam quis et ipsum duis consequat laboris aute ut nisi dolor nulla. Minim cillum velit aute tempor culpa laboris incididunt elit aliqua qui non ullamco Lorem. Esse eu cupidatat elit anim sit ad.Sint qui nostrud amet nostrud duis labore elit. Aliqua eiusmod amet cillum nostrud excepteur enim ipsum sunt excepteur Lorem exercitation. Aliqua deserunt est consequat do in excepteur. Sint ad reprehenderit aliqua esse magna veniam. Labore minim incididunt cupidatat excepteur reprehenderit exercitation magna reprehenderit velit consectetur enim mollit. Cillum nostrud eiusmod do magna aliquip ullamco consectetur deserunt ea aute et. Dolore ex mollit fugiat irure dolor irure minim ea.Ex anim qui id ex nulla magna culpa ea irure esse amet irure. Occaecat laborum commodo officia do proident. Tempor cupidatat consequat minim pariatur quis culpa est fugiat veniam nostrud veniam. Ad voluptate nisi eiusmod quis ad amet commodo in amet elit nisi irure sit. Excepteur ex ullamco laboris mollit elit aliquip officia voluptate nostrud.quis ea irure id aliqua in ipsum. In pariatur tempor officia\n ut id commodo irure est mollit ut\n et laborum. Reprehenderit esse pariatur non\n pariatur sit ullamco mollit cillum eu dolore dolore ut.\nVeniam velit non incididunt ut Lorem mollit commodo est consectetur excepteur in. Duis aliquip excepteur nulla velit nisi Lorem aliquip ex culpa consequat eiusmod ullamco enim reprehenderit. Eiusmod velit in ullamco culpa ut sint deserunt ea ex irure proident consectetur.Nostrud ipsum deserunt mollit eiusmod commodo sunt proident nostrud. Aliquip qui in nulla tempor qui amet sunt cillum in. Aute nostrud eiusmod mollit sunt. Laborum est quis voluptate minim. Quis esse id officia ipsum est esse. Enim nulla consequat laboris enim est do enim proident. Duis Lorem voluptate esse et amet non adipisicing esse. Nostrud ipsum duis magna exercitation eiusmod nulla ex commodo irure nostrud ipsum cupidatat esse qui. Sit laboris consequat elit eiusmod sunt enim ad laborum laboris id amet irure quis. Ad reprehenderit tempor in cupidatat dolore dolor dolore et eu ex. Et in ex ad sint magna cupidatat nisi est sit culpa. Minim amet elit minim do id esse nulla exercitation nostrud. Adipisicing ipsum sunt ex tempor consectetur irure nulla consequat sit exercitation fugiat tempor exercitation ipsum. Voluptate voluptate et est ex deserunt. Nisi sit do eu \nex qui mollit velit aute elit proident. Deserunt adipisicing cupidatat irure elit. \nQui mollit duis deserunt mollit. Ullamco exercitation labore ex reprehenderit et enim \nex qui sunt et ea. Proident nulla duis commodo eiusmod do anim eu do \nduis officia proident ex elit proident. Cupidatat aliqua amet non ea."
                "Reprehenderit Lorem aliqua laborum ad.Eu ullamco minim "
                "occaecat sit magna id esse aliqua.",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  height: 1.26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
