import UIKit
import UserNotifications

class mainVC: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert], completionHandler: //request permission
        {(granted,error) in
            if granted
            {
                print("Notification access granted")
            }
            else
            {
                print(error!.localizedDescription)
            }
        })
    }
    
    @IBAction func notifyButtonTapped(sender: UIButton)
    {
        scheduleNotification(inSeconds: 5)
        {(success) in
            if success
            {
                print("Successfully scheduled notification")
            }
            else
            {
                print("Error scheduling notification")
            }
        }
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ success:Bool) -> ())
    {
        let myImage = "IMG_0390"
        guard let imageURL = Bundle.main.url(forResource: myImage, withExtension: "JPG") //set completion to false and bounch out of the function if we can't find the image
        else
        {
            completion(false)
            return
        }
        
        var attachment:UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageURL, options: .none)
        
        let notif = UNMutableNotificationContent()
        
        //only for extension
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "New notification"
        notif.subtitle = "These are great!"
        notif.body = "The new notification options in iOS 10 are what I've always dreamed of!"
        notif.attachments = [attachment]
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request)
        {error in
            if error != nil
            {
                print(error as Any)
                completion(false)
            }
            else
            {
                print(error as Any)
                completion(true)
            }
        }
    }
}

