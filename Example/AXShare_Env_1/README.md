https://www.cnblogs.com/feng9exe/p/7562508.html


Info.plist中的NSExtension|NSExtensionAttributes|NSExtensionActivationRule Dictionary可以配置插件支持的媒体类型及数量：

 

iOS扩展插件支持媒体类型配置键

NSExtensionActivationSupportsAttachmentsWithMaxCount
附件最多限制
20
    

附件包括下面的File、Image和Movie三大类，单一、混选总量不超过20

NSExtensionActivationSupportsAttachmentsWithMinCount
    

附件最少限制
    

上面非零时，default=1
    

默认至少选择1个附件，【分享】中才显示扩展插件图标

    NSExtensionActivationSupportsFileWithMaxCount
    

文件最多限制
    

20
    

文件泛指除Image/Movie之外的附件，例如【邮件】附件、【语音备忘录】等。

单一、混选均不超过20。

    NSExtensionActivationSupportsImageWithMaxCount
    

图片最多限制
    

20
    

单一、混选均不超过20

    NSExtensionActivationSupportsMovieWithMaxCount
    

视频最多限制
    

20
    

单一、混选均不超过20

NSExtensionActivationSupportsText
    

文本类型
    

default=0
    

默认不支持文本分享，例如【备忘录】

NSExtensionActivationSupportsWebURLWithMaxCount
    

Web链接最多限制
    

default=0
    

默认不支持分享超链接，例如【Safari】

NSExtensionActivationSupportsWebPageWithMaxCount
    

Web页面最多限制
    

default=0
    

默认不支持Web页面分享，例如【Safari】

 

