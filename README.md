# FloatingWindow
<br>悬浮窗圆形转场动画框架,首先是实现了悬浮窗，然后再添加了圆形缩小的入场动画和圆形扩大的出场动画，可以给所有的controller添加这个效果</br>
<h2>Look</h2>
<br> ![image](https://github.com/hzQuan/FloatingWindow/blob/master/悬浮窗4.gif ) </br>

<h2>How to use it</h2> 
<br>1.在appdelegate中添加</br>
<br>- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { </br>
  <br>  self.floatWindow = [[FloatingWindow alloc] initWithFrame:CGRectMake(100, 100, 76, 76) imageName:@"av_call"]; <br>
<br>    [self.floatWindow makeKeyAndVisible];</br>
<br>    self.floatWindow.hidden = YES;</br>
 <br>   return YES;
｝</br>
<br>2.你需要开启悬浮窗的viewcontroller中添加方法：</br>
 <br>实现点击小圆点的委托       deleage.floatWindow.floatDelegate = weakSelf;</br>
 开启悬浮窗       [deleage.floatWindow startWithTime:30 presentview:self.view inRect:CGRectMake(100, 100, 100, 100)];</br>
<h2> MORE</h2>
<br> If you can't choice simulator，please change your development </br>
<br> Welcome fork and pull </br>
<br> thanks everyone's star'</br>
<br> If you find bug , please comtact me .  email 1634104309@qq.com qq:1634104309 </br>

<br>android 技术交流群：2308505 </br>
<br> iOS    技术交流群：249735019 </br>
 
 
  