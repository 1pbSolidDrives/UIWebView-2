//
//  ViewController.m
//  UIWebView
//
//  Created by LiHongyao on 15/7/29.
//  Copyright (c) 2015年 LiHongyao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField; /**< 文本输入框 */

@property (nonatomic, strong) UIWebView *webView; /**< 网页视图 */

@property(nonatomic,strong)UIWebView* completeView;
- (void)initializeUserInterface; /**< 初始化用户界面 */


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initializeUserInterface];
}

#pragma mark - init
- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 加载网页视图
    [self.view addSubview:self.webView];
    
    // 在导航栏添加文本输入框
    self.navigationItem.titleView = self.textField;
    
    /* NavigationItem */
    // 初始化item
    UIBarButtonItem *browseItem = [[UIBarButtonItem alloc] initWithTitle:@"浏览"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(repondsToBarButtonItem:)];
    // 设置前景色
    browseItem.tintColor = [UIColor darkGrayColor];
    // 添加item
    self.navigationItem.rightBarButtonItem = browseItem;
    
    /* 工具栏 */
    // 显示工具栏
    self.navigationController.toolbarHidden = NO;
    
    // 初始化分段控件
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"后退", @"刷新", @"停止", @"前进"]];
    
    segmentedControl.frame = CGRectMake(0, 0, 170, 30);
    segmentedControl.tintColor = [UIColor clearColor];
    
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [segmentedControl addTarget:self action:@selector(respondsToSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    
    // 自定义item
    UIBarButtonItem *segmentedItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    
    // 延展item
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:nil
                                                                                  action:nil];
    
    // 添加item到工具栏上
    self.toolbarItems = @[flexibleItem, segmentedItem, flexibleItem];
    
}

#pragma mark - responds event
- (void)respondsToSegmentedControl:(UISegmentedControl *)segmentedControl {
    switch (segmentedControl.selectedSegmentIndex) {
            // 返回
        case 0:[_webView goBack];break;
            // 加载
        case 1:
        {
            
            
            
            NSString *lJs = @"document.documentElement.innerHTML";
//            NSString *lJs2 = @"document.title";
//            NSString *urlcode = @"document.URL";
//            NSString *url = [_completeView stringByEvaluatingJavaScriptFromString:urlcode];
//            NSString *pattern = @"\"big-price\">([0-9]+)<\/span>";

            //创建js代码
//            
//            
//            NSString* jsCode3_5=@"var regxStr = '\"big-price\">([0-9]+)<';";
//            NSString* jsCode4=@"var reg = new RegExp(regxStr, 'g');";
//            NSString* jsCode6=@"var result = new Array();result = reg.exec(allHtml);";
//            
//            

            
            NSString* jsCode1=@"var script = document.createElement('script');";
            NSString* jsCode2=@"script.type = 'text/javascript';";
            NSString* jsCode3=@"script.text = \"function myFunction(){";
            NSString* jsCode4=@"var price = $('.big-price').text();";
            NSString* jsCode7=@"return (price);";
            NSString* jsCode8=@"}\";";
            NSString* jsCode9=@"document.getElementsByTagName('body')[0].appendChild(script);";
//            
//            NSString* jsCode = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",jsCode1,jsCode2,jsCode3,jsCode3_5,jsCode4,jsCode5,jsCode6,jsCode6_5,jsCode7,jsCode8,jsCode9];
            
            NSString* jsCodeBase = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",jsCode1,jsCode2,jsCode3,jsCode4,jsCode7,jsCode8,jsCode9];

            
            //注入js代码
            
            
            NSString* regx = @"'/\\\"big-price\">([0-9]+)<\\/span>/'";
            
            
            
            [_completeView stringByEvaluatingJavaScriptFromString:jsCodeBase];
            //调用注入的代码
            NSString* runJsCode = [NSString stringWithFormat:@"myFunction()"];
            NSString* priceResult = [_completeView stringByEvaluatingJavaScriptFromString:runJsCode];
            
            NSString *lHtml1 = [_completeView stringByEvaluatingJavaScriptFromString:lJs];

            NSLog(@"reslut = %@",priceResult);
            
//            NSString* addParameter = [NSString stringWithFormat:@"getMyWord('%@');",pattern ];
//            NSString* price = [_completeView stringByEvaluatingJavaScriptFromString:addParameter];
//            //正则表达式对象
//            NSError *error;
//
//            NSString* test = @"<span class=\"big-price\">7488</span>";
//            NSString* regex = @"(w+)";
//            NSArray  *splitArray   = NULL;
//  
//            // splitArray == { @"This", @"is", @"neat." }
//            NSLog(@"splitArray: %@", splitArray);
//            NSRegularExpression *regexl = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
//            
//            NSArray * matches = [regexl matchesInString:test options:0 range:NSMakeRange(0, [test length])];
//           
//            NSMutableArray *array = [NSMutableArray array];
//            NSString *checkString = @"<span class=\"big-price\">7488</span>";
//            //1.创建正则表达式，[0-9]:表示‘0’到‘9’的字符的集合
//            //1.1将正则表达式设置为OC规则
//            NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
//            //2.利用规则测试字符串获取匹配结果
//            NSArray *results = [regular matchesInString:lHtml1 options:0 range:NSMakeRange(0, lHtml1.length)];
//            NSLog(@"%ld %@",results.count,results);
//            for (NSTextCheckingResult *result in results) {
//                NSLog(@"%@ %@",NSStringFromRange(result.range),[test substringWithRange:result.range]);
//            }
//            //需要被筛选的字符串
//            NSString *str = @"#今日要闻#[偷笑] http://asd.fdfs.2ee/aas/1e @sdf[test] #你确定#@rain李23: @张三[挖鼻屎]m123m";
//            //表情正则表达式
//            //  \\u4e00-\\u9fa5 代表unicode字符
//            NSString *emopattern = @"\\[[a-zA-Z\\u4e00-\\u9fa5]+\\]";
//            //@正则表达式
//            NSString *atpattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5]+";
//            //#...#正则表达式
//            NSString *toppattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
//            //url正则表达式
//            NSString *urlpattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
//            //设定总的正则表达式
//            NSString *pattern2 = [NSString stringWithFormat:@"%@|%@|%@|%@",emopattern,atpattern,toppattern,urlpattern];
//            //根据正则表达式设定OC规则
//            NSRegularExpression *regular2 = [[NSRegularExpression alloc] initWithPattern:pattern2 options:NSRegularExpressionCaseInsensitive error:nil];
//            //获取匹配结果
//            NSArray *results2 = [regular2 matchesInString:str options:0 range:NSMakeRange(0, str.length)];
//            //NSLog(@"%@",results);
//            //遍历结果
//            for (NSTextCheckingResult *result in results2) {
//                NSLog(@"%@ %@",NSStringFromRange(result.range),[str substringWithRange:result.range]);
//            }
//            


        }
            break;
            // 停止加载
        case 2:[_webView stopLoading];break;
            // 前进
        case 3:[_webView goForward];break;
        default:
            break;
    }
}

- (void)repondsToBarButtonItem:(UIBarButtonItem *)sender {
    [self reloadDataWithWebAddress:self.textField.text];
    [self.view endEditing:YES];
}
#pragma mark - private methods
- (void)reloadDataWithWebAddress:(NSString *)string {
    // 异常处理
    if (string.length == 0) {
        // 收起键盘
        [self.view endEditing:YES];
        return;
    }
    NSString *requestString = nil;
    // 网址判断
    // 1、如果用户只输入网址名称如只输入"tabobao"，则自动补全域名；
    if (![string hasSuffix:@"www"]) {
        requestString = [NSString stringWithFormat:@"https://www.%@.com", string];
    }
    // 2、如果用户只输入"www.taobao.com"，则自动插入"http:"
    else if (![string hasSuffix:@"https"]) {
        requestString = [NSString stringWithFormat:@"https://www.%@.com", string];
    }
    // 将完整域名赋值给文本输入框
    _textField.text = requestString;
    
    // 创建请求，并且设置缓存
    /**
     * cachePolicy表示缓存策略
     * NSURLRequestUseProtocolCachePolicy = 0 -> 默认策略，使用缓存；
     * NSURLRequestReloadIgnoringLocalCacheData = 1 -> 忽略本地缓存；
     * NSURLRequestReturnCacheDataElseLoad = 2 -> 如果有缓存，不管过期时间优先使用本地缓存，如果没有本地缓存，才从原地址下载；
     * NSURLRequestReturnCacheDataDontLoad = 3 -> 只使用缓存，如果没有匹配的缓存则报告离线模式，而不会从网上load数据；
     */
    NSURLRequest *resuest = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:1.0];
    // 加载数据
    [self.webView loadRequest:resuest];
}

#pragma mark - <UITextFieldDelegate>
// 相应return键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    [self reloadDataWithWebAddress:textField.text];
    
    return YES;
}
#pragma mark - <UIWebViewDelegate>
// 加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@", error.localizedDescription);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:error.localizedDescription delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

// 是否允许开始加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

// 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
     _completeView = webView;
}

// 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
   


}

#pragma mark - touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - getter
- (UIWebView *)webView {
    if (!_webView) {
        // 初始化网页视图
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64 - CGRectGetHeight(self.navigationController.toolbar.bounds))];
        
        // 配置URL：http:// +...
        NSURL *url = [NSURL URLWithString:@"http://item.m.jd.com/product/3133827.html"];
        
        // 创建请求
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        // 自动对页面进行缩放以适应屏幕
        _webView.scalesPageToFit = YES;
        
        // 自动检测网页上的电话号码，单击可以拨打
        // _webView.detectsPhoneNumbers = YES;
        
        // 加载网页
        [_webView loadRequest:request];
        
        // 设置代理
        _webView.delegate = self;
        
        // 设置是否回弹
        _webView.scrollView.bounces = NO;
    }
    return _webView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeyGo;
        _textField.placeholder = @"点击输入网页浏览";
        _textField.returnKeyType = UIReturnKeyGo;
        // 再次编辑清空
        // _textField.clearsOnBeginEditing = YES;
        // 改变光标牙呢
        _textField.tintColor = [UIColor lightGrayColor];
    }
    return _textField;
}


@end
