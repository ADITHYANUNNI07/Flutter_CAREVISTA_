import 'package:carevista_ver05/SCREEN/addons/firstAID.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DiseaseComplication extends StatelessWidget {
  const DiseaseComplication({super.key});

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
            'Disease Compilation',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                //fontFamily: 'brandon_H',
                color: Theme.of(context).primaryColorDark),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    FirstAIDWidget(
                        size: size,
                        onPress: () {
                          nextScreen(
                              context,
                              AIDSecond(
                                  title: 'Cancer',
                                  content:
                                      "Cancer refers to any one of a large number of diseases characterized by the development of abnormal cells that divide uncontrollably and have the ability to infiltrate and destroy normal body tissue. Cancer often has the ability to spread throughout your body. Cancer is caused by changes (mutations) to the DNA within cells. The DNA inside a cell is packaged into a large number of individual genes, each of which contains a set of instructions telling the cell what functions to perform, as well as how to grow and divide. Cancer and its treatment can cause several complications, including:\n• Pain\n• Fatigue\n• Difficulty breathing\n• Nausea\n Diarrhea or constipation\n• Weight loss\n• Chemical Changes in body\n Brain and problems\n Unusual nervous system immune system reactions to cancer\n",
                                  sitUrl:
                                      'https://www.who.int/news-room/fact-sheets/detail/cancer',
                                  imageUrl:
                                      'https://tse3.mm.bing.net/th?id=OIP.Xci7HeacIWJFxanZITU6XAHaE8&pid=Api&P=0'));
                        },
                        title: 'Cancer'),
                    const SizedBox(width: 20),
                    FirstAIDWidget(
                        size: size,
                        onPress: () {
                          nextScreen(
                              context,
                              AIDSecond(
                                  title: 'Stomach Disorder',
                                  content:
                                      "The gastrointestinal (GI) tract consists of the mouth, stomach, and intestines. Together with the liver, gallbladder, and pancreas, these organs work together to absorb nutrients and expel waste. Disturbances to this process can cause a range of symptoms, from cramps to vomiting. Many of these issues may pass with time and pose little risk of complication. However, seemingly common stomach issues can be the result of several digestive disorders. If dairy is causing your problems, taking these tablets or drops just before you eat will help you digest lactose (the main sugar in dairy foods) and reduce gas. Taking liquids or tablets can relieve the uncomfortable bloating and pain from gas.\n. Gas and bloating can be reduced. \n• Cut back on fatty foods. \n• Avoid fizzy drinks.\n. Eat and drink slowly. \n• Quit smoking.\n. Don't chew gum.\n• Exercise more. \n• Avoid foods that cause gas.\n• Avoid sweeteners that cause gas such as fructose and sorbitol. They are often found in candies, chewing gum, energy bars, and low-carb foods.\n",
                                  sitUrl:
                                      'https://www.healthline.com/health/stomach',
                                  imageUrl:
                                      'https://tse4.mm.bing.net/th?id=OIP.rUwGWSbVz0rGj7GEysXpnwHaE7&pid=Api&P=0'));
                        },
                        title: 'Stomach Disorder')
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    FirstAIDWidget(
                        size: size,
                        onPress: () {
                          nextScreen(
                              context,
                              AIDSecond(
                                  title: 'Heart Disease',
                                  content:
                                      "Heart disease refers to any condition affecting the cardiovascular system. There are several different types of heart disease, and they affect the heart and blood vessels in different ways. The symptoms of heart disease depend on the specific type a person has. Also, some heart conditions cause no symptoms at all. The following symptoms may indicate a heart problem:\n• angina, or chest pain\n• difficulty breathing\n• fatigue and lightheadedness\n• swelling due to fluid. retention, or edema\n• fatigue\n• an irregular heartbeatHealthy lifestyle choices can help you prevent heart disease. They can also help you treat the condition and prevent it from getting worse. Your diet is one of the first areas you may seek to change. A medication may be necessary to treat certain types of heart disease. Your doctor can prescribe a medication that can either cure or control your heart disease. Medications may also be prescribed to slow or stop the risk for complications. In some cases of heart disease, surgery or a medical procedure is necessary to treat the condition and prevent worsening symptoms.\n",
                                  sitUrl:
                                      'https://www.medicalnewstoday.com/articles/237191',
                                  imageUrl:
                                      "https://tse3.mm.bing.net/th?id=OIP.Ojj8GIOP50KAh36ovmpzKAHaFu&pid=Api&P=0"));
                        },
                        title: 'Heart Disease'),
                    const SizedBox(width: 20),
                    FirstAIDWidget(
                        size: size,
                        onPress: () {
                          nextScreen(
                              context,
                              AIDSecond(
                                  title: 'Diabetes',
                                  content:
                                      "High blood sugar levels can seriously damage parts of your body, including your feet and your eyes. These are called diabetes complications. Common diabetes health complications include heart disease, chronic kidney disease, nerve damage, and other problems with feet, oral health, vision, hearing, and mental health. High sugar levels in your blood over a long period of time can seriously damage your blood vessels. If your blood vessels aren't working properly, blood can't travel to the parts of your body it needs to. This means your nerves won't work properly either and means you lose feeling in parts of your body. Once you've damaged the blood vessels and nerves in one part of your body, you're more likely to develop similar problems in other parts of your body.Monitoring and preventing diabetes complications include:\n• Foot examination to test sensation and look for signs of poor circulation\n• Eye examination\n• Urine and blood tests of kidney function\n",
                                  sitUrl:
                                      'https://www.mayoclinic.org/diseases-conditions/diabetes/symptoms-causes/syc-20371444',
                                  imageUrl:
                                      'https://tse2.mm.bing.net/th?id=OIP.3hcw2XwmJ2fQmWj9gPlVOQHaFj&pid=Api&P=0'));
                        },
                        title: 'Diabetes')
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    FirstAIDWidget(
                        size: size,
                        onPress: () {
                          nextScreen(
                              context,
                              AIDSecond(
                                  title: 'Depression and Anxiety',
                                  content:
                                      "Depression and anxiety might seem pretty distinct, for the most part. The main symptom of depression is typically a lingering low, sad, or hopeless mood, while anxiety mainly involves overwhelming feelings of worry, nervousness, and fear. But these conditions do actually share several key signs. Anxiety, for example, often involves irritability and some people with depression may feel more irritable than sad.Symptoms you could experience with either condition include:\n• Changes in sleep patterns\n• Changes in energy level\n• Increased irritability\n• Trouble with concentration, focus, and memory\n• Aches and pains or stomach issues that have no clear cauself you are not feeling quite like yourself, a good next step involves reaching out to a mental health professional or other clinician who treats anxiety and depression",
                                  sitUrl:
                                      'https://www.verywellhealth.com/depression-and-anxiety-signs-symptoms-and-treatment-5191284',
                                  imageUrl:
                                      "https://www.verywellhealth.com/thmb/lShUzbZIraDFMzoRN36m_oHwmAY=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/depression-and-anxiety-signs-symptoms-and-treatment-5191284-FINAL-f910ecac46dc4158adba807f2e4f7dd8.jpg"));
                        },
                        title: 'Depression and Anxiety'),
                    const SizedBox(width: 20),
                    FirstAIDWidget(
                        size: size,
                        onPress: () {
                          nextScreen(
                              context,
                              AIDSecond(
                                  title: 'High Blood Pressure',
                                  content:
                                      "High blood pressure, also known as hypertension, is a frequent illness where the blood's long-term push on your artery walls is so great that it may eventually result in health issues including heart disease. Blood pressure is influenced by both how much blood your heart pumps and how much resistance your arteries provide to blood flow. Your blood pressure will increase as your arteries get more constricted and your heart pumps more blood. Usually a chronic illness, high blood pressure damages the body over time. Blood pressure issues can result in:\n• Blindness \n Chest pain\n• Complications in pregnancy\n• Heart attack\n• Memory loss, personality changes, trouble concentrating, irritability or progressive loss of consciousness\n• Severe damage to the body's main artery\n• Stroke\n• Sudden impaired pumping of the heart, leading to fluid backup in the lungs resulting in shortness of breath\n• Sudden loss of kidney functionlf your blood pressure readings exceed 180/120 mm Hg and you have any symptoms such as headache, chest pain, nausea/vomiting or dizziness, contact hospital emergency. If you don't have any symptoms, wait five minutes and then test your blood pressure again.Also contact your health care professional immediately if your readings are still unusually high and you aren't experiencing any other symptoms of target organ damage such as chest pain, shortness of breath, back pain, numbness/weakness, change in vision or difficulty speaking. You could be experiencing a hypertensive crisis.",
                                  sitUrl:
                                      'https://www.mayoclinic.org/diseases-conditions/high-blood-pressure/in-depth/high-blood-pressure/art-20046974',
                                  imageUrl:
                                      'https://tse4.mm.bing.net/th?id=OIP.zmwTD6elMYoy-uREQgVIhAHaD4&pid=Api&P=0'));
                        },
                        title: 'High Blood Pressure')
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
