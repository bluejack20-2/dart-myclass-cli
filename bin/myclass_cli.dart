import 'dart:convert';
import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:puppeteer/protocol/network.dart';
import 'package:puppeteer/puppeteer.dart';

import 'Schedule.dart';

Future<void> main(List<String> arguments) async {
  printInfo('Starting Puppet');
  var browser = await puppeteer.launch(headless: true);
  var authPage = await browser.newPage();
  printInfo('Puppet Started');

  await authenticateUser(authPage);

  var cookies = await authPage.cookies();
  var cookieParam = covertCookiesToCookieParam(cookies);
  var schedulePage = await browser.newPage();
  var jsonSchedule = await getUserSchedule(schedulePage, cookieParam);

  await browser.close();

  var scheduleList = jsonToSchedule(jsonSchedule).take(10);

  menu(scheduleList);
}

void menu(Iterable<Schedule> scheduleList) {
  var userInput = 0;
  while (true) {
    do {
      print(orange('MYCLASS CLI ' + red('(unofficial)')));
      print(orange('1. View My Schedule'));
      print(orange('2. Go To Meeting'));
      print(orange('3. Exit'));
      userInput =
          int.parse(ask(orange('>> '), required: true, validator: Ask.integer));
    } while (userInput < 1 || userInput > 3);

    switch (userInput) {
      case 1:
        viewSchedule(scheduleList);
        break;
      case 2:
        goToMeeting(scheduleList);
        break;
      case 3:
        printInfo('Goodbye');
        exit(0);
    }
  }
}

void viewSchedule(Iterable<Schedule> scheduleList) {
  printFormatSchedule(scheduleList);
  print('press enter to continue...');
  stdin.readLineSync();
}

Future<void> goToMeeting(Iterable<Schedule> scheduleList) async {
  var count = 1;
  var filteredData =
      scheduleList.where((element) => element.MeetingUrl.length > 10);
  filteredData.forEach((element) {
    print(yellow('| No: $count |') +
        magenta('Date: ${element.DisplayStartDate}') +
        magenta(' Start Time: ${element.StartTime} ') +
        magenta(' Course Name: ${element.CourseTitleEn} '));
    count++;
  });
  var userInput;
  do {
    userInput = int.parse(ask('Choose Meeting:', required: true));
  } while (userInput < 1 || userInput > scheduleList.length);
  userInput -= 1;

  var chooseBrowser;
  do {
    print(blue('Choose Browser'));
    print(yellow('1. Chrome'));
    print(yellow('2. Firefox'));
    chooseBrowser = int.parse(ask('Choose Browser:', required: true));
  } while (chooseBrowser < 1 || chooseBrowser > 2);

  switch (chooseBrowser) {
    case 1:
      await Process.run('chrome', [scheduleList.elementAt(userInput).MeetingUrl]);
      break;
    case 2:
      await Process.run('firefox', ['--new-tab',scheduleList.elementAt(userInput).MeetingUrl]);
      break;
  }
}

void printFormatSchedule(Iterable<Schedule> scheduleList) {
  scheduleList.forEach((element) {
    var gslc = true;
    if (element.MeetingUrl.length != 1) {
      gslc = false;
    }
    print(orange('---------------------------'));
    print(magenta('[COURSE]    : ') + element.CourseTitleEn);
    print(magenta('[DATE]      : ') + element.DisplayStartDate);
    print(magenta('[START TIME]: ') + element.StartTime);
    print(magenta('[END TIME]  : ') + element.EndTime);
    print(magenta('[GSLC]      : ') + gslc.toString());
  });
}

List<Schedule> jsonToSchedule(String jsonString) {
  Iterable iterable = json.decode(jsonString);
  var list = List<Schedule>.from(iterable.map((model) {
    return Schedule.fromJson(model);
  }));
  return list;
}

List<CookieParam> covertCookiesToCookieParam(List<Cookie> cookies) {
  var paramCookie = <CookieParam>[];
  cookies.forEach((element) {
    var param = CookieParam(name: element.name, value: element.value);
    paramCookie.add(param);
  });
  return paramCookie;
}

Future<String> getUserSchedule(
    Page schedulePage, List<CookieParam> param) async {
  const SCHEDULE_URL = 'https://myclass.apps.binus.ac.id/Home/GetViconSchedule';
  const SELECT_BODY = 'document.querySelector("body").innerText';
  await schedulePage.goto(SCHEDULE_URL);
  await schedulePage.setCookies(param);
  var jsonSchedule = await schedulePage.evaluate(SELECT_BODY);
  return jsonSchedule;
}

Future<Page> authenticateUser(Page authPage) async {
  const AUTH_URL = 'https://myclass.apps.binus.ac.id/Auth';
  var isNotLoggedIn = true;
  while (isNotLoggedIn) {
    var username = ask(blue('Username:'), required: true);
    var password = ask(blue('Password:'), required: true, hidden: true);

    await authPage.goto(AUTH_URL, wait: Until.domContentLoaded);
    await authPage.type('#Username', username);
    await authPage.type('#Password', password);
    await authPage.click('#btnSubmit');
    await authPage
        .waitForNavigation(timeout: Duration(seconds: 2))
        .then((value) {
      printInfo('Login Success');
      isNotLoggedIn = false;
    }).catchError((e) {
      printError('Invalid Account');
    });
  }

  return authPage;
}

void printInfo(String message) {
  print(green('[INFO] ') + message);
}

void printError(String message) {
  print(red('[ERROR] ') + message);
}
