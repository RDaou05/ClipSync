// Call Firebase Function from didSelectPost():

// Import the writeToFirestore function from the Firebase service file into the module where didSelectPost() is defined, and call it with the video URL when the function is executed.

import { writeToFirestore } from './firebaseService';

const ShareModule = {
  didSelectPost: async (videoURL) => {
    try {
      // Call Firebase function to write to Firestore
      await writeToFirestore(videoURL);
    } catch (error) {
      console.error('Error calling didSelectPost:', error);
    }
  }
};

export default ShareModule;



// Test Your Implementation:

// Test your implementation by triggering the didSelectPost() function and verify that the video URL is written to Firestore.

// With these steps, you'll be able to integrate Firebase into your React Native Expo project and write data to Firestore when the didSelectPost() function is executed.








