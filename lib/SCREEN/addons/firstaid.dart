import 'package:carevista_ver05/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'color.dart' as specialcolor;

class FirstAID extends StatelessWidget {
  const FirstAID({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFF04FBC3),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                LineAwesomeIcons.angle_double_left,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'First AID Treatment',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  //fontFamily: 'brandon_H',
                  color: Theme.of(context).primaryColorDark),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      FirstAIDWidget(
                          title: 'CPR',
                          onPress: () {
                            nextScreen(
                                context,
                                AIDSecond(
                                  title: 'CPR',
                                  // ignore: prefer_interpolation_to_compose_strings
                                  content: "What to Do Before Performing CPR ?\n\nTime is of the essence, but before you attempt CPR on someone, follow these steps:\n\n1. Make sure the environment is safe. A fire, traffic accident, or other dangers could put your own life at risk.\n" +
                                      "2. Try to wake the person. Tap on the person's shoulder firmly and ask " +
                                      '"Are you OK?" in a loud voice. Move on to the next steps after five seconds of trying to wake the patient.\n' +
                                      "3. Call 911. Anytime a patient won't wake up, call 911 immediately or ask a bystander to call. Even if you will perform CPR on the spot, it's important to get paramedics to the scene as quickly as possible.\n" +
                                      "4. Put the person on their back. If it's possible that the person may have had a spinal injury, turn them carefully without moving the head or neck.\n" +
                                      "5. Check for breathing. Tilt the patient's head back to open the airway and determine if they are breathing. If the patient doesn't take a breath after 10 seconds, start CPR.",
                                  sitUrl:
                                      'https://www.verywellhealth.com/how-to-do-cpr-1298446',
                                  imageUrl:
                                      'https://www.verywellhealth.com/thmb/-0j5jrH7djmiKeWYNl89I0qk2qc=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/how-to-do-cpr-1298446-4a04444fabe0467aa9194a9161e5cdb2.png',
                                ));
                          },
                          size: size),
                      const SizedBox(width: 20),
                      FirstAIDWidget(
                          title: 'Nosebleed',
                          onPress: () {
                            nextScreen(
                                context,
                                AIDSecond(
                                    title: 'Nosebleed',
                                    content:
                                        "To treat someone with a nosebleed, ask person to: \n• Sit down and lean their head forward.\n• Using the thumb and index finger, firmly press or pinch the nostrils closed.\n• Continue to apply this pressure continuously for five minutes. \n• Check and repeat until the bleeding stops.\n• If you have nitrile of vinyl gloves, you can press or pinch their nostril closed for them.If the nosebleed continues for 20 minutes or longer, seek emergency medical care. The person should also receive follow-up care if an injury caused the nosebleed.",
                                    sitUrl:
                                        'https://www.firstaidae.com.au/the-great-myth-about-nosebleeds/',
                                    imageUrl:
                                        'https://www.firstaidae.com.au/wp-content/uploads/2019/04/Nosebleed-2.jpg'));
                          },
                          size: size),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      FirstAIDWidget(
                          title: 'Bleeding',
                          onPress: () {
                            nextScreen(
                                context,
                                AIDSecond(
                                    title: 'Bleeding',
                                    content:
                                        "Bleeding is the loss of blood from the circulatory system. Causes can range from small cuts and abrasions to deep cuts and amputations. Injuries to the body can also result in internal bleeding, which can range from minor (seen as superficial bruising) to massive bleeds.\n\nFirst aid for severe external or internal bleeding is critical in order to limit the loss of blood until emergency medical aid arrives. First aid actions to manage external bleeding include applying direct pressure to the wound, maintaining the pressure using pads and bandages, and, raising the injured limb above the level of the heart if possible.\n\nMinor bleeding\n\nSmall cuts and abrasions that are not bleeding excessively can be managed at home. First aid suggestions include:\n• Clean the injured area with sterile gauze soaked in normal saline or clean water. Do not use cotton wool or any material that will fray or leave fluff in the wound.\n• Apply an appropriate dressing such as a band aid or a non-adhesive dressing held in place with a hypoallergenic tape. This dressing must be changed regularly.\n• See your doctor if you can’t remove the dirt yourself. A dirty wound carries a high risk of infection.\n• If you have not had a booster vaccine against tetanus in the last five years, see your doctor.\n",
                                    sitUrl:
                                        'https://www.betterhealth.vic.gov.au/health/conditionsandtreatments/bleeding',
                                    imageUrl:
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Bleeding_finger.jpg/1280px-Bleeding_finger.jpg'));
                          },
                          size: size),
                      const SizedBox(width: 20),
                      FirstAIDWidget(
                          title: 'Choking',
                          onPress: () {
                            nextScreen(
                                context,
                                AIDSecond(
                                    title: "Choking",
                                    content:
                                        "Choking happens when an object lodges in the throat or windpipe blocking the flow of air. In adults, a piece of food is usually to blame. Young children often choke on small objects. Choking is life-threatening. It cuts off oxygen to the brain. Give first aid as quickly as possible if you or someone else is choking.\n\nWatch for these signs of choking:\n\n• One or both hands clutched to the throat\n• A look of panic, shock or confusion\n• Inability to talk\n• Strained or noisy breathing\n• Squeaky sounds when trying to breathe\n• Cough, which may either be weak or forceful\n• Skin, lips and nails that change color turning blue or gray\n• Loss of consciousness",
                                    sitUrl:
                                        'https://www.mayoclinic.org/first-aid/first-aid-choking/basics/art-20056637',
                                    imageUrl:
                                        'https://www.mayoclinic.org/-/media/kcms/gbs/patient-consumer/images/2017/09/22/17/06/composite-five-and-five-heimlich-8col.jpg'));
                          },
                          size: size),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      FirstAIDWidget(
                          title: 'Heatstroke',
                          onPress: () {
                            nextScreen(
                                context,
                                AIDSecond(
                                    title: 'Heatstroke',
                                    content:
                                        "Symptoms\n\n\nHeatstroke signs and symptoms include:\n• High body temperature. A core body temperature of 104 F (40 C) or higher, obtained with a rectal thermometer, is the main sign of heatstroke.\n• Altered mental state or behavior. Confusion, agitation, slurred speech, irritability, delirium, seizures and coma can all result from heatstroke.\n• Alteration in sweating. In heatstroke brought on by hot weather, your skin will feel hot and dry to the touch. However, in heatstroke brought on by strenuous exercise, your skin may feel dry or slightly moist.\n• Nausea and vomiting. You may feel sick to your stomach or vomit.\n• Flushed skin. Your skin may turn red as your body temperature increases.\n• Rapid breathing. Your breathing may become rapid and shallow.\n• Racing heart rate. Your pulse may significantly increase because heat stress places a tremendous burden on your heart to help cool your body.\n• Headache. Your head may throb.",
                                    sitUrl:
                                        'https://my.clevelandclinic.org/health/diseases/21812-heatstroke',
                                    imageUrl:
                                        'https://tse1.mm.bing.net/th?id=OIP.DVeKV-hTz1K_sQGWNj0ZNAHaJl&pid=Api&P=0'));
                          },
                          size: size),
                      const SizedBox(width: 20),
                      FirstAIDWidget(
                          title: 'Dehydration',
                          onPress: () {
                            nextScreen(
                                context,
                                AIDSecond(
                                    title: 'Dehydration',
                                    content:
                                        "Dehydration occurs when someone loses fluid from the body and does not replace it. If untreated, someone with dehydration can develop heat exhaustion. To tackle dehydration, you need to help the person start rehydrating immediately. Offer them small sips of an oral rehydration solution like Drip Drop ORS to replenish fluids fast. If you don't have an oral rehydration solution on hand, offer the patient water until you can get access to one. For small children, you can use clear broth, clear fluids, ice chips, or an oral rehydration solution. Do not give a dehydrated patient soda or juice as this can worsen the condition. When you're dehydrated, water alone is not enough. Your body needs a precise balance of sodium and glucose to fight dehydration fast. That's why it's vital to have a dehydration protocol on hand to help in serious situations.",
                                    sitUrl:
                                        'https://www.webmd.com/a-to-z-guides/dehydration-adults',
                                    imageUrl:
                                        'https://i.pinimg.com/564x/98/00/12/98001226e98b44cc57cbe9f955d4e17c.jpg'));
                          },
                          size: size),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      FirstAIDWidget(
                          title: 'Frostbite',
                          onPress: () {
                            nextScreen(
                                context,
                                AIDSecond(
                                    title: 'Frostbite',
                                    content:
                                        "Frostbite happens when the body's tissues freeze deeply in the cold. This is the opposite of a burn, but the damage it does to your skin is almost the same. Treating frostbite involves carefully and gradually warming the affected area. If at all possible, it should only be done by a medical professional. If that's not possible, or while you're waiting for an ambulance, you can begin first aid for frostbite.\n• Get out of the cold.\n• Put the affected area in warm water (98 to 105 degrees) for 20 to 30 minutes.\n• Do not rub the affected area. \n• Do not use sources of dry heat (e.g, heating pads, fireplace)\n• For fingers and toes, you can put clean cotton balls between them after they have warmed up. \n• Loosely wrap the area with bandages.\n• Use Tylenol (acetaminophen) or Advil (ibuprofen) for pain. \n• Get medical attention as soon as possible.",
                                    sitUrl:
                                        'https://www.mayoclinic.org/diseases-conditions/frostbite/symptoms-causes/syc-20372656',
                                    imageUrl:
                                        'https://pbs.twimg.com/media/BdU8p9tIYAEyJgJ.jpg:large'));
                          },
                          size: size),
                      const SizedBox(width: 20),
                      FirstAIDWidget(
                          title: 'Diabetes',
                          onPress: () {
                            nextScreen(
                                context,
                                AIDSecond(
                                    title: 'Diabetes',
                                    content:
                                        "High blood sugar levels can seriously damage parts of your body, including your feet and your eyes. These are called diabetes complications. Common diabetes health complications include heart disease, chronic kidney disease, nerve damage, and other problems with feet, oral health, vision, hearing, and mental health. High sugar levels in your blood over a long period of time can seriously damage your blood vessels. If your blood vessels aren't working properly, blood can't travel to the parts of your body it needs to. This means your nerves won't work properly either and means you lose feeling in parts of your body. Once you've damaged the blood vessels and nerves in one part of your body, you're more likely to develop similar problems in other parts of your body.Monitoring and preventing diabetes complications include:\n\n• Foot examination to test sensation and look for signs of poor circulation.\n• Eye examination • Urine and blood tests of kidney function.\n• Blood tests for cholesterol levels.\n• Sometimes an electrocardiogram",
                                    sitUrl: '',
                                    imageUrl:
                                        'https://cannabidiol360.com/wp-content/uploads/2018/02/symptoms-of-diabetes-1.jpg'));
                          },
                          size: size),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FirstAIDWidget extends StatelessWidget {
  FirstAIDWidget(
      {super.key,
      required this.size,
      required this.onPress,
      required this.title});
  String title;
  final Size size;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 150,
        width: (size.width - 20) / 2 - 10,
        decoration: const BoxDecoration(
            color: Color(0XFF407BFF),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class AIDSecond extends StatelessWidget {
  AIDSecond(
      {super.key,
      required this.title,
      required this.content,
      required this.sitUrl,
      required this.imageUrl});
  String title;
  String content;
  String sitUrl;
  String imageUrl;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFF04FBC3),
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              LineAwesomeIcons.angle_double_left,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                //fontFamily: 'brandon_H',
                color: Theme.of(context).primaryColorDark),
          ),
        ),
        body: Center(
          child: Container(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 10, bottom: 10),
            width: size.width - 40,
            height: size.height - 110,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  specialcolor.AppColor.gradientFirst.withOpacity(0.9),
                  specialcolor.AppColor.gradientSecond.withOpacity(0.9)
                ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () async {
                        if (await canLaunchUrlString(imageUrl)) {
                          await launchUrlString(imageUrl);
                        } else {}
                      },
                      child: Image(image: Image.network(imageUrl).image)),
                  const SizedBox(height: 10),
                  Text(
                    content,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (await canLaunchUrlString(sitUrl)) {
                        await launchUrlString(sitUrl);
                      } else {}
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 40),
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0XFF407BFF)),
                    child: const Text('More Details Visit'),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
