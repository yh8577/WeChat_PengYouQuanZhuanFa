#line 1 "/Users/huig/Desktop/Wechat/Wechat_Hook_log/Wechat_Hook_log/Wechat_Hook_log.xm"


#import <wechatHook.h>


#include <logos/logos.h>
#include <substrate.h>
@class WCTimeLineViewController; @class WCNewCommitViewController; @class MMImage; @class WCImageFullScreenViewContainer; @class SightDraft; @class WCOperateFloatView; @class WCSightViewController; 
static id (*_logos_orig$_ungrouped$WCOperateFloatView$init)(WCOperateFloatView*, SEL); static id _logos_method$_ungrouped$WCOperateFloatView$init(WCOperateFloatView*, SEL); static void _logos_method$_ungrouped$WCOperateFloatView$sharetotimeline$(WCOperateFloatView*, SEL, id); static void (*_logos_orig$_ungrouped$WCNewCommitViewController$viewDidAppear$)(WCNewCommitViewController*, SEL, _Bool); static void _logos_method$_ungrouped$WCNewCommitViewController$viewDidAppear$(WCNewCommitViewController*, SEL, _Bool); 
static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$SightDraft(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SightDraft"); } return _klass; }static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$WCImageFullScreenViewContainer(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("WCImageFullScreenViewContainer"); } return _klass; }static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$MMImage(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("MMImage"); } return _klass; }static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$WCSightViewController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("WCSightViewController"); } return _klass; }static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$WCTimeLineViewController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("WCTimeLineViewController"); } return _klass; }static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$WCNewCommitViewController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("WCNewCommitViewController"); } return _klass; }
#line 6 "/Users/huig/Desktop/Wechat/Wechat_Hook_log/Wechat_Hook_log/Wechat_Hook_log.xm"


static id _logos_method$_ungrouped$WCOperateFloatView$init(WCOperateFloatView* self, SEL _cmd) {
    
    NSLog(@"-[<WCOperateFloatView: %p> init]", self);
    
    id r = _logos_orig$_ungrouped$WCOperateFloatView$init(self, _cmd);
    
    
    [self setFrame:CGRectMake(0, 0, 270, 39)];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(180, 7, 0.2, 25)];
    [v setBackgroundColor:[UIColor blackColor]];
    [v setAlpha:0.2];
    [self addSubview: v];
    UIButton *m_reprintBtn = [[UIButton alloc] initWithFrame:CGRectMake(181, 0, 90, 39)];
    [m_reprintBtn setTitle:@"转发" forState: UIControlStateNormal];
    [m_reprintBtn setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    [m_reprintBtn addTarget:self action:@selector(sharetotimeline:) forControlEvents: UIControlEventTouchUpInside];
    m_reprintBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self addSubview: m_reprintBtn];
    
    return r;
}



NSString *tempText;

static void _logos_method$_ungrouped$WCOperateFloatView$sharetotimeline$(WCOperateFloatView* self, SEL _cmd, id sender){

    NSLog(@"self %@", self);
    
    NSMutableArray *mediaList = [[[self m_item] contentObj] mediaList];

    WCNewCommitViewController *wcvc = [[_logos_static_class_lookup$WCNewCommitViewController() alloc] init];
    
    WCImageFullScreenViewContainer *CImage = [[_logos_static_class_lookup$WCImageFullScreenViewContainer() alloc] init];
    WCSightViewController *sightView = [[_logos_static_class_lookup$WCSightViewController() alloc] init];
    SightDraft *sightDraft;
    
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    
    int type = 0;
    
    for (WCMediaItem *str in mediaList) {
        
        type = str.type;
        
        
        CImage.m_mediaData = str;
        
        if (type == 1) {
            
            [CImage tryDownloadImage];
            
            NSString *path = [str pathForPreview];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            
            MMImage *mmimage = [[_logos_static_class_lookup$MMImage() alloc] initWithImage:image];
            
            [mmimage commonInit];
            
            if (mmimage){
                [imageArray addObject:mmimage];
            }
            
        } else if (type == 5) {
            
            [sightView startLoadFullDownloadView];
            
            sleep(1);
            
            NSString *path = [str pathForSightData];
            
            NSLog(@"path = %@", path);
            
            NSURL *url = [NSURL fileURLWithPath:path];
            
            sightDraft = [_logos_static_class_lookup$SightDraft() draftWithVideoURL:url];
            
        }
        
        NSString *desctext = [str desc];
        if ( desctext.length > 0) {
            tempText = desctext;
        }
        
    }
    
    if (type == 1) {
        
        [wcvc initWithImages:imageArray contacts:nil];
     
    } else if (type == 5){
        
        [wcvc initWithSightDraft:sightDraft];
    }
    
    for (UIViewController *viewController in self.navigationController.viewControllers)
    {
        NSLog(@"=============%@==============count = %ld =========", viewController,(unsigned long)self.navigationController.viewControllers.count);
        
        if ([viewController isKindOfClass:[_logos_static_class_lookup$WCTimeLineViewController() class]])
        {
            
            [viewController.navigationController pushViewController:wcvc animated:YES];
            [viewController release];
            
        }
    }
    
    
    [sightView release];
    [self release];
}







static void _logos_method$_ungrouped$WCNewCommitViewController$viewDidAppear$(WCNewCommitViewController* self, SEL _cmd, _Bool arg1) {
    
   
    NSLog(@"-[<WCNewCommitViewController: %p> viewDidAppear:%d]", self, arg1); _logos_orig$_ungrouped$WCNewCommitViewController$viewDidAppear$(self, _cmd, arg1);

    if (tempText.length > 0 ) {
        MMGrowTextView *grow = MSHookIvar<MMGrowTextView *>(self,"_textView");
        MMTextView *mmtext = MSHookIvar<MMTextView *>(grow,"_textView");
        [mmtext setText:tempText];
        [grow postTextChangeNotification];
    }

    
}






static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$WCOperateFloatView = objc_getClass("WCOperateFloatView"); MSHookMessageEx(_logos_class$_ungrouped$WCOperateFloatView, @selector(init), (IMP)&_logos_method$_ungrouped$WCOperateFloatView$init, (IMP*)&_logos_orig$_ungrouped$WCOperateFloatView$init);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$WCOperateFloatView, @selector(sharetotimeline:), (IMP)&_logos_method$_ungrouped$WCOperateFloatView$sharetotimeline$, _typeEncoding); }Class _logos_class$_ungrouped$WCNewCommitViewController = objc_getClass("WCNewCommitViewController"); MSHookMessageEx(_logos_class$_ungrouped$WCNewCommitViewController, @selector(viewDidAppear:), (IMP)&_logos_method$_ungrouped$WCNewCommitViewController$viewDidAppear$, (IMP*)&_logos_orig$_ungrouped$WCNewCommitViewController$viewDidAppear$);} }
#line 149 "/Users/huig/Desktop/Wechat/Wechat_Hook_log/Wechat_Hook_log/Wechat_Hook_log.xm"
