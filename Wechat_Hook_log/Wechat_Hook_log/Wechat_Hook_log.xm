

#import <wechatHook.h>


%hook WCOperateFloatView

- (id)init {
    
    %log;
    
    id r = %orig;
    
    //NSLog(@" = %@", r);
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


%new
NSString *tempText;

- (void)sharetotimeline:(id)sender{

    NSLog(@"self %@", self);
    
    NSMutableArray *mediaList = [[[self m_item] contentObj] mediaList];

    WCNewCommitViewController *wcvc = [[%c(WCNewCommitViewController) alloc] init];
    
    WCImageFullScreenViewContainer *CImage = [[%c(WCImageFullScreenViewContainer) alloc] init];
    WCSightViewController *sightView = [[%c(WCSightViewController) alloc] init];
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
            
            MMImage *mmimage = [[%c(MMImage) alloc] initWithImage:image];
            
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
            
            sightDraft = [%c(SightDraft) draftWithVideoURL:url];
            
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
        
        if ([viewController isKindOfClass:[%c(WCTimeLineViewController) class]])
        {
            
            [viewController.navigationController pushViewController:wcvc animated:YES];
            [viewController release];
            
        }
    }
    
    
    [sightView release];
    [self release];
}

%end



%hook WCNewCommitViewController
// 结束
- (void)viewDidAppear:(_Bool)arg1 {
    
   
    %log; %orig;

    if (tempText.length > 0 ) {
        MMGrowTextView *grow = MSHookIvar<MMGrowTextView *>(self,"_textView");
        MMTextView *mmtext = MSHookIvar<MMTextView *>(grow,"_textView");
        [mmtext setText:tempText];
        [grow postTextChangeNotification];
    }

    
}



%end


