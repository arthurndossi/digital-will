const functions = require("firebase-functions");
const admin = require('firebase-admin');

admin.initializeApp({ credential: admin.credential.applicationDefault() });

const db = admin.firestore();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.registerUser = functions
    .region('europe-central2')
    .firestore
    .document("client/{userID}")
    .onCreate((snap,context) => {
        const newValue = snap.data();
        // Set the usernames collection
        return db.collection("usernames").doc(newValue.username).set({email: newValue.email})
        .then(response => {
            response.status(200).send("Successfully created new user!");
        })
        .catch(error => {
            console.log('Error creating new user:', error);
            return false;
        });
});
// 0 2 * * *
exports.scheduledFunctionCrontab = functions
    .region('europe-west1')
    .pubsub
    .schedule('*/10 * * * *') // 0 0 2 * * ? *
    .timeZone('Europe/Stockholm')
    .onRun((context) => {
        console.log('This will be run every 10 seconds!'); // This will be run every day at 02:00 AM!
        admin.auth().listUsers().then(function (listUsersResult) {
                listUsersResult.users.forEach(function (userRecord) {
                    // For each user
                    // var userData = userRecord.toJSON();
                    // allUsers.push(userData);
                    const lastSignInTime = userRecord.metadata.lastSignInTime;
                    db.collection("clients")
                    .doc(userRecord.uid)
                    .get()
                    .then(doc => {
                        const data = doc.data();
                        var days;
                        const n1days = data.n1Days;
                        const n2days = data.n2Days;
                        const n3days = data.n3Days;
                        const difference = Date.now() - Date.parse(lastSignInTime);
                        let differenceDays = Math.ceil(difference / (1000 * 3600 * 24));
                        console.log("Difference is: " + differenceDays)
                        if (differenceDays < n1days) {
                            if ((n1days - differenceDays) < 7) {
                                // send notification
                            }
                        } else if (differenceDays > n1days && differenceDays < (n1days + n2days)) {
                            days = n1days + n2days;
                            if ((days - differenceDays) < 10) {
                                // send notification
                            }
                        } else if (differenceDays > (n1days + n2days) &&
                            differenceDays < (n1days + n2days + n3Days)) {
                            days = n1days + n2days + n3Days;
                            if ((days - differenceDays) < 5) {
                                // send notification
                            }
                        } else if (differenceDays > (n1days + n2days + n3Days)) {
                            // initiate dead mans switch
                        }
                    });
                });
                response.status(200).send(JSON.stringify(allUsers));
            })
            .catch(function (error) {
                console.log("Error listing users:", error);
                response.status(500).send(error);
            });
  return null;
});