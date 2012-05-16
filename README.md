## NoticeView

A TweetBot-like notice component for iOS.

<br/>
![Alt text](http://cloud.github.com/downloads/tciuro/NoticeView/screenshot.png)
<br/>
<br/>

## Usage

* Drop the WBNoticeView folder in your project
* Add QuartzCore.framework to your project

### Examples

To display a small error notice:

	WBNoticeView *nm = [WBNoticeView defaultManager];<br/>
	[nm showErrorNoticeInView:self.view title:@"Network Error" message:@"Check your network connection."];
	
To display a large error notice, make the text long enough to wrap to another line. Only two lines are supported. If the text doesn't fit in two lines, an ellipsis will be appended at the end of the second line:

	WBNoticeView *nm = [WBNoticeView defaultManager];
	[nm showErrorNoticeInView:self.view title:@"Network Error" message:@"Check your network connection. Twitter could also be down."];

To display a small success notice:

	WBNoticeView *nm = [WBNoticeView defaultManager];
	[nm showSuccessNoticeInView:self.view message:@"Link Saved Successfully"];
	
## Notes

- If you pass nil instead of a valid UIView, an NSInvalidArgumentException exception will be raised.
- Default values: title (@"Unknown Error"), message (@"Information not provided."), duration (0.3) and delay (2.0)

## Contribute

I'd love to include your contributions. Feel free to improve it, send comments or suggestions. If you have improvements please [send me a pull request](https://github.com/tciuro/NoticeView/pull/new/master).

## Contact Me

You can ping me on Twitter — [@titusmagnus](http://twitter.com/titusmagnus).