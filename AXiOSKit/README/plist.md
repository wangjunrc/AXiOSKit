
## iTunes操作手机上APP的Documents
```
Application supports iTunes file sharing
```
## 在文件系统中显示
```
Supports Document Browser
```
## 可以获得第三方 app 的文件
```
Supports opening documents in place
```
# info.plist配置
## 隐私权限
```
<key>NSCalendarsUsageDescription</key>
<string>使用此功能需要访问您的日历</string>
<key>NSCameraUsageDescription</key>
<string>使用此功能需要访问您的相机</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>我们需要使用你的位置向你推送更适合的内容</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>我们需要使用你的位置向你推送更适合的内容</string>
<key>NSMotionUsageDescription</key>
<string>需要你的同意获取运动传感器，用于计步信息的记录。</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>使用此功能需要访问您的相册</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>使用此功能需要访问您的相册</string>
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>

<key>LSApplicationQueriesSchemes</key>
<array>
<string>weixin</string>
</array>

<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
<key>NSExceptionDomains</key>
<dict>
<key>sina.cn</key>
<dict>
<key>NSExceptionRequiresForwardSecrecy</key>
<false/>
<key>NSIncludesSubdomains</key>
<true/>
<key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
<true/>
<key>NSTemporaryExceptionMinimumTLSVersion</key>
<string>TLSv1.0</string>
</dict>
</dict>
</dict>
```
