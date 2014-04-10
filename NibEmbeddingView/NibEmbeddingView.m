#import "NibEmbeddingView.h"

@interface NibEmbeddingView ()
@property (nonatomic, readwrite, strong) NSString *nibName;
@property (nonatomic, readwrite, strong) NSString *nibBundleIdentifier;
@property (nonatomic, readwrite, strong) UIView *embeddedView;
@end

@implementation NibEmbeddingView

- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.nibName) {
        [self embedViewFromNibName:self.nibName bundle:[NSBundle bundleWithIdentifier:self.nibBundleIdentifier]];
    }
}

- (void)embedViewFromNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
    [self.embeddedView removeFromSuperview];

    UIView *view = [[[UINib nibWithNibName:nibName bundle:bundle] instantiateWithOwner:self options:nil] lastObject];
    view.frame = self.bounds;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
    self.embeddedView = view;
    self.nibName = nibName;
    self.nibBundleIdentifier = [bundle bundleIdentifier];
}

@end
