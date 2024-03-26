import firestore from "@react-native-firebase/firestore";
import { NativeModules } from "react-native";
const { ShareViewController } = NativeModules;

export const myFunction = () => {
  firestore()
    .collection("Users")
    .add({
      name: "Ada Lovelace",
      age: 30,
    })
    .then(() => {
      console.log("User added!");
    });
  return "hi: ", userDocument;
};
