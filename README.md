# PostApp

# Social Media Post App

    This iOS app allows users to create, view, and interact with social media posts. It features a simple interface built using SwiftUI and VIPER architecture. Users can like, comment, watch, and share posts, with animations and real-time updates.

## Key Features:

    ### Create Posts:

    - `Users can create posts with text and images.`
    - `The app supports image selection from the photo library, allowing users to upload images alongside their posts.`
    - `Posts are saved locally and persist between app launches.`
  
    ### Post Interactions:
  
    - `Users can like, comment, watch, and share posts. These interactions are accompanied by animated visual feedback (like button scaling animation).`
    - `Each post's like, comment, watch, and share counts are updated in real-time.`
    
    ### Persistent Local Storage:
    
    - `All posts, including user interactions (like counts, watch counts, etc.), are stored locally using SwiftStorage, which ensures data persistence across app sessions.`
    - `New posts, including those with images, are saved and can be viewed after restarting the app.`
    
    ### Post Filtering:
    
    - `Users can filter posts to view either All Posts or My Posts.`
    - `A custom picker is used to switch between these views, providing a clean user experience.`
    
    ### Animations:
    
    - `Like button interactions are animated with a spring effect, making the user experience more dynamic and engaging.`
    - `The app's interface includes smooth transitions and animations for button interactions.`


## Architecture:
    
    ### VIPER Architecture:
This app uses the VIPER (View, Interactor, Presenter, Entity, Router) architecture, which helps in organizing the app's components into distinct layers for easier maintenance and scalability.`
    
    ### SwiftUI:
The app leverages SwiftUI for building the user interface, allowing for a declarative and reactive approach to UI updates.`

## Local Storage:
    - `SwiftStorage:`
    - `The app utilizes SwiftStorage to save posts and user interactions locally on the device. When a user creates a new post or interacts with an existing post (e.g., likes or shares), the data is stored persistently.`
    - `Local storage is used for both posts and dynamic data like the number of likes, comments, and shares. This ensures that the app's data is retained between app sessions.`
    
    
## How It Works:
### Creating Posts:
- `The user can create a new post with optional text and an image.`
- `The app supports images selected from the device's photo library. If no image is selected, a default image (or no image) will be associated with the post.`
- `The post is then saved locally using SwiftStorage.`

### Viewing Posts:
- `On the main screen, users can see a list of all posts (or their own posts, based on the filter).`
- `The app checks if each post has an associated image and displays it accordingly. The image is either loaded from the local file system or displayed as an SF Symbol if it's a system image.`

### Interacting with Posts:
- `Each post has buttons to like, comment, watch, and share.`
- `When a user likes a post, an animation is applied to the like button, providing immediate feedback.`
- `The interaction count (likes, comments, watches, shares) is stored locally and updates in real-time.`

### Post Filtering:
- `Users can filter posts to show either All Posts or My Posts using a custom picker.`
- `This filter works by selecting posts created by the logged-in user (if applicable) or displaying all posts for a broader view.`

### Sharing Posts:
- `Users can share posts using the share button, which opens a share sheet that allows sharing of the post content.`

## Local Storage Implementation:

### SwiftStorage is used for persisting post data. Posts, including their content (text and images), and interactions (likes, comments, etc.), are saved and retrieved from local storage when the app restarts.`

### Persistent Data Handling:
    - `Posts are stored in a local array, and each post's interactions (like counts, watch counts, etc.) are saved as part of the post.`
    - `New posts are added and saved in the storage as the user creates them.`
    - `The app ensures that the data is synchronized with local storage to persist it across app sessions.`

## Requirements:
### iOS 15.0 or later
### Swift 5+
### SwiftUI



