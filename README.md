# FloatingWindow
<br>悬浮窗圆形转场动画框架,首先是实现了悬浮窗，然后再添加了圆形缩小的入场动画和圆形扩大的出场动画，可以给所有的controller添加这个效果</br>
<br>效果图</br>
<br> ![image](https://github.com/hzQuan/FloatingWindow/blob/master/悬浮窗4.gif ) </br>
<br>集成文档<br/> 
<br>1.再appdelegate中添加</br>
<br>- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { </br>
  <br>  self.floatWindow = [[FloatingWindow alloc] initWithFrame:CGRectMake(100, 100, 76, 76) imageName:@"av_call"]; <br>
<br>    [self.floatWindow makeKeyAndVisible];</br>
<br>    self.floatWindow.hidden = YES;</br>
 <br>   return YES;
｝</br>
<br>2.在你需要开启悬浮窗的viewcontroller中添加方法：</br>
 <br>实现点击小圆点的委托       deleage.floatWindow.floatDelegate = weakSelf;</br>
 开启悬浮窗       [deleage.floatWindow startWithTime:30 presentview:self.view inRect:CGRectMake(100, 100, 100, 100)];</br>
<br> 注意事项</br>
<br> 如果无法选择模拟器，请调整你的development</br>
<br> 项目持续更新优化中 如果遇到无法解决的问题请联系我  qq 1634104309 </br>
 
 
  