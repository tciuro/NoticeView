## NoticeView

A TweetBot-like notice component for iOS.

<br/>
![Alt text](http://cloud.github.com/downloads/tciuro/NoticeView/screenshot_2.0.1.png)
<br/>
<br/>

## Usage

* Drop the WBNoticeView folder in your project
* Add QuartzCore.framework to your project

### NoticeView 1.0 vs 2.0

The behavior in version 1 was "fire and forget". Calling *showErrorNoticeInView* or *showSuccessNoticeInView* displayed the notice, but there was no way to retain it for later use. Version 2 allows the developer to instantiate a notice, customize it (optional) and show it. Not only it's possible to retain it, but also customize it anytime with say, a different title and message. Oh, yeah… and it's cleaner too.

### New in 2.1: Sticky Notice

New in 2.1 is a different type of notice: Sticky. As it name implies, the notice will remain visible until the user taps on it to dismiss it. The usage follows the Error and Success notice pattern:

    WBStickyNoticeView *notice = [WBStickyNoticeView stickyNoticeInView:self.view title:@"7 New Tweets."];
    [notice show];
    
### New in 2.3: Make any Notice Sticky

Some users have asked whether 'sticky' could be a property of any notice view. Well, I'm happy to report that starting with version 2.3, all notice types can be made sticky. The usage follows the regular pattern, only this time we set the 'sticky' property accordingly:

    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"Network Error" message:@"Check your network connection."];
    notice.sticky = YES;
    [notice show];

### Examples

Since version 2 is more flexible, I have eliminated the older examples and replaced them with the new API. Please note that the older API is still there, for backward compatibility.
<br/>

To display a small error notice:

    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"Network Error" message:@"Check your network connection."];
    [notice show];
	
If the message provided doesn't fit in one line, the notice will be enlarged to accommodate the text:

    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"Network Error" message:@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."];
    [notice show];

To display a small success notice:

    WBSuccessNoticeView *notice = [WBSuccessNoticeView successNoticeInView:self.view title:@"Link Saved Successfully"];
    [notice show];
    
### New in 2.3.1: Dismissing a Notice Manually

Starting with 2.3.1, any notice with the 'sticky' property set can be dismissed at will. This could happen for example when an specific event is detected. Just invoke 'dismissNotice' on the notice whenever you're ready to dismiss it:

    [myNotice dismissNotice];
    
Check the demo project to see it in action.

### New in 2.4: Specify a completion block when a notice is dismissed

Starting with 2.4, any notice can have a completion block associated with it. This block will be invoked when the notice has been dismissed (works on sticky and non-sticky notices):

    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self.view title:NSLocalizedString(@"Signup Error", nil) message:NSLocalizedString(@"You need to fill out all entries in this screen to signup.", nil)];
    notice.sticky = YES;
    notice.dismissedBlock = ^{
        NSLog(@"The notice has been dismissed!");
    };

### Customizing the Notice

Instead of piling up a bunch of arguments in a method call, I decided to use properties instead. This way, new properties can be added easily without having to clutter the API with specialized methods.

Example: customize a success notice with a bit of transparency and placing the notice at a specific Y coordinate:

    WBSuccessNoticeView *notice = [WBSuccessNoticeView successNoticeInView:self.view title:@"Link Saved Successfully"];
    
    notice.alpha = 0.8;
    notice.originY = self.headerView.frame.size.height;
    
    [notice show];

	
## Notes

> If you pass nil instead of a valid UIView, an NSInvalidArgumentException exception will be raised.

The default values are the following:

        if (nil == title) title = @"Unknown Error";
        if (nil == message) message = @"Information not provided.";
        if (0.0 == duration) duration = 0.5;
        if (0.0 == delay) delay = 2.0;
        if (0.0 == alpha) alpha = 1.0;
		if (origin < 0.0) origin = 0.0;

## Contribute

I'd love to include your contributions. Feel free to improve it, send comments or suggestions. If you have improvements please [send me a pull request](https://github.com/tciuro/NoticeView/pull/new/master).

## Contact Me

You can ping me on Twitter — [@titusmagnus](http://twitter.com/titusmagnus).