const admin = require("firebase-admin");
admin.initializeApp();

exports.sendMeetingNotifications = async (meetingData) => {
  try {
    // Retrieve appointment data from Firestore
    const appointmentRef = admin.firestore().collection("appointments").doc(meetingData.appointmentId);
    const appointmentSnapshot = await appointmentRef.get();
    const appointmentData = appointmentSnapshot.data();

    if (!appointmentData) {
      console.error("Appointment data not found");
      return;
    }

    const celebrityId = appointmentData.celebrityId;
    const userId = appointmentData.userId;
    const meetingTime = appointmentData.startTime.toDate();
    const fifteenMinutesBefore = new Date(meetingTime.getTime() - 15 * 60000); // 15 minutes before meeting

    const payloadInstant = {
      notification: {
        title: "New Meeting",
        body: "A fan has scheduled a meeting with you!",
      },
    };

    const payloadScheduled = {
      notification: {
        title: "Meeting Reminder",
        body: "Your meeting is starting in 15 minutes!",
      },
    };

    // Send instant notification to celebrity
    await admin.messaging().sendToTopic(celebrityId, payloadInstant);

    // Schedule notifications 15 minutes before the meeting
    await admin.messaging().sendToTopic(userId, payloadScheduled, {
      timeToLive: 60 * 60, // 1 hour
      scheduledTime: fifteenMinutesBefore,
    });

    console.log("Notifications sent successfully");
  } catch (error) {
    console.error("Error sending notifications:", error);
    // You might want to add more specific error handling here, e.g., retry logic
    // You can also log the error to Firestore or another logging service
  }
};
