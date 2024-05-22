const functions = require("firebase-functions");
const {sendMeetingNotifications} = require("./meetingNotifications");

exports.sendMeetingNotificationsHTTP = functions.https.onRequest(async (request, response) => {
  try {
    const meetingData = request.body; // Assuming meeting data is sent in the request body
    await sendMeetingNotifications(meetingData);
    response.status(200).send("Notification sent successfully");
  } catch (error) {
    console.error("Error sending notification:", error);
    response.status(500).send("Error sending notification");
  }
});
