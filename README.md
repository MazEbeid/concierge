Camp concierge - Flutter/Dart repo

The ultimate goal of the camp concierge is to reach the destination caravans in the shortes time possible. Since the time take from going from one caravan to the other is 1 minute (equal), the camp concierge problem can be solved using Breadth First Search while keeping track of the visited caravan predecessor in order to track the shortest path taken. Each journey time is added to the next family's waiting time in order to get the overall time a family waited at the gate before

Technology stack: Flutter/Dart (Native+Web)

Setup: 1- Install flutter and set the development enviroment -> https://flutter.dev/docs/get-started/install 2- Clone the repo 3- Run the project on a simulator or a physical device. 4-To test with different groups you can go to the settings page on the app and paste in a valid [json] - please make sure to follow the correct format (very little exception handling) 5- To test Flutter Web you need to switch to the beta channel -> flutter channel dev (in terminal) then you will be able to see Chrome as a device in your list of devices. 6- To check out the web version without running it through your local machine follow this link https://concierge-e9ea8.firebaseapp.com/#/
