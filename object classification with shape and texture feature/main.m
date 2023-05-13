clc;
close all;
%%% for feature shape
solidity_weed=[];
Eccentricity_weed=[];
Circularity_weed=[];
solidity_onion=[];
Eccentricity_onion=[];
Circularity_onion=[];
%%% for feature texture
num_levels = 8;
offsets = [0 1; -1 1; -1 0; -1 -1];
propf={'Energy', 'Contrast', 'Correlation'};
Energy_weed=zeros(20,4,4);
contrast_weed=zeros(20,4,4);
Correlation_weed=zeros(20,4,4);
Energy_onion=zeros(20,4,4);
contrast_onion=zeros(20,4,4);
Correlation_onion=zeros(20,4,4);
%%%%%%%% reading files
for o=1:20
    if o<10
        file_name=['0',num2str(o)];
    else
        file_name=[num2str(o)];
    end
img_truth=imread(['D:\semester B\computer vision\assessement\task 2\onions\',file_name,'_truth.png']);
img_depth=imread(['D:\semester B\computer vision\assessement\task 2\onions\',file_name,'_depth.png']);
img_rgb=imread(['D:\semester B\computer vision\assessement\task 2\onions\',file_name,'_rgb.png']);
bw_weed=img_truth(:,:,3);
cc_weed=bwconncomp(bw_weed);
%%%%%%%%% shape feature for weed
prop_weed=regionprops(cc_weed,'Solidity', 'Eccentricity', 'Circularity', 'Area', 'Perimeter','Centroid');
area_weed = [prop_weed.Area]';
perimeter_weed = [prop_weed.Perimeter]';
solidity_weed=[prop_weed.Solidity];
Eccentricity_weed=[prop_weed.Eccentricity];
Circularity_weed=[prop_weed.Circularity];
% circularity and noncompactness based on the momentum 
CircularityM_weed=[];
non_compactness_weed=[];
for b=1:cc_weed.NumObjects
x_mean = prop_weed(b).Centroid(1);
y_mean = prop_weed(b).Centroid(2);
[y, x] = ind2sub(size(img_rgb), cc_weed.PixelIdxList{b});
var_x=sum((x-x_mean).^2);
var_y=sum((y-y_mean).^2);
I=(var_x+var_y);
circularityM=(prop_weed(b).Area)^2/(2*pi*I);
CircularityM_weed=[CircularityM_weed,circularityM];
non_compactness=2*pi*(I/(prop_weed(b).Area)^2+6/prop_weed(b).Area);
non_compactness_weed=[non_compactness_weed,non_compactness];
end
Circularity_weed = Circularity_weed(Circularity_weed~=Inf);
CircularityM_weed=CircularityM_weed(CircularityM_weed~=Inf);
avg_solidity_weed(o) = mean(solidity_weed);
avg_Eccentricity_weed(o)=mean(Eccentricity_weed);
avg_Circularity_weed(o)=mean(Circularity_weed);
avg_CircularityM_weed(o)=mean(CircularityM_weed);
avg_non_compactness_weed(o)=mean(non_compactness_weed);

%%%%%%%%% shape feature for onion
bw_onion=img_truth(:,:,1);
cc_onion=bwconncomp(bw_onion);
prop_onion=regionprops(cc_onion,'Solidity', 'Eccentricity', 'Circularity', 'Area', 'Perimeter','Centroid');
area_onion = [prop_onion.Area]';
perimeter_onion = [prop_onion.Perimeter]';
solidity_onion=[prop_onion.Solidity];
Eccentricity_onion=[prop_onion.Eccentricity];
Circularity_onion=[prop_onion.Circularity];
% circularity and noncompactness based on the momentum
CircularityM_onion=[];
non_compactness_onion=[];
for b=1:cc_onion.NumObjects
x_mean = prop_onion(b).Centroid(1);
y_mean = prop_onion(b).Centroid(2);
[y, x] = ind2sub(size(img_rgb), cc_onion.PixelIdxList{b});
var_x=sum((x-x_mean).^2);
var_y=sum((y-y_mean).^2);
I=(var_x+var_y);
circularityM=(prop_onion(b).Area)^2/(2*pi*I);
CircularityM_onion=[CircularityM_onion,circularityM];
non_compactness=2*pi*(I/(prop_onion(b).Area)^2+6/prop_onion(b).Area);
non_compactness_onion=[non_compactness_onion,non_compactness];
end
Circularity_onion = Circularity_onion(Circularity_onion~=Inf);
CircularityM_onion=CircularityM_onion(CircularityM_onion~=Inf);
avg_solidity_onion(o) = mean(solidity_onion);
avg_Eccentricity_onion(o)=mean(Eccentricity_onion);
avg_Circularity_onion(o)=mean(Circularity_onion);
avg_CircularityM_onion(o)=mean(CircularityM_onion);
avg_non_compactness_onion(o)=mean(non_compactness_onion);

%%%%%%% texture feature
% seprating channels and change the format to grey level weed
grey_channel= cell(1, 4);
img_rgb_weed=imoverlay(img_rgb,imcomplement(bw_weed),'k');
for channel=1:3
    grey_channel{channel}= im2gray(img_rgb_weed(:,:,channel));
   
end
grey_channel{4}=im2gray(imoverlay(im2uint8(img_depth),imcomplement(bw_weed),'k'));

%%%%%glcm for weed
for z=1:4 % [R G B D]
    grey_channel_z=grey_channel{z};
for j = 1:size(offsets, 1)  %[0,45,90,135]
    glcm = graycomatrix(grey_channel_z, 'offset', offsets(j,:));
    glcm(1,1)=0;
    %[calculating Angular Second Moment, Contrast, Correlation]
    prop_feature_weed= graycoprops(uint8(glcm));
    Energy_weed(o,j,z)=prop_feature_weed.Energy;
    contrast_weed(o,j,z)=prop_feature_weed.Contrast;     
    Correlation_weed(o,j,z)=prop_feature_weed.Correlation;
    
end
end 
contrast_weed_x=sum(contrast_weed,2)/4;
Energy_weed_x=sum(Energy_weed,2)/4;
Correlation_weed_x=sum(Correlation_weed,2)/4;
Energy_weed_y=max(Energy_weed,[],2)-min(Energy_weed,[],2);
Correlation_weed_y=max(Correlation_weed,[],2)-min(Correlation_weed,[],2);
contrast_weed_y=max(contrast_weed,[],2)-min(contrast_weed,[],2);

% seprating channels and change the format to grey level onion
img_rgb_onion=imoverlay(img_rgb,imcomplement(bw_onion),'k');

for channel=1:3
    grey_channel{channel}= im2gray(img_rgb_onion(:,:,channel));
end
grey_channel{4}=im2gray(imoverlay(im2uint8(img_depth),imcomplement(bw_onion),'k'));

%%%%%glcm for onion
for z=1:4 % [R G B D]
    grey_channel_z=grey_channel{z};
for j = 1:size(offsets, 1)  %[0,45,90,135]
    glcm = graycomatrix(grey_channel_z, 'offset', offsets(j,:),'NumLevels',num_levels);     
    glcm(1,1)=0;
    %[calculating Angular Second Moment, Contrast, Correlation]
    prop_feature_onion= graycoprops(uint8(glcm));
    Energy_onion(o,j,z)=prop_feature_onion.Energy;
    contrast_onion(o,j,z)=prop_feature_onion.Contrast;     
    Correlation_onion(o,j,z)=prop_feature_onion.Correlation;
end
end 
end
contrast_onion_x=sum(contrast_onion,2)/4;
Energy_onion_x=sum(Energy_onion,2)/4;
Correlation_onion_x=sum(Correlation_onion,2)/4;
Energy_onion_y=max(Energy_onion,[],2)-min(Energy_onion,[],2);
Correlation_onion_y=max(Correlation_onion,[],2)-min(Correlation_onion,[],2);
contrast_onion_y=max(contrast_onion,[],2)-min(contrast_onion,[],2);

%%%%%%%%  plot histogram of feature shape

histogram(solidity_weed, 'BinWidth', 0.05);
hold on
histogram(solidity_onion, 'BinWidth', 0.05);
title('Solidity')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\solidity.png');
figure,histogram(Eccentricity_weed, 'BinWidth', 0.05);
hold on
histogram(Eccentricity_onion, 'BinWidth', 0.05);
title('Eccentricity')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\Eccentricity.png');
figure,histogram(Circularity_weed, 'BinWidth', 0.05);
hold on
histogram(Circularity_onion, 'BinWidth', 0.05);
title('Circularity')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\Circularity.png');
figure,histogram(CircularityM_weed, 'BinWidth', 0.05);
hold on
histogram(CircularityM_onion, 'BinWidth', 0.05);
title('Circularity based on inertia')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\Circularity based on inertia.png');
figure,histogram(non_compactness_weed, 'BinWidth', 0.05);
hold on
histogram(non_compactness_onion, 'BinWidth', 0.2);
title('non compactness based on inertia')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\non compactness based on inertia.png');
%%%%%%%%  plot histogram of feature texture based on the average of four
%%%%%%%%  direction
histogram(Energy_weed_x(:,:,1));
hold on
histogram(Energy_onion_x(:,:,1));
title('Energy red channel')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\Energy red channel.png');
figure,histogram(Energy_weed_x(:,:,2));
hold on
histogram(Energy_onion_x(:,:,2));
title('Energy green channel')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\Energy green channel.png');
figure,histogram(Energy_weed_x(:,:,3));
hold on
histogram(Energy_onion_x(:,:,3));
title('Energy blue channel')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\Energy blue channel.png');
figure,histogram(Energy_weed_x(:,:,4));
hold on
histogram(Energy_onion_x(:,:,4));
title('Energy depth channel')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\Energy depth channel.png');
figure,histogram(contrast_weed_x(:,:,1), 'BinWidth', 0.05);
hold on
histogram(contrast_onion_x(:,:,1), 'BinWidth', 0.05);
title('contrast red channel')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\contrast red channel.png');
figure,histogram(contrast_weed_x(:,:,2), 'BinWidth', 0.05);
hold on
histogram(contrast_onion_x(:,:,2), 'BinWidth', 0.05);
title('contrast green channel')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\contrast green channel.png');
figure,histogram(contrast_weed_x(:,:,3), 'BinWidth', 0.05);
hold on
histogram(contrast_onion_x(:,:,3), 'BinWidth', 0.05);
title('contrast blue channel')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\contrast blue channel.png');
figure,histogram(contrast_weed_x(:,:,4), 'BinWidth', 0.05);
hold on
histogram(contrast_onion_x(:,:,4), 'BinWidth', 0.05);
title('contrast depth channel')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\contrast depth channel.png');
figure,histogram(Correlation_weed_x(:,:,1), 'BinWidth', 0.02);
hold on
histogram(Correlation_onion_x(:,:,1), 'BinWidth', 0.02);
title('correlation red channel')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\correlation red channel.png');
figure,histogram(Correlation_weed_x(:,:,2), 'BinWidth', 0.02);
hold on
histogram(Correlation_onion_x(:,:,2), 'BinWidth', 0.02);
title('correlation green channel')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\correlation green channel.png');
figure,histogram(Correlation_weed_x(:,:,3), 'BinWidth', 0.02);
hold on
histogram(Correlation_onion_x(:,:,3), 'BinWidth', 0.02);
title('correlation blue channel')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\correlation blue channel.png');
figure,histogram(Correlation_weed_x(:,:,4), 'BinWidth', 0.02);
hold on
histogram(Correlation_onion_x(:,:,4), 'BinWidth', 0.02);
title('correlation depth channel')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\correlation depth channel.png');
%%%%%%%%  plot histogram of feature texture based on the range of four
%%%%%%%%  direction
histogram(Energy_weed_y(:,:,1));
hold on
histogram(Energy_onion_y(:,:,1));
title('Energy red channel range')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\Energy red channel range.png');
figure,histogram(Energy_weed_y(:,:,2));
hold on
histogram(Energy_onion_y(:,:,2));
title('Energy green channel range')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\Energy green channel range.png');
figure,histogram(Energy_weed_y(:,:,3));
hold on
histogram(Energy_onion_y(:,:,3));
title('Energy blue channel range')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\Energy blue channel range.png');
figure,histogram(Energy_weed_y(:,:,4));
hold on
histogram(Energy_onion_y(:,:,4));
title('Energy depth channel range')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\Energy depth channel range.png');
figure,histogram(contrast_weed_y(:,:,1), 'BinWidth', 0.05);
hold on
histogram(contrast_onion_y(:,:,1), 'BinWidth', 0.05);
title('contrast red channel range')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\contrast red channel range.png');
figure,histogram(contrast_weed_y(:,:,2), 'BinWidth', 0.05);
hold on
histogram(contrast_onion_y(:,:,2), 'BinWidth', 0.05);
title('contrast green channel range')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\contrast green channel range.png');
figure,histogram(contrast_weed_y(:,:,3), 'BinWidth', 0.05);
hold on
histogram(contrast_onion_y(:,:,3), 'BinWidth', 0.05);
title('contrast blue channel range')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\contrast blue channel range.png');
figure,histogram(contrast_weed_y(:,:,4), 'BinWidth', 0.05);
hold on
histogram(contrast_onion_y(:,:,4), 'BinWidth', 0.05);
title('contrast depth channel range')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\contrast depth channel range.png');
figure,histogram(Correlation_weed_y(:,:,1), 'BinWidth', 0.02);
hold on
histogram(Correlation_onion_y(:,:,1), 'BinWidth', 0.02);
title('correlation red channel range')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\correlation red channel range.png');
figure,histogram(Correlation_weed_y(:,:,2), 'BinWidth', 0.02);
hold on
histogram(Correlation_onion_y(:,:,2), 'BinWidth', 0.02);
title('correlation green channel range')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\correlation green channel range.png');
figure,histogram(Correlation_weed_y(:,:,3), 'BinWidth', 0.02);
hold on
histogram(Correlation_onion_y(:,:,3), 'BinWidth', 0.02);
title('correlation blue channel range')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\correlation blue channel range.png');
figure,histogram(Correlation_weed_y(:,:,4), 'BinWidth', 0.02);
hold on
histogram(Correlation_onion_y(:,:,4), 'BinWidth', 0.02);
title('correlation depth channel range')
legend('weed', 'onion')
hold off
saveas(gcf, 'D:\semester B\computer vision\assessement\task 2\histogram\correlation depth channel range.png');


%%%%%%%%%%% SVM 
%%% creting data for trainig and testing
feature_shape_svm=[avg_Circularity_weed',avg_CircularityM_weed',avg_non_compactness_weed',avg_Eccentricity_weed',avg_solidity_weed';avg_Circularity_onion',avg_CircularityM_onion',avg_non_compactness_onion',avg_Eccentricity_onion',avg_solidity_onion'];
feature_texture_svm=[Energy_weed_x(:,:,1),Energy_weed_x(:,:,2),Energy_weed_x(:,:,3),Energy_weed_x(:,:,4),contrast_weed_x(:,:,1),contrast_weed_x(:,:,2),contrast_weed_x(:,:,3),contrast_weed_x(:,:,4),Correlation_weed_x(:,:,1),Correlation_weed_x(:,:,2),Correlation_weed_x(:,:,3),Correlation_weed_x(:,:,4);Energy_onion_x(:,:,1),Energy_onion_x(:,:,2),Energy_onion_x(:,:,3),Energy_onion_x(:,:,4),contrast_onion_x(:,:,1),contrast_onion_x(:,:,2),contrast_onion_x(:,:,3),contrast_onion_x(:,:,4),Correlation_onion_x(:,:,1),Correlation_onion_x(:,:,2),Correlation_onion_x(:,:,3),Correlation_onion_x(:,:,4)];
for i = 1:18
    label_svm_train{i} = 'weed';
    label_svm_train{i+18} = 'onion';
end
label_svm_train=label_svm_train';
%%%%svm for combination of all features
feature_comb_all_svm=[feature_shape_svm,feature_texture_svm];
feature_comb_all_svm_train=[feature_comb_all_svm(1:18,:);feature_comb_all_svm(21:38,:)];
feature_comb_all_svm_test=[feature_comb_all_svm(19:20,:);feature_comb_all_svm(39:40,:)];
combine_model=fitcsvm(feature_comb_all_svm_train,label_svm_train);
[predict_combine,score_combine]=predict(combine_model,feature_comb_all_svm_test);
%%%%svm for shape
feature_shape_svm_train=[feature_shape_svm(1:18,:);feature_shape_svm(21:38,:)];
feature_shape_svm_test=[feature_shape_svm(19:20,:);feature_shape_svm(39:40,:)];
shape_model=fitcsvm(feature_shape_svm_train,label_svm_train);
[predict_shape, score_shape]=predict(shape_model,feature_shape_svm_test);
%%%%svm for texture
feature_texture_svm_train=[feature_texture_svm(1:18,:);feature_texture_svm(21:38,:)];
feature_texture_svm_test=[feature_texture_svm(19:20,:);feature_texture_svm(39:40,:)];
texture_model=fitcsvm(feature_texture_svm_train,label_svm_train);
[predict_texture,score_texture]=predict(texture_model,feature_texture_svm_test);

%%%%%%%% analysis features
figure()
plot(combine_model.Beta,'bo')
grid on
xlabel('Feature index')
ylabel('Feature weight')
BF = fscnca(feature_comb_all_svm_train,label_svm_train,'Solver','sgd','Verbose',1);
figure()
plot(BF.FeatureWeights,'bo')
grid on
xlabel('Feature index')
ylabel('Feature weight')
%%%%%%%%%%%%%% svm 10best festure
best10_featur_train=[feature_comb_all_svm_train(:,1:3),feature_comb_all_svm_train(:,5),feature_comb_all_svm_train(:,10:15)];
best10_featur_test=[feature_comb_all_svm_test(:,1:3),feature_comb_all_svm_test(:,5),feature_comb_all_svm_test(:,10:15)];
best10_model=fitcsvm(best10_featur_train,label_svm_train);
[predict_best10, score_best10]=predict(best10_model,best10_featur_test);
