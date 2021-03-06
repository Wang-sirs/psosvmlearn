clc
clear
close all
%%
addpath gabor
fprintf('开始计算\n');
%%
filter_bank = construct_Gabor_filters(8, 5, [48 48]); %5个尺度8个方向
class1path=dir('正常');
data_matrix1=[];
for i=1:length(class1path)-2
    imgpath=['正常\' class1path(i+2).name];%煤炭的路径
    img1=imread(imgpath);%读取图片
    img2=rgb2gray(img1);%灰度化
    img3= double(imresize(img2,[48 48],'bilinear'));  %采用'bilinear'：采用双线性插值算法扩展为48*48
    H2 = filter_image_with_Gabor_bank(img3,filter_bank,64);%%提取gabor纹理特征
    data_matrix1=[data_matrix1 H2];%将提取的特征放进data_matrix1中
    disp(sprintf('完成正常文件夹中第%i图的gabor特征提取',i));
end
tz_image1=data_matrix1';

%%
class1path=dir('溃疡');
data_matrix1=[];
for i=1:length(class1path)-2
    imgpath=['溃疡\' class1path(i+2).name];%煤炭的路径
    img1=imread(imgpath);%读取图片
    img2=rgb2gray(img1);%灰度化
    img3= double(imresize(img2,[48 48],'bilinear'));  %采用'bilinear'：采用双线性插值算法扩展为48*48
    H2 = filter_image_with_Gabor_bank(img3,filter_bank,64);%%提取gabor纹理特征
    data_matrix1=[data_matrix1 H2];%将提取的特征放进data_matrix1中
    disp(sprintf('完成溃疡文件夹中第%i图的gabor特征提取',i));
end
tz_image2=data_matrix1';

%% 
input=[tz_image1;tz_image2];
output=[ones(1,size(tz_image1,1)) 2*ones(1,size(tz_image2,1))]';

save img_tz input output
