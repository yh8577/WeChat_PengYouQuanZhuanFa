
#import <UIKit/UIKit.h>


@interface MMUINavigationController : UINavigationController

@end

@interface MMUIViewController : UIViewController
{
    UINavigationController *m_navigationController;
}
@end

@interface WCDragToCloseViewController : MMUIViewController

@end

@interface FullScreenViewController : WCDragToCloseViewController

@end

@interface MMUIScrollView : UIScrollView

@end

@interface MMGrowTextView : UIView
- (void)postTextChangeNotification;
@end

@interface MMTextView : UIView
- (void)setText:(id)arg1;
@end

@interface WCContentItem : NSObject
@property(retain, nonatomic) NSMutableArray *mediaList;
@property(nonatomic) int type;
@end

@interface WCDataItem : NSObject
@property(retain, nonatomic) WCContentItem *contentObj;
@end

@interface WCUrl : NSObject
@property(retain, nonatomic) NSString *url;
@end

@interface WCMediaItem : NSObject
@property(retain, nonatomic) NSString *desc;
@property(nonatomic) int type;
- (id)pathForSightData;
- (id)pathForPreview;
@end

@interface WCOperateFloatView : UIView
{
    MMUINavigationController *navigationController;
}
@property(readonly, nonatomic) WCDataItem * m_item;
@property(nonatomic, weak) MMUINavigationController *navigationController;

@end

@interface WCTimeLineViewController : MMUIViewController
{
    WCOperateFloatView *m_floatOperateView;
}
@end

@interface WCNewCommitViewController : MMUIViewController
{
    WCDataItem *_cacheDateItem;
    UINavigationController *navigationController;
}
@property(nonatomic, weak) UINavigationController *navigationController;
- (id)initWithSightDraft:(id)arg1;
- (id)initWithImages:(id)arg1 contacts:(id)arg2;
- (void)commonInit;
@end


@interface WCImageFullScreenViewContainer : MMUIScrollView
@property(retain, nonatomic) WCMediaItem *m_mediaData;
- (void)tryDownloadImage;
@end


@interface WCSightViewController : FullScreenViewController
{
    WCDataItem *_dataItem;
}
- (void)startLoadFullDownloadView;
@end

@interface MMImage : UIImage
- (void)commonInit;
@end


@interface SightDraft : NSObject
+ (id)draftWithVideoURL:(id)arg1;

@end

@interface SightIconView : UIView
- (void)stopTimer;
@end
