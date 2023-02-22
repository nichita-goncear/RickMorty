The purpose of this project is to showcase various skills in iOS development through a demo app. It includes an authentication flow that allows users to sign in or register, and the main screen presents a list of characters from the Rick and Morty cartoon. The current project is still **in development**, watch the 'To be added' section for upcoming features and improvements. 

## Initial constraints that were established for the project:

1. When a new character is opened from the "Also from..." section, the "Back" action should not lead to the previously viewed character.
2. All character images must be cached for future use without the need for re-downloading.
3. The design must be compatible with iPhone 11, iPhone 11 Pro, iPhone 11 Pro Max, iPhone 8, and iPhone 8 Plus.
4. Favorites data must be saved in Core Data.
5. User data must also be saved in Core Data, and the user should be able to add characters to their list of favorites.
6. GCD (Grand Central Dispatch) parallelism should be used.
7. The application can be designed using MVC, MVVM, or Viper architecture.
8. An alert should be displayed if the user is not connected to the internet.

## The UI reference: 

<p float="center">
  <img src="https://i.ibb.co/sJjnGff/Untitled.png" width="500" />
  <img src="https://i.ibb.co/9vW10jp/Untitled-2.png" width="500"/> 
</p>

## Implemented: 

1. Prod and Dev invironments.
2. MVVM architecture.
3. NSCache manager to cache images. 
4. Firebase authentication with reference to respective cluster: prod/dev

## To be added: 

### CoreData
1. CoreData to store the user profile in local memory. 
2. Add favorite characters to CoreData.
3. Substitute mock characters on the FavoritesViewController screen with those added to CoreData.
4. Configure UserProfileView with the user model from CoreData.

### UnitTesting 
1. Implement mocks for managers(FirebaseManager, ServiceManager, ApiManger). 
2. Use dependency injection to test the viewModels with the created mocks.

### UI 
1. Add character to favorites functionality.
2. Setup dark mode.
