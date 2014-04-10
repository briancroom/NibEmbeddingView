#import "NibEmbeddingView.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

@interface MyView : UIView
@end
@implementation MyView
@end

SPEC_BEGIN(NibEmbeddingViewSpec)

describe(@"NibEmbeddingView", ^{
    __block NibEmbeddingView *view;

    sharedExamplesFor(@"embedding a view from a nib", ^(NSDictionary *sharedContext) {
        it(@"should add the view from the nib as a subview", ^{
            [view.subviews count] should equal(1);
            [view.subviews lastObject] should be_instance_of([MyView class]);
        });

        it(@"should expose the embedded view", ^{
            MyView *embeddedView = [view.subviews lastObject];
            view.embeddedView should equal(embeddedView);
        });

        describe(@"laying out the embedded view", ^{
            CGRect modifiedFrame = CGRectMake(0, 0, 50, 200);
            __block MyView *embeddedView;
            beforeEach(^{
                embeddedView = [view.subviews lastObject];
                view.frame = modifiedFrame;
                [view layoutIfNeeded];
            });

            it(@"should make the embedded view's frame match its bounds", ^{
                embeddedView.frame should equal(modifiedFrame);
            });
        });

        describe(@"embedding a different view", ^{
            __block UIView *oldEmbeddedView;
            beforeEach(^{
                oldEmbeddedView = view.embeddedView;
                [view embedViewFromNibName:@"MyView" bundle:[NSBundle bundleForClass:[self class]]];
            });

            it(@"should remove the old view", ^{
                view.subviews should_not contain(oldEmbeddedView);
            });

            it(@"should add the new view", ^{
                [view.subviews count] should equal(1);
                [view.subviews lastObject] should be_instance_of([MyView class]);
            });
        });
    });

    context(@"when created programmatically", ^{
        beforeEach(^{
            view = [[NibEmbeddingView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            [view embedViewFromNibName:@"MyView" bundle:[NSBundle bundleForClass:[self class]]];
        });

        itShouldBehaveLike(@"embedding a view from a nib");
    });

    context(@"when created from a nib", ^{
        beforeEach(^{
            view = [[[UINib nibWithNibName:@"NibEmbeddingViewTest" bundle:[NSBundle bundleForClass:[self class]]] instantiateWithOwner:nil options:nil] lastObject];
        });

        itShouldBehaveLike(@"embedding a view from a nib");
    });
});

SPEC_END
