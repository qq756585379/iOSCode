//
//  RotateEarthMoonVC.m
//  OpenGL
//
//  Created by 杨俊 on 2017/7/7.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "RotateEarthMoonVC.h"
#import "AGLKVertexAttribArrayBuffer.h"
#import "sphere.h"

@interface RotateEarthMoonVC ()
@property (nonatomic, strong) EAGLContext *mContext;
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexPositionBuffer;
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexNormalBuffer;
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexTextureCoordBuffer;
@property (strong, nonatomic) GLKBaseEffect *baseEffect;
@property (strong, nonatomic) GLKTextureInfo *earthTextureInfo;
@property (strong, nonatomic) GLKTextureInfo *moonTextureInfo;
@property (nonatomic) GLKMatrixStackRef modelviewMatrixStack;
@property (nonatomic) GLfloat earthRotationAngleDegrees;
@property (nonatomic) GLfloat moonRotationAngleDegrees;
@end

@implementation RotateEarthMoonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
