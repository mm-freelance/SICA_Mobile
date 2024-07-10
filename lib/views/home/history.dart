import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_html/flutter_html.dart';

class History extends StatefulWidget {
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  //bool _customTileExpanded = false;
  int selectedIndex = 0;
  List data = [
    {
      "title": "Trade Unionism as a Revolution",
      "isShow": true,
      "body":
          "Since time immemorial, labour has always been sought to be exploited by employers the world over, who invariably held the upper hand in employment. Trade activism has been in existence since ancient times, but has been organized only in the past few centuries since the Industrial Revolution.\nIn the highly industrialized West, it was only after a great deal of bloodshed and sacrifice that trade unionism got itself entrenched within the system. And only thereafter was it possible to get justice for workers in the form of reasonable wages, incentives, overtime payments, bonus, profit sharing, perquisites, amenities, leave, pensions and retirement benefits.\n\nIn India, the first labour legislation, the Labour Act was enacted during British rule in 1926."
    },
    {
      "title": "The movement in the Indian Film Industry",
      "isShow": false,
      "body":
          "Ever since it emerged into public domain in the 20th century, cinema has ensconced itself as the most powerful mass medium that man has known. The reason is that it touches the lives of people in the areas that affect them the most and hence leaves a profound influence on them. More so in India and very particularly in the South, where some of the most powerful political leaders were products of the film industry.\n\,Unfortunately however, it is a little recognized fact that the talented men and women who toil behind the scenes are the biggest reason for the success of the industry. The technicians and workers whose role is second to none in the success of a film often do not receive due recognition and ultimately join the list of the forgotten well before the film is screened.\n\nThe truth is that many of these hard-working enthusiasts have in fact gone through a big struggle before they could make it in the world of cinema. And after a lifetime of slogging it out in the dust and grime of film shooting, many of them retire into a life of penury, neglect and suffering. Their struggle follows them to the very end as they have no one to look to in the evening of their lives. Hardly an enviable career to look forward to.\n\nIt is in this background that practitioners in the industry decided to organize themselves into a professional entity to serve the interests of workers during and after their tenure in the industry. In the early days, the film industry was dominated by a few wealthy players who brooked no resistance to their ways of operation. They controlled production and distribution all over the country. Prominent names were New Theatres of Calcutta, Bombay Talkies, Sagar Movietone, Wadia Brothers of Bombay and Prabhat of Pune. Producers from South India had to go to Bombay or Calcutta to make films.\n\nAfter the war and independence thereafter, producers started sprouting all over. Partnerships were entered into and many studios were established. Technicians, artistes and workers were earlier paid on monthly basis, but later came out on their own and were paid on contract basis production-wise. The industry attracted artistes, technicians and workers in hordes and in fuelled intense competition amongst them. This was effectively exploited by the employers who started driving hard bargains. As a result, the workers’ compensations began to fall drastically and working conditions also deteriorated. This led to the need for organized trade unions to tackle the menace. Bombay being the industry leader, saw the first dawn of trade unionism in this field."
    },
    {
      "title": "Breaking New Ground",
      "isShow": false,
      "body":
          "As the employees had been exploited by the employers for a long time, measures were taken to stem this rot. For permanent employees of studios, laboratories and so on, it was ensured that call sheet timings were fixed, overtime wages were demanded and received, compensatory holidays for working on a holiday for studio employees were declared according to factory rules, bonus was declared and many benefits accrued to the members. Retrenchment of staff which was common every year according to the whims and fancies of the employer were restricted, where unavoidable, according to seniority. Slowly as the financial conditions of the organization improved, monetary assistance such as small loans without interest, medical expenses, funeral expenses and some substantial funds to the deceased family members were provided. There were twenty-two studios in Madras to cater to the needs of the industry and our problems also increased. There was a flood of new entrants into the camera department. At the all-India conference held in Bombay in 1976, the three regional Cinematographers’ Associations brought in a rule stipulating minimum educational qualification for membership as Plus Two pass so that members would be in a position to acquire knowledge about the latest trends in technology and infrastructure and the development of new kinds of raw material for film production in order to be able to compete with their counterparts qualifying from the film institutes at Madras, Bangalore and Poona. Many of our senior members were invited to deliver special lectures and demonstrations for the benefit of the students, set question papers for their examinations, evaluate them and help them acquire practical knowledge.\n\nIn line with the new developments in production technology and values and viewer expectations, directors and cinematographers began to prefer natural locations to studio sets. Gradually, the massive built-in sets in studios gave way to outdoor shooting schedules. The studios closed down one by one and the demand for outdoor equipment went up. New portable cameras were introduced into the field along with modern gadgets like zoom lenses and very wide angle lenses. Our members had to quickly re-educate themselves in line with the new trends and they rapidly adjusted themselves to the new equipment and the slow speed colour film which were fast replacing the black and white film in the market. There was a sea change in the lighting equipment department with a switch over in the lighting techniques from the traditional lighting and objective lighting to modern lighting techniques, the current trend throughout the world. This change was quickly adapted by our members through hectic interaction with each other which was facilitated by the Association."
    },
    {
      "title": "Landmark Legislations Achieved",
      "isShow": false,
      "body":
          "During 1989, there was a strike by both the employees as well as the employers and there was a deadlock between employers and employees defying settlement. The Government of Tamilnadu intervened, brought the employees and employers together and made them implement clauses 12(3) and 18(1) agreements through the Labour Department and Home Secretary. Two of the most important clauses of these Acts were 1. There should be no stoppage of work and any problem should be settled across the table, and 2. The producer members of the Film Chamber and its associates should employ members of FEFSI affiliated unions and vice-versa.\n\nThe truth is that due to the interplay of several factors, these clauses are often not enforced strictly, but steps are constantly been taken to move in this direction. FEFSI, with SICA as one of its affiliates, entered into an agreement with the South India Film Chamber of Commerce on various issues to ensure smooth functioning of the industry. Officials of the Association also had lengthy interaction with the Home Secretary, briefing him in detail about the goings-on in the industry, the impact of the new legislations and how the Federation was serving the needs of the industry workers. This endeavour worked to secure a just solution for both sides and as a result, the employees and employers came closer. Generally, all the efforts bore fruit with the industry as a whole benefiting.\n\nThe Confederation never ceased in its efforts to bring in new laws to protect the interest of the workers. Officials interacted with Union Ministers such as I K Gujral, L K Advani and Bhagat. When Smt. Indira Gandhi was Prime Minister she attempted to bring in legislation which was totally in favour of the producers. The team went through all the clauses in great detail and submitted proposals that were just and fair to all parties concerned. Based on the proposals, the Central Government brought in three bills in Parliament, viz The Cine Workers’ Welfare Cess Act 1981, The Cine Workers’ Welfare Fund Act 1981 and The Cine Workers and Cinema Theatre Workers (Regulation of Employment) Act 1981. Through their enactment, rules were formed and gazetted in 1984 with orders for implementation. Unfortunately however, the benefits due from the enactment of the bills have still not fully reached the cine workers due to apathy and laxity in their implementation."
    },
    {
      "title": "Steps Forward To Progress",
      "isShow": false,
      "body":
          "In due course, finances improved and the Association was in a position to purchase an office room at a commercial complex in Usman Road, T Nagar in 1991. With funds collected through donations the office was properly furnished. A library consisting of technical volumes was set up. Thereafter a membership drive was organized and the ranks swelled considerably.\n\nHowever, individual associations and their members began to migrate to their home states as their respective governments offered them incentive to set up production units there. This led to new problems and the Association involved itself in ameliorating the conditions of affected members. They negotiated with the Film Chamber for enhancement of wages. On one occasion an office bearer was threatened with physical violence. But the Association never wavered from its commitment. Election of office-bearers was always naturally a contentious issue and led to severe competition amongst various groups. Sometimes the State Chief Minister had to intervene and resolve conflicts.\n\nSICA celebrated its Silver Jubilee in 1997 in the august presence of thespian Sivaji Ganesan, who commended the Association for its yeoman services to the workers and to the industry as a whole. A reference book entitled “Indian Cinematographers’ Manual” edited by Sri Hemachandran was released on the occasion. But even after all the bonhomie, the industry continues to be plagued with various problems between employers and employees which are constantly being addressed by the office-bearers. At the behest of Sri P N Sundaram, SICA President, who brought FEFSI and the Tamilnadu Creators and Employees Federation together, an agreement of understanding was signed. In the midst of industry rivalry, SICA has always strived to remain neutral and work towards the welfare of the industry as a whole."
    },
    {
      "title": "The South Indian Scenario",
      "isShow": false,
      "body":
          "Trade Unionism in the film industry of Southern India first began in Madras under the Societies Act by late Sri Ramnath with the formation of the Cine Technicians Association of South India. Primarily, it began as a cultural organization for fellowship and co-operation. The first union as such was formed in 1956 with the registration of the Cine Technicians Guild of South India, CTG. This was an umbrella organization inclusive of all categories of technicians and workers in the industry. The effort was initiated by Sri. Nimai Ghosh, a famous cinematographer from Bengal who came and settled in Madras where he worked and served till his last breath.\n\nCTG gathered momentum and the membership grew by leaps and bounds till, after fourteen years, it was felt necessary to form trade unions craft-wise. And so seventeen cinematographers of that time joined hands to form the Southern India Cinematographers’ Association, SICA, which was registered on 27th November 1972 after all procedural formalities were completed under the Trade Union Act of 1926. Mr. A. Vincent was the Founder-President, Mr.P.N.SUNDARAM the General Secretary and Mr. S. MARUTHI RAO the Treasurer. The office functioned at No.3, Doraisamy Road, Madras-34, the residence of Mr. P.N.SUNDARAM, who devoted a substantial part his time for membership development in spite of his busy work schedules in the industry.\n\nThere was no discrimination of caste, creed, region or religion at all between members belonging to the Southern States of Madras, Mysore, Kerala and Andhra Pradesh. The office bearers used to meet during night hours to discuss ways and means of improving the Association and the lot of its members by instilling self-confidence and unity. The main objective was to engage with the management of studios and producers on behalf of cine workers to secure just and fair working conditions for them. These workers were hired either on monthly salary basis or per movie contract basis and SICA took upon itself to represent them for better emoluments, job security and fair remuneration and benefits.\n\nThis was no easy task as the persons working in the camera department of studios, outdoor units and assistants working with cinematographers were often at the mercy of their employers. Furthermore, students from the film institutes were graduating and getting absorbed into the camera and sound departments. The membership grew by leaps and bounds. Simultaneously, an apex body – Film Employees Federation of South India was registered to unify different categories of trade unions functioning in the Film Industry. There was a great deal of opposition to the emergence of the trade unions and several attempts were made from time to time to break the unity of technicians."
    },
    {
      "title": "Moving Ahead With Gusto",
      "isShow": false,
      "body":
          "However, the Association was able to secure many concessions for its members. Second Sunday of every month was declared as a holiday so that the unions could hold their office bearers meet, solve the members’ problems and also to chalk out programmes. Rules and regulations were formulated and whenever they were violated members were taken to task to infuse in them a sense of discipline. Whenever a worker was denied his dues, no other worker was permitted to complete his assignment till the worker’s dues were fully paid. Similarly, if members went back on their commitments to producers, they were compelled to repay the advance amounts they had received. Such was the discipline maintained.\n\nIn the year 1972 the office was shifted to 57, Arcot Road, Madras-24. Several other sister associations, viz, the Film Employees Federation of South India, Southern India Cinematographers’ Association, Southern India Film Editors’ Association, Cine Art Directors’ Association of South India and Cine Artistes Union functioned from the same premises. All the unions functioned with their own members as office bearers doing voluntary service in their spare time without interference from any outside political and trade unions. Those were extremely difficult times when the members and office bearers lived under constant fear of losing their jobs and not getting contracts for having participated in the trade union movement. Victimisation was rampant and yet members stuck to their guns.\n\nIn 1973, a conference of Southern Zone, Western Zone and Eastern Zone was organized at Madras. Delegates from the three zones met, discussed, exchanged views, came together to safeguard the interests of technicians and cine workers and thus came into existence the All India Film Employees Confederation as the sole representative of employees in the cine industry throughout India."
    },
    {
      "title": "The struggle continues",
      "isShow": false,
      "body":
          "However, although these accomplishments were achieved with great hardship, the exploitation continued. In the aftermath of the closure of many studios resulting in massive retrenchment of workers, the Association took necessary steps to get retrenchment benefits for our members. Many were provided with alternative jobs in outdoor units while others joined freelance cameramen as their assistants and managed to sustain themselves. In the new scenario, with almost everyone working on a freelance basis, new problems began to crop up. First was the question of securing documented work agreements and guaranteed remuneration. There were many producers who recruited our workers and made them complete their assignments, but would not settle them after their work was over. Some of the members came up with a demand that the Association should contact the producer, collect the amount due either on its own or with the co-operation of other affiliated unions or with the help of the laboratories through FEFSI. In the event the producer did not co-operate, then the Association would go to any extent, even ensuring stoppage of work till the demands were met. Yet many of the members did not complain because of the fear of being blacklisted by the producers. Some even lost their money because of delay in approaching the Association.\n\nBut the producers decided to join hands in resisting the activities of the Association. A sensitive situation was also slowly being created as many of the Association members were rising above their individual vocations to become producers and directors. They joined hands with their erstwhile employers. On the 10th of June, 1981, they released an advertisement in the Hindu which said, “We, the undersigned Directors of the South Indian Film Industry wish to inform that we have severed all connections with FEFSI and have organized ourselves under the auspices of the Southern Amalgamated Film Employees’ Union, SAFE. Our action has been taken after great and mature deliberation and the thought has been motivated by the best interests of the industry and for a harmonious and co-operative relationship based film industry.” This was signed by about 2200 names many who were not at all members of SIFDA.\n\nMany members were browbeaten by industry honchos to join SAFE under threat of retrenchment and were compelled to leave SICA. During the existence of SICA for nearly 23 years we have gone through many ups and downs due to the opposition of producers’ bodies to trade unions. Members were counseled not to fall prey to such machinations. There were many strikes and lock-outs but after every crisis, the unions only emerged stronger and members kept returning after realizing their folly. Sri DVS Raju took the lead in compromising for the sake of the film industry and liquidated the SAFE union. Other rival unions that were formed with the co-operation of producers also soon died a natural death."
    },
    {
      "title": "Bringing Home The Benefits",
      "isShow": false,
      "body":
          "The Confederation is engaged in enhancing the skills of its members in tune with their counterparts the world over. In association with foreign embassies, films in different world languages are screened for the benefit of members so they could orient themselves to the latest techniques, equipment and changing technological scenarios in the world film industry. Lecture sessions and workshops are conducted inviting experts from many countries in various trades to imbibe fresh skills in various vocations within the industry. When the conversion from B & W to colour was ushered in, technicians were exposed to the several new techniques that were introduced so they could handle the new situation with ease.\n\nScholarships are provided to the children of cine workers and medical benefits are provided for heart and cancer treatment.\n\nWe are taking all efforts to raise sizable amounts by way of musical performances, bringing out souvenirs and other means. Our unity is our strength and we hope to be able to address their issues. We are striving to provide the masses with wholesome entertainment that is so essential for all sections of society. We depend upon the benevolence of philanthropists from all fields, including our producers, artistes, technicians, other associations and from outside the cine field to contribute liberally towards this cause. We shall be ever grateful to all our benefactors.\n\nArticle by N.S Varma Share on Facebook Tweet about this on Twitter Pin on Pinterest Share on Google+"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('History'),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(height: 20.h),
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(3)),
              child: Image.asset(
                "assets/images/iconHistory.png",
                height: 40.h,
              )),
          SizedBox(height: 20.h),
          Text(
            "SAGA OF DEDICATED SERVICE",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 20.h),
          Image.asset(
            "assets/images/camera.png",
            height: 50.h,
          ),
          SizedBox(height: 16.h),
          ListView.builder(
              itemCount: data.length,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(232, 232, 232, 0.3),
                        ),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              data[index]["isShow"] = !data[index]["isShow"];
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 8.w),
                            //margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(232, 232, 232, 0.8),
                                borderRadius: BorderRadius.circular(3)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data[index]["title"],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        ),
                        AnimatedSize(
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 600),
                          child: data[index]["isShow"] && selectedIndex == index
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  child: Text(
                                    data[index]["body"],
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(height: 1.4, fontSize: 13),
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                );
              })
        ])));
  }
}
