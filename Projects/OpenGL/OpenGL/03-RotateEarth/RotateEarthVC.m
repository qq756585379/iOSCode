//
//  RotateEarthVC.m
//  OpenGL
//
//  Created by 杨俊 on 2017/7/7.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "RotateEarthVC.h"
#import <OpenGLES/ES2/gl.h>
#import "OSSphere.h"

@interface RotateEarthVC ()
{
    GLfloat   	*_vertexData; 	// 顶点数据
    GLfloat   	*_texCoords;  	// 纹理坐标
    GLushort  	*_indices;   	// 顶点索引
    GLint   	_numVetex;   	// 顶点数量
    GLuint   	_vertexBuffer; 	// 顶点内存标识
    GLuint  	_texCoordsBuffer;// 纹理坐标内存标识
    GLuint  	_numIndices;
}
@property(nonatomic, strong) GLKBaseEffect *baseEffect;
@end

@implementation RotateEarthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"旋转地球";
    GLKView *glkView = (GLKView *)self.view;
    glkView.drawableDepthFormat = GLKViewDrawableDepthFormat24;// 设置深度缓冲区格式
    // 创建管理上下文
    glkView.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    // 设置它为当前上下文
    [EAGLContext setCurrentContext:glkView.context];
    // 配置渲染器
    self.baseEffect = [[GLKBaseEffect alloc] init];
    // 将我们的地图照片加载到渲染其中
    UIImage *image = [UIImage imageNamed:@"earth-diffuse.jpg"];
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithCGImage:image.CGImage options:nil error:nil];
    self.baseEffect.texture2d0.target = textureInfo.target;
    self.baseEffect.texture2d0.name = textureInfo.name;
    // 设置世界坐标和视角
    float aspect = fabs(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
    self.baseEffect.transform.projectionMatrix = projectionMatrix;
    // 设置模型坐标
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, -1.0f, -6.5f);
    self.baseEffect.transform.modelviewMatrix = modelViewMatrix;
    // 创建顶点坐标  OSSphere里的方法
    _numIndices = generateSphere(200, 1.0, &(_vertexData), &(_texCoords), &_indices, &_numVetex);
    // 载入顶点数据到GPU
    glGenBuffers(1, &_vertexBuffer); // 根据顶点内存标识申请内存
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer); // 将命名的缓冲对象绑定到指定的类型上去
    glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*_numVetex*3,_vertexData, GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribPosition);  // 绑定到位置上
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 3*sizeof(GLfloat), NULL);
    
    // 加载顶点索引数据
    GLuint _indexBuffer;
    glGenBuffers(1, &_indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, _numIndices*sizeof(GLushort), _indices, GL_STATIC_DRAW);
    
    // 加载纹理坐标
    glGenBuffers(1, &_texCoordsBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _texCoordsBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*_numVetex*2, _texCoords, GL_DYNAMIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 2*sizeof(GLfloat), NULL);
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(1.0, 0, 1.0, 1);// 清除颜色缓冲区
    glClear(GL_COLOR_BUFFER_BIT);
    // 绘制之前必须调用这个方法
    [self.baseEffect prepareToDraw];
    static int i =1;
    if (i < _numIndices-2000){
        i = i+1000;
    }else{
        i = _numIndices;
    }
    // 以画单独三角形的方式 开始绘制
    glDrawElements(GL_TRIANGLES, i,GL_UNSIGNED_SHORT, NULL);
}

-(void)update{
    self.baseEffect.transform.modelviewMatrix = GLKMatrix4Rotate(self.baseEffect.transform.modelviewMatrix, 0.1, 0, 1, 0);
}

@end
