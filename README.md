# USTC_DIA Homework1: Levelset-method

Matlab implemetion for "Level set evolution without re-initialization: a new variational formulation." CVPR, 2005.

注：本代码依据zhyx12的代码修改。

## 新增文件

作业要求：依据作业压缩包提供的参考代码，实现新的演化方程，完成图像分割。

修改增加文件如下：

my_demo.m  #主函数

my_evolution_cv.m  # 演化方程的实现

my_edge_indicator.m  # 即演化方程的g，可参考论文3.2.第一段的描述

my_Delta.m  # 新的Delta函数

## 运行说明

my_demo.m为主函数，其中line 18可以修改输入图片，line 37-40可修改参数。

关键参数有3个，`lambda`、`mu`、`nu`。依据论文Fig. 3的描述和Fig. 4的描述，对不同输入图片使用不同参数。

## 实验结果

除”vessel.bmp”外，其余输入图像的分割效果均较好。

## 可能有用的链接

关于水平集分割：https://www.zhihu.com/question/22608763/answer/46883386

关于符号距离函数（Signed Distance Function）：https://blog.csdn.net/lusongno1/article/details/122024440
