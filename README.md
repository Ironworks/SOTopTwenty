# SOTopTwenty
Stack overflow top 20 users

## Design Decisions

I elected to use MVVM as the main architecture in the app. I also implemented the app using frameworks to split the code up into reusable compnents where possible. 

The main app simply contains the AppDelegate and the SceneDelegate. 

The SOTopTwenty_iOS Framework contains the iOS specific UI. I have also included the code to retrieve the User Images in this framework as it is dependant on UIKit. This could be separated into a framework of its own.

SOTopTwentyKit contains the networking, models and viewModels for the app. This framework is platform independent and could be reused in a Mac or TVOS app.

SOTopTwentyUIKit includes some exisitng code I have that helps to ensure that most ViewControllers and views are created programatically using dependency injection.

I did decide to use a xib file for the TableView Cells, as I find it quicker to layout the view in Interface Builder and as the xibs are small and stand alone they aren;t so much of a risk with regards to merge issues if the app were being worked on by multiple developers. 

## Constraints

Due to time constraints I didn't write as many tests around the Viewcontrollers and tableViewCells as I would have liked to. In that regard I concentrated more on completing the functionality. 





