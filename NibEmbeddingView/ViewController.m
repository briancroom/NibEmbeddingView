#import "ViewController.h"
#import "NibEmbeddingView.h"
#import "SampleEmbeddedView.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewCell *prototypeCell;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.prototypeCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    [self.collectionView reloadData];
}

- (void)configureCell:(UICollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    SampleEmbeddedView *view = (SampleEmbeddedView *)((NibEmbeddingView *)[cell.contentView.subviews lastObject]).embeddedView;

    NSMutableArray *numbers = [[NSMutableArray alloc] init];
    for (int i=0; i<=indexPath.item; i++) {
        [numbers addObject:@(i+1)];
    }
    view.label.text = [numbers componentsJoinedByString:@" "];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.prototypeCell) {
        [self configureCell:self.prototypeCell forIndexPath:indexPath];
        return [self.prototypeCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    } else {
        return CGSizeMake(100, 100);
    }
}

@end
