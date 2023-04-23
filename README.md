used packages:  

1.FSCalendar  
2.Realm  
3.RealmDatabase  

I used Swift Package Manager  

If you would rather use CocoaPods  
use this template for your Podfile  

"  
Uncomment the next line to define a global platform for your project  
platform :ios, '9.0'  

target 'your_project_name' do  
Comment the next line if you don't want to use dynamic frameworks  
use_frameworks!  
pod 'FSCalendar'  
pod 'RealmSwift', '~>10'  

end  
"  
