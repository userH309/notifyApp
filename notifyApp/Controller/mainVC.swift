import UIKit
import UserNotifications

class mainVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //Request permission to recieve notifications.
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert], completionHandler: { (granted,error) in
            if granted {
                print("Notification access granted")
            }
            else {
                print("Notication access denied")
            }
        })
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ success:Bool) -> ()) {
        //Store url for internal file if it exists.
        guard let imageURL = Bundle.main.url(forResource: "IMG_0390", withExtension: "JPG")
        else {
            //Set completion to false and bounch out of the function.
            completion(false)
            return
        }
        var attachment:UNNotificationAttachment
        //Try to validate the attachment which is our image, then store it.
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageURL, options: .none)
        let notif = UNMutableNotificationContent()
        notif.categoryIdentifier = "myNotificationCategory"
        notif.title = "Hey check this out!"
        notif.subtitle = "We have ourselves a notification here."
        notif.body = "Yes, well done you've read to this point, thats good!"
        //Add our attachment to the notification.
        notif.attachments = [attachment]
        //Use the time passed in with parameter to set the interval.
        let notifTriggerTime = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        //Create the request.
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTriggerTime)
        //Schedule the notification for delivery.
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print(error as Any)
                completion(false)
            }
            else {
                print(error as Any)
                completion(true)
            }
        }
    }
    
    //Run when button is pushed.
    @IBAction func notifyButtonTapped(sender: UIButton) {
        //Run and pass in 5 seconds to the scheduleNotification function.
        scheduleNotification(inSeconds: 5) { (success) in
            if success {
                print("Successfully scheduled notification")
            }
            else {
                print("Error scheduling notification")
            }
        }
    }
}

