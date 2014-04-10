#import <UIKit/UIKit.h>

@interface NibEmbeddingView : UIView

@property (nonatomic, readonly) NSString *nibName;
@property (nonatomic, readonly) NSString *nibBundleIdentifier;
@property (nonatomic, readonly) UIView *embeddedView;

- (void)embedViewFromNibName:(NSString *)nibName bundle:(NSBundle *)bundle;

@end
