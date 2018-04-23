//
//  EditNoteController.m
//  healthyHelper
//
//  Created by snow on 2018/1/31.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "NoteDetailController.h"
#import "AddNoteView.h"
#import "Note.h"
@interface NoteDetailController ()<UIWebViewDelegate,
                                  UIImagePickerControllerDelegate>
{
    NSString *_htmlString;//保存输出的富文本
    NSMutableArray *_imageArr;//保存添加的文本
}
@property (nonatomic,strong)UITextField *titleTf;
@property (nonatomic,strong)UIWebView *contentWebView;
@property (nonatomic,strong)AddNoteView *addView;
@end

@implementation NoteDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.note.NoteName;
    [self initRightTabbarItem];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    /**
     标题框
     */
    LXPLaceHolder *titleTf = [[LXPLaceHolder  alloc]initWithFrame:CGRectMake(0, 64, screenW, 50)];
    titleTf.placeholder = @"请输入标题";
//    titleTf.keyboardType = UIKeyboardTypeTwitter;
    titleTf.font = [UIFont systemFontOfSize:20.0];
    [self.view addSubview:titleTf];
    _titleTf = titleTf;
//    [self setTextFieldInputAccessoryView];
    
    /**
     内容框
     */
    UIWebView *contentWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleTf.frame), screenW, screenH-_titleTf.frame.size.height-64)];
    contentWebView.delegate = self;
    [self.view addSubview:contentWebView];
    _contentWebView = contentWebView;
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *indexFileURL = [bundle URLForResource:@"richTextEditor" withExtension:@"html"];
    /* 一个 Bool 值表示 web 内容是否能够以编程方式显示键盘 */
    [self.contentWebView setKeyboardDisplayRequiresUserAction:YES];
//    self.contentWebView.
    [self.contentWebView loadRequest:[NSURLRequest requestWithURL:indexFileURL]];
    
    
    UIButton *addImgBt = [UIButton buttonWithType:UIButtonTypeCustom];
    addImgBt.frame = CGRectMake(screenW-60, screenH-60, 40, 40);
    [addImgBt addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
    [addImgBt setImage:[UIImage imageNamed:@"相机"] forState:UIControlStateNormal];
    [self.view addSubview:addImgBt];
    
    
}

- (void)setTextFieldInputAccessoryView{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, screenW, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * spaceBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    doneBtn.frame = CGRectMake(2, 5, 40, 25);
    [doneBtn addTarget:self action:@selector(dealKeyboardHide) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneBtnItem = [[UIBarButtonItem alloc]initWithCustomView:doneBtn];
    NSArray * buttonsArray = [NSArray arrayWithObjects:spaceBtn,doneBtnItem,nil];
    [topView setItems:buttonsArray];
    [self.titleTf setInputAccessoryView:topView];
    [self.titleTf setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.titleTf setAutocapitalizationType:UITextAutocapitalizationTypeNone];
}

- (void)dealKeyboardHide {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(void)addImage{
//    _addView = [[AddNoteView alloc]initWithFrame:CGRectMake(0, screenH, screenW, (screenH)/2.0)];
//    [self.view addSubview:_addView];
//    __weak typeof(self)weakSelf  = self;
//
//    _addView.blk = ^(UIButton *bt) {
//        __strong typeof(weakSelf)strongSelf = weakSelf;
////        if (bt.tag == 0) {
////
////
////        }else if (bt.tag == 1){
////            [strongSelf.addView removeAddView:strongSelf.addView];
            [self getImage];
//        }else{
//
//        }
//    };
//    [UIView animateWithDuration:0.5 animations:^{
//        _addView.frame = CGRectMake(0, (screenH)/2.0, screenW,_addView.frame.size.height );
//    }];
    
}
-(void)initRightTabbarItem{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"保存" forState: UIControlStateNormal];
    [addButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(saveText) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addButton];
}
-(void)getImage{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
-(void)saveNote{
    
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSDate *now = [NSDate date];
    /** -----------------------添加完图片与 html 对接-----------------------*/
    /*以时间戳来命名图片*/
    NSString *imageName = [NSString stringWithFormat:@"iOS%@.jpg",[self stringFromDate:now]];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    /*判断返回的是照片还是视频*/
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *image;
    if ([mediaType isEqualToString:@"public.image"]) {
        //获取照片的原图
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //对图片进行压缩，压缩比例是1  是 “压” 文件体积变小，但是像素数不变，长宽尺寸不变，那么质量可能下降
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        [imageData writeToFile:imagePath atomically:YES];
    }
    NSInteger userid =  12345;
    //对应自己服务器的处理方法,
    //此处是将图片上传ftp中特定位置并使用时间戳命名 该图片地址替换到html文件中去
    NSString *url = [NSString stringWithFormat:@"http://test.xxx.com/apps/kanghubang/%@/%@/%@",[NSString stringWithFormat:@"%ld",userid%1000],[NSString stringWithFormat:@"%ld",(long)userid ],imageName];
    /*给 html 中插入图片*/
    NSString *script = [NSString stringWithFormat:@"window.insertImage('%@', '%@')", url, imagePath];
    NSDictionary *dic = @{@"url":url,@"image":image,@"name":imageName};
    [_imageArr addObject:dic];
    [self.contentWebView stringByEvaluatingJavaScriptFromString:script];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    if (self.inHtmlString.length>0) {
        /**
         1. 编辑服务器中的富文本
         2. 如果文本框中有内容，就调取 js 的方法来获取文本框中的html
         */
        NSString *place = [NSString stringWithFormat:@"window.placeHTMLToEditor('%@')",self.inHtmlString];
        [webView stringByEvaluatingJavaScriptFromString:place];
    }
}
-(void)saveText{
    [self printHTML];
}
- (void)printHTML
{
//    NSString *title = [self.contentWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('title-input').value"];
    /*编辑完成后拿出 html 代码 */
    NSString *html = [self.contentWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('content').innerHTML"];
    NSString *script = [self.contentWebView stringByEvaluatingJavaScriptFromString:@"window.alertHtml()"];
    [self.contentWebView stringByEvaluatingJavaScriptFromString:script];
//    NSLog(@"Title: %@", title);
    NSLog(@"Inner HTML: %@", html);
    
    if (html.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入内容" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好", nil];
        [alert show];
    }
    else
    {
        _htmlString = html;
        //对输出的富文本进行处理后上传
        NSLog(@"%@",[self changeString:_htmlString]);
    }
    
}
#pragma mark - Method
/*对 id 进行特殊处理*/
-(NSString *)changeString:(NSString *)str
{
    
    NSMutableArray * marr = [NSMutableArray arrayWithArray:[str componentsSeparatedByString:@"\""]];
    
    for (int i = 0; i < marr.count; i++)
    {
        NSString * subStr = marr[i];
        if ([subStr hasPrefix:@"/var"] || [subStr hasPrefix:@" id="])
        {
            [marr removeObject:subStr];
            i --;
        }
    }
    NSString * newStr = [marr componentsJoinedByString:@"\""];
    NSLog(@"%@",newStr);
    return newStr;
    
}

- (NSString *)stringFromDate:(NSDate *)date
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

@end
