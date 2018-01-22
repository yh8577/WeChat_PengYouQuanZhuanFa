


/*
 
 
 
 
 
 #import <UIKit/UIKit.h>
 
 
 @class WCPOIStarView;
 @class WCDragDeleteBarView;
 @class SightView;
 @class MMAsset;
 @class SightDraft;
 @class CLLocation;
 @class EmoticonBoardView;
 @class WCMusicInfo;
 @class WCLocationInfo;
 @class MMGrowTextView;
 @class MMTextView;
 
 
 @class WCContentItem;
 @interface WCContentItem : NSObject <NSCoding>
 @property(retain, nonatomic) NSMutableArray *mediaList;
 @end
 
 
 @class WCDataItem;
 @interface WCDataItem : NSObject <NSCoding>
 @property(retain, nonatomic) WCContentItem *contentObj;
 
 @end
 
 @class WCUrl;
 @interface WCUrl : NSObject <NSCoding>
 @property(retain, nonatomic) NSString *url;
 @end
 
 
 @class WCMediaItem;
 @interface WCMediaItem : NSObject <NSCoding>
 
 @property(retain, nonatomic) WCUrl *dataUrl;
 @property(retain, nonatomic) NSString *desc;
 @end
 
 
 
 @interface WCOperateFloatView : UIView
 @property(nonatomic,retain) UINavigationController * navigationController;
 @property(readonly, nonatomic) WCDataItem *m_item;
 @end
 
 
 @interface WCNewCommitViewController
 {
 WCDataItem *_cacheDateItem;
 
 }
 
 @end
 
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
 
 return r; }
 
 %new
 
 
 NSString *tempText;
 
 - (void)sharetotimeline:(id)sender{
 
 //tempData = [self m_item];
 
 WCContentItem* obj = [[self m_item] contentObj];
 
 NSMutableArray *mediaList = [obj mediaList];
 
 for (WCMediaItem *str in mediaList) {
 // 文本信息
 NSString *desctext = [str desc];
 
 if ( desctext.length > 0) {
 tempText = desctext;
 }
 
 // 图片视频地址
 WCUrl *url = [str dataUrl];
 
 if (url != nil) {
 NSLog(@"dataUrl = %@, url = %@", url, [url url]);
 
 
 
 
 }
 
 }
 
 
 
 MMImage *mmimage = [[%c(MMImage) alloc] initWithImage:uimage];
 [mmimage commonInit];
 NSMutableArray* array = [[NSMutableArray alloc] initWithObjects:mmimage, nil];
 
 
 //UIViewController *wcvc = [[%c(WCNewCommitViewController) alloc] init];
 WCNewCommitViewController *wcvc = [[%c(WCNewCommitViewController) alloc] initWithImages:array contacts:nil];
 
 [self.navigationController pushViewController:wcvc animated:NO];
 }
 
 
 
 
 %end
 
 
 
 
 %hook WCNewCommitViewController
 
 
 // 设置媒体信息
 - (id)getViewController { %log; id r = %orig; NSLog(@" 1= %@", r); return r; }
 
 /// 更新
 - (void)updateSelectorView { %log; %orig;NSLog(@"辉2"); }
 
 // 刷新什么类型
 - (void)reloadType { %log; %orig; NSLog(@"2辉");}
 
 // 设置类型1?
 - (void)setType:(unsigned long long )type { %log; %orig; NSLog(@"3辉");}
 
 // 不知道秀什么鬼
 - (void)setHasShowDragTip:(_Bool )hasShowDragTip { %log; %orig;NSLog(@"辉4"); }
 
 // get 秀数据
 - (id)getShowAddress { %log; id r = %orig; NSLog(@"5 = %@", r); return r; }
 
 // ?
 - (_Bool)shouldShowEvaluatePOI { %log; _Bool r = %orig; NSLog(@" 6 = %d", r); return r; }
 // ?
 - (void)setTempSelectContacts:(NSArray *)tempSelectContacts { %log; %orig;NSLog(@"辉7"); }
 - (NSArray *)tempSelectContacts { %log; NSArray * r = %orig; NSLog(@" 8= %@", r); return r; }
 
 // 上传图片?
 - (void)imagesUpdated { %log; %orig; NSLog(@"辉9");}
 // 处理图片
 - (_Bool)processImage { %log; _Bool r = %orig; NSLog(@" 10= %d", r); return r; }
 
 // 结束
 - (void)viewDidAppear:(_Bool)arg1 { %log; %orig;
 
 
 MMGrowTextView *grow = MSHookIvar<MMGrowTextView *>(self,"_textView");
 MMTextView *mmtext = MSHookIvar<MMTextView *>(grow,"_textView");
 
 WCContentItem* obj = [tempData contentObj];
 
 NSMutableArray *mediaList = [obj mediaList];
 
 for (WCMediaItem *str in mediaList) {
 // 文本信息
 NSString *desctext = [str desc];
 
 if ( desctext.length > 0) {
 [mmtext setText:desctext];
 
 }
 
 // 图片视频地址
 WCUrl *url = [str dataUrl];
 
 if (url != nil) {
 NSLog(@"dataUrl = %@",url);
 }
 }
 [grow postTextChangeNotification];
 
 
NSLog(@"辉11"); }

%new
+ (UIImage *)downloadImageWithURL:(NSString *)urlString{
    
    //创建url对象
    NSURL *url = [NSURL URLWithString:urlString];
    //创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //请求图片
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    UIImage *image = [UIImage imageWithData:data];
    
    return image;
}


/// 完成按钮
- (void)OnDone { %log; %orig;NSLog(@"辉12"); }

// 设置图片??
- (_Bool)checkImageState { %log; _Bool r = %orig; NSLog(@" 13= %d", r); return r; }

// 应该是提交 ??
- (void)OnPostTimeline { %log; %orig;NSLog(@"辉14"); }

- (void)setM_hasConfirmReturn:(_Bool )m_hasConfirmReturn { %log; %orig;NSLog(@"15辉"); }
- (_Bool )m_hasConfirmReturn { %log; _Bool  r = %orig; NSLog(@" = %d", r); return r; }

// 刷新 view 数据
- (void)showLoadingView { %log; %orig; NSLog(@"16辉");}
// 完成 View 数据刷新
- (void)onLoadingShowOK:(id)arg1 { %log; %orig; NSLog(@"17辉");}
// 离开页面
- (void)viewWillDisappear:(_Bool)arg1 { %log; %orig; NSLog(@"18辉");}



- (void)setPoiStarView:(WCPOIStarView *)poiStarView { %log; %orig; }
- (WCPOIStarView *)poiStarView { %log; WCPOIStarView * r = %orig; NSLog(@" = %@", r); return r; }

- (_Bool )hasShowDragTip { %log; _Bool  r = %orig; NSLog(@" = %d", r); return r; }
- (void)setDeleteBarView:(WCDragDeleteBarView *)deleteBarView { %log; %orig; }

- (void)setM_sightFullScreenPreviewView:(SightView *)m_sightFullScreenPreviewView { %log; %orig; }
- (SightView *)m_sightFullScreenPreviewView { %log; SightView * r = %orig; NSLog(@" = %@", r); return r; }
- (void)setM_imageLocationAry:(NSMutableArray *)m_imageLocationAry { %log; %orig; }
- (NSMutableArray *)m_imageLocationAry { %log; NSMutableArray * r = %orig; NSLog(@" = %@", r); return r; }

- (void)setSightAsset:(MMAsset *)sightAsset { %log; %orig; }
- (MMAsset *)sightAsset { %log; MMAsset * r = %orig; NSLog(@" = %@", r); return r; }
- (void)setSightDraft:(SightDraft *)sightDraft { %log; %orig; }
- (SightDraft *)sightDraft { %log; SightDraft * r = %orig; NSLog(@" = %@", r); return r; }
- (void)setBHideAddView:(_Bool )bHideAddView { %log; %orig; }
- (_Bool )bHideAddView { %log; _Bool  r = %orig; NSLog(@" = %d", r); return r; }

- (unsigned long long )type { %log; unsigned long long  r = %orig; NSLog(@" = %llu", r); return r; }
- (void)setM_bFromWCList:(_Bool )m_bFromWCList { %log; %orig; }
- (_Bool )m_bFromWCList { %log; _Bool  r = %orig; NSLog(@" = %d", r); return r; }
- (void)setM_imageLocation:(CLLocation *)m_imageLocation { %log; %orig; }
- (CLLocation *)m_imageLocation { %log; CLLocation * r = %orig; NSLog(@" = %@", r); return r; }
- (void)setM_hasICloudImage:(_Bool )m_hasICloudImage { %log; %orig; }
- (_Bool )m_hasICloudImage { %log; _Bool  r = %orig; NSLog(@" = %d", r); return r; }

- (void)setM_emoticonBoardView:(EmoticonBoardView *)m_emoticonBoardView { %log; %orig; }
- (EmoticonBoardView *)m_emoticonBoardView { %log; EmoticonBoardView * r = %orig; NSLog(@" = %@", r); return r; }
- (void)setM_isUseMMAsset:(_Bool )m_isUseMMAsset { %log; %orig; }
- (_Bool )m_isUseMMAsset { %log; _Bool  r = %orig; NSLog(@" = %d", r); return r; }
- (void)setLoadingOKStr:(NSString *)loadingOKStr { %log; %orig; }
- (NSString *)loadingOKStr { %log; NSString * r = %orig; NSLog(@" = %@", r); return r; }
- (void)setMusicInfo:(WCMusicInfo *)musicInfo { %log; %orig; }
- (WCMusicInfo *)musicInfo { %log; WCMusicInfo * r = %orig; NSLog(@" = %@", r); return r; }
- (void)setPoiInfo:(WCLocationInfo *)poiInfo { %log; %orig; }
- (WCLocationInfo *)poiInfo { %log; WCLocationInfo * r = %orig; NSLog(@" = %@", r); return r; }
- (void)setBShowLocation:(_Bool )bShowLocation { %log; %orig; }
- (_Bool )bShowLocation { %log; _Bool  r = %orig; NSLog(@" = %d", r); return r; }
- (void)setBNeedAnimation:(_Bool )bNeedAnimation { %log; %orig; }
- (_Bool )bNeedAnimation { %log; _Bool  r = %orig; NSLog(@" = %d", r); return r; }
//- (void)setDelegate:(__weak id <WCCommitViewAnimationDelegate> )delegate { %log; %orig; }
//- (__weak id <WCCommitViewAnimationDelegate> )delegate { %log; __weak id <WCCommitViewAnimationDelegate>  r = %orig; NSLog(@" = 0x%x", (unsigned int)r); return r; }
//- (void).cxx_destruct { %log; %orig; }
- (void)dealloc { %log; %orig; }
- (void)onPOIPickerFinished:(id)arg1 { %log; %orig; }
- (_Bool)couldSelectContacts { %log; _Bool r = %orig; NSLog(@" = %d", r); return r; }
- (void)hideInputController { %log; %orig; }
- (_Bool)showAddView { %log; _Bool r = %orig; NSLog(@" = %d", r); return r; }

- (_Bool)shouldJustReturnMMAsset { %log; _Bool r = %orig; NSLog(@" = %d", r); return r; }

- (void)onWCPostPrivacyChanged { %log; %orig; }
- (void)facebookCheckAccessTokenValidFinished:(_Bool)arg1 { %log; %orig; }
- (void)fbDidNotLogin { %log; %orig; }
- (void)fbDidLogin { %log; %orig; }
- (void)twitterCheckAccessTokenValidFinished:(int)arg1 { %log; %orig; }
- (void)twitterAuthFinished:(int)arg1 { %log; %orig; }
- (void)twitterWillStartOpenSafari { %log; %orig; }
- (void)adjustSubviewRects { %log; %orig; }
- (void)updateImageLocation:(unsigned int *)arg1 { %log; %orig; }
- (void)processUploadTask:(id)arg1 { %log; %orig; }
- (void)postNewItemForSight { %log; %orig; }

- (void)addPoiInfoForTask:(id)arg1 { %log; %orig; }


- (void)afterProcessSingleImage { %log; %orig; }

- (void)cancelIcloudActivity { %log; %orig; }
- (void)doExit { %log; %orig; }
- (void)OnReturn { %log; %orig; }
- (void)OnFacebookBinded { %log; %orig; }
- (void)onTwitterClicked:(id)arg1 { %log; %orig; }
- (void)onFacebookClicked:(id)arg1 { %log; %orig; }
- (void)onLocationCellClicked { %log; %orig; }
- (void)onWithContactCellClicked { %log; %orig; }
- (void)onPrivacyCellClicked { %log; %orig; }
- (void)onQZoneClicked:(id)arg1 { %log; %orig; }
- (void)alertView:(id)arg1 clickedButtonAtIndex:(long long)arg2 { %log; %orig; }
- (void)bindFacebook { %log; %orig; }
- (void)bindQQ { %log; %orig; }
- (void)willAnimateRotationToInterfaceOrientation:(long long)arg1 duration:(double)arg2 { %log; %orig; }

- (void)viewWillAppear:(_Bool)arg1 { %log; %orig; }
- (void)showPrivacyAlertView { %log; %orig; }
- (void)viewDidLayoutSubviews { %log; %orig; }

- (void)viewDidLoad { %log; %orig; }
- (void)shareOptionsCheck { %log; %orig; }
- (void)initView { %log; %orig; }

- (void)reloadData { %log; %orig; }

- (void)setDeleteBarHidden:(_Bool)arg1 { %log; %orig; }
- (void)createSubviews { %log; %orig; }
- (void)saveShareOptions { %log; %orig; }
- (void)restoreLastShareOptions { %log; %orig; }

- (void)makeEvaluatePOICell:(id)arg1 CellInfo:(id)arg2 { %log; %orig; }
- (void)removeOldText { %log; %orig; }
- (void)writeOldText:(id)arg1 { %log; %orig; }
- (id)openOldText { %log; id r = %orig; NSLog(@" = %@", r); return r; }

- (id)initWithSightDraft:(id)arg1 { %log; id r = %orig; NSLog(@" = %@", r); return r; }

- (id)initWithImages:(id)arg1 contacts:(id)arg2 { %log; id r = %orig; NSLog(@" = %@", r); return r; }

- (id)init { %log; id r = %orig; NSLog(@" = %@", r); return r; }
- (void)commonInit { %log; %orig; }
- (void)onDragableSelectorViewHeightChanged { %log; %orig; }
- (_Bool)onEndCollectionViewCellMovement:(long long)arg1 { %log; _Bool r = %orig; NSLog(@" = %d", r); return r; }
- (void)onCollectionViewCellMoved:(struct CGPoint)arg1 { %log; %orig; }
- (void)reloadExpressionButtonImage:(int)arg1 { %log; %orig; }
- (void)onExpressionButtonClicked:(id)arg1 { %log; %orig; }
- (void)keyboardDidHide { %log; %orig; }
- (void)textViewTextDidChange { %log; %orig; }
- (void)keyboardWillShow { %log; %orig; }
- (void)MMGrowTextViewBeginEditing:(id)arg1 { %log; %orig; }
- (void)MMGrowTextViewHeightDidChanged:(id)arg1 { %log; %orig; }
- (void)didCommitText:(id)arg1 { %log; %orig; }
- (void)resignInput { %log; %orig; }
- (void)becomeInput { %log; %orig; }
- (void)updateContentOffset { %log; %orig; }
- (void)initInputController { %log; %orig; }
- (void)initEmoticonView { %log; %orig; }
- (void)initInputToolView { %log; %orig; }
- (void)scrollViewDidScroll:(id)arg1 { %log; %orig; }
- (void)touchesBegan_ScrollView:(id)arg1 withEvent:(id)arg2 { %log; %orig; }
- (void)GroupTagViewSelectTempContacts:(id)arg1 { %log; %orig; }
- (void)onAssetImageDonwloadProgress:(double)arg1 assetUrl:(id)arg2 { %log; %orig; }
- (void)onAssetImageDonwloadStart:(id)arg1 { %log; %orig; }
- (void)onTextView:(id)arg1 shouldChangeTextInRange:(struct _NSRange)arg2 replacementText:(id)arg3 { %log; %orig; }
- (void)animationDidStop:(id)arg1 finished:(id)arg2 context:(void *)arg3 { %log; %orig; }
- (void)scrollViewDidEndScrollingAnimation:(id)arg1 { %log; %orig; }
- (void)beginAnimationStepTwoWithCustomView:(id)arg1 { %log; %orig; }
- (void)beginAnimationStepTwo { %log; %orig; }
- (void)beginAnimationStepOne { %log; %orig; }


- (NSString *)debugDescription { %log; NSString * r = %orig; NSLog(@" = %@", r); return r; }
- (NSString *)description { %log; NSString * r = %orig; NSLog(@" = %@", r); return r; }
- (unsigned long long )hash { %log; unsigned long long  r = %orig; NSLog(@" = %llu", r); return r; }
//- (Class )superclass { %log; Class  r = %orig; NSLog(@" = 0x%x", (unsigned int)r); return r; }
%end


 */
