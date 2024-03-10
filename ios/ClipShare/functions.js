import firestore from "@react-native-firebase/firestore";

const myFunction = () => {
  const userDocument = firestore().collection("Users").doc("ABC");
  return "hi: ", userDocument;
};
