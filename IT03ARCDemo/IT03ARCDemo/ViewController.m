//
//  ViewController.m
//  IT03ARCDemo
//
//  Created by Mac on 16/3/11.
//  Copyright © 2016年 黄德林. All rights reserved.
//
//ARC
//automatic reference counting  自动引用计数
//它是ios5之后提出的    它不是一种垃圾回收机制
//它的内存管理机制和MRC的内存管理机制是一致的，
//只是不需要显示（手动）的调用 release，retain，autorelease
//为啥呢？因为arc是编译特性，编译的时候会在适当的位置加上release和autorelease
//进而为it工作者省去的代码量和强度
//ARC这种内存管理机制只适用于 oc对象 ，swift 只支持arc

//注意以下问题
//什么是strong 什么是weak？
//在MRC 和 ARC 中__block 是什么意思
//在ARC中oc 和c/c++是如何处理内存？


//MRC 和 ARC 工程如何混编 -fobjc-arc -fno-obj-arc

#import "ViewController.h"
#import "People.h"
@interface ViewController (){
     NSArray *_array;
    People *_p;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSArray *a = [[NSArray alloc]initWithObjects:@"1", nil];
//    _array = a;
//    [a release];
    //_array = [NSArray arrayWithObject:@"2"];
    
    People *peopel = [People new];
    _p = peopel;
    
    
    void(^blockName)(void) = ^(){
        NSLog(@"%@",peopel);
        peopel.age = 10;
        self.view.backgroundColor = [UIColor orangeColor];
    };
    blockName();
//    __bridge 转换类型，仅仅是转换，而不做任何的内存管理权的转换
//    __bridge_retained 将oc的内存管理让给c来处理
    NSString *str = [[NSString alloc]initWithFormat:@"hell %@",@"world"];

    CFStringRef ret = (__bridge_retained CFStringRef)(str);
    CFRelease(ret);
    NSLog(@"%@",ret);
    //__bridge_transfer 将c的内存管理权交给oc 来处理
    NSString *str1 = (__bridge_transfer NSString *)ret;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
- (void)btnClick {
    NSLog(@"-------------%@",_array);
    _p = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
