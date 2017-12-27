import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension
{
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification)
    {
        guard let attachment = notification.request.content.attachments.first //store the first element in the colletion to attachment
        else
        {
            return
        }
        if attachment.url.startAccessingSecurityScopedResource()
        {
            let imageData = try? Data.init(contentsOf: attachment.url)
            if let img = imageData
            {
                imageView.image = UIImage(data: img)
            }
        }
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void)
    {
        if response.actionIdentifier == "fistBump"
        {
            completion(.dismissAndForwardAction)
        }
        else if response.actionIdentifier == "dismiss"
        {
            completion(.dismissAndForwardAction)
        }
    }
}
