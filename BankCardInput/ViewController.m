//
//  ViewController.m
//  BankCardInput
//
//  Created by YC on 2020/7/30.
//  Copyright © 2020 yc. All rights reserved.
//

#import "ViewController.h"
#import "NSString+YCString.h"

@interface ViewController ()

@property (nonatomic, strong) UITextField *myTextField;

@end

@implementation ViewController {
    NSString *_tempInputText; // 输入框里的text
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.myTextField];
    [self.myTextField becomeFirstResponder];
}

- (void)inputing:(UITextField *)tf {
    // 支持每个四位自动添加空格，支持字符串中间位置增加和删除
    
    // ********** 矫正输入之前 （每4位加1空格）**********
    UITextRange *textRange = tf.selectedTextRange; // 光标范围

    // 记录是输入还是删除
    NSInteger tag = 0;
    if (_tempInputText.length == tf.text.length + 1) {
        // 删除
        tag = 1;
    } else if (_tempInputText.length == tf.text.length - 1) {
        // 输入
        tag = 2;
    }
    
    // 记录当前光标位置
    const NSInteger location = [tf offsetFromPosition:tf.beginningOfDocument toPosition:textRange.start];
    
    // ********** 矫正输入 （每4位加1空格）**********
    tf.text = [tf.text cardNumberAddSpace];


    // ********** 矫正输入之后 （每4位加1空格）**********
    if (tag == 1) {
        // 删除
        if (location%5 == 0) {
            // 删除会减少一个空格时，光标向前多移动一位
            UITextPosition *startPosition = [tf positionFromPosition:textRange.start offset:-1];
            tf.selectedTextRange = [tf textRangeFromPosition:startPosition toPosition:startPosition];
        } else {
            // 使光标正常移动 （给text赋值后，光标默认会移动到最后）
            tf.selectedTextRange = textRange;
        }
    } else if (tag == 2) {
        // 输入
        if (location%5 == 0) {
            // 多加了一个空格时，光标向后多移动一位
            UITextPosition *startPosition = [tf positionFromPosition:textRange.start offset:1];
            tf.selectedTextRange = [tf textRangeFromPosition:startPosition toPosition:startPosition];
        } else {
            // 使光标正常移动 （给text赋值后，光标默认会移动到最后）
            tf.selectedTextRange = textRange;
        }
    }
    
    _tempInputText = tf.text;
}


#pragma mark - Getters/Setters

- (UITextField *)myTextField {
    if (!_myTextField) {
        _myTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-20*2, 50)];
        _myTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _myTextField.layer.borderWidth = 1;
        _myTextField.placeholder = @"请输入银行卡号";
        _myTextField.font = [UIFont boldSystemFontOfSize:20];
        _myTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_myTextField addTarget:self action:@selector(inputing:) forControlEvents:UIControlEventEditingChanged];
    }
    return _myTextField;
}

@end
