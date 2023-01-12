# MovieProject

MovieProject is a project for two pages app in the first page we are getting most popular and now playing data at the time of scrolling the cells we are fetching more data from the server. When user tap on any movie, on behalf of that id we are fetching the movie detail and open the next screen for it.  


Architecure
____

In the app we are using Using MVVM architecture each controller  has their own view model class. Business logic are seperate from view controller.


Project
-----
* `Extensions.swift` - List of extension which used for the class
* `KeyConstants.swift` - All the constant values are written in this class
* `URLHelper.swift` - Well maintained designs for endpoints of the app, Base url, method type, encoding are all managed in one class
* `ReachabilityManager.swift` - To check the internet connection of the app
* `APIManager.swift` - Api class to fetch the data from server if developer wants to cancel the request we have setup different methods for it. We just have to pass a model of the json then all the data is converted from JSON to a model class and written with type safe way.

Unit Test cases
* All the class have unit test cases. In the class we are using the Mock server with already build JSON Files which are in the project 
* Every ViewModel class has their protocol methods, we are using the same methods to fetch the data



Developed By
-----

Love Kumar love.kumar@xebia.com

