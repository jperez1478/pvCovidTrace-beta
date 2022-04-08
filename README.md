# pvCovidTrace-beta

# PVCovidTrace


# SeniorProject

## Current Problem 
As school reopen, it is impossible to ignore the effects COVID-19 has had on the learning environment as well as the concerns associated with COVID-19 and the lack of efficient contact tracing on campus.
In addition, almost all cases are reported on social media platforms, causing paranoia and many questions amongst students who live on campus. 

# Solution 
Our mobile application will have hotspots where ppl can check-in and have better accuracy to who was last there and who they were in contact with. 
In the map, it will also show the cases and date they have been reported. 
This will assist in knowing where to avoid while quantities happen. 
With this mobile application, college campuses can help better inform students and faculty which areas have had more cases.

# Cloud Kit Database


Cloud kit was introduced by Apple in 2014 esentially its Apple's Back End Service. 


Guranteed with no scaling issues, apple uses it with million of users notes app, appstore, news app. 

 //price database 
 - free data up to 10GB 
 - cloudkit free up the more users you have 

Cloud Kit Pros 
1. Automatic Authentication : No need for login screen , linked to user icloud account 
      - user is created once the icloud is connected 
2. Syncs Across Devices 
    - sync across devices 
3. Apple's First Party Framework 
     - supportive photos, notes , news app 

 
 # Cons 
 - Apple only 
 - not for android devices 
 - supports only the apple eco system 
 
 
# Why we drifted away from firebase 
Firebase is owned by google 
Apple won't deal with Swift packages or sdks making the app heavy 

# Setting Up iCloud Kit 
  - First stat with making  a "Container" 
  - Container needs to be created on xcode 
  - Container is the overall container in our moble app 
- Container contains a public, private, shared  
    - Public Database : Allows every user to see ex: news app, wwdc app videos, our example would be  displaying the pvlocations 
    - Private Database: for user specififc data ex:notes app, goes againt user icloud data not the apps data 
    - private backend i cannot see user data  i get up to apples privacy accesebility 
    - Shared Database : collaborating as user ex: note sharing lates iOS update
 Again Cloud kit supports  Three type of Databases 
  1) Public Database 
  2) Private Database 
  3) Shared Database 

Will be using icloud Public Databse: To allow other users see users checked in in the locations 

 <img width="300" alt="Screen Shot 2022-03-23 at 12 58 42 AM" src="https://user-images.githubusercontent.com/61983873/159633564-8ac53580-9115-4eaf-9359-cbddba205b98.png">

 
 #Break down of the database in icloud and saving locations 
 
 - Record Type 

# Backend 

Create a cloudkitManger file to be able to make network call to our cloudkit database.
It was a great move the Cloudkit backend as it is a great way to utilize our Developer license.


<img width="263" alt="Screen Shot 2022-03-07 at 12 19 07 PM" src="https://user-images.githubusercontent.com/61983873/157105436-bdf7e97b-f4d2-4c38-b2f7-ea9fcd924dac.png">
<img width="579" alt="Screen Shot 2022-03-07 at 12 34 14 PM" src="https://user-images.githubusercontent.com/61983873/157105462-d52b2df5-8e07-42e7-8b0f-fb42cafa5626.png">




<img width="736" alt="Screen Shot 2022-03-23 at 1 00 47 AM" src="https://user-images.githubusercontent.com/61983873/159633872-f799fc11-ee6c-4432-b07f-a00da2179902.png">

<img width="420" alt="Screen Shot 2022-03-23 at 1 03 20 AM" src="https://user-images.githubusercontent.com/61983873/159634166-3f8f789a-58e2-4ba4-9960-8501fcb20b01.png">


<img width="353" alt="Screen Shot 2022-03-23 at 1 04 47 AM" src="https://user-images.githubusercontent.com/61983873/159634313-d355ceac-ff2e-4192-8eba-07bb1a5a1b0b.png">
//back pouinter for refrence dif users will be refrence by .ischeckedin a user will be created into the "pvprofile object
