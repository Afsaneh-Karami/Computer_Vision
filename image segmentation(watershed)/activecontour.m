clc;
close all;
similarity1=zeros(16,1);
similarity2=zeros(16,1);
for i=1:16
    if i<10
        file_name=['plant00',num2str(i)];
    else
        file_name=['plant0',num2str(i)];
    end
    img=imread([file_name,'_rgb.png']);
    g_truth=imread([file_name,'_label.png']);
    gray_img=rgb2gray(img);
    mask=zeros(size(gray_img));
    mask(10:end-10,10:end-10)=255;
    plant_segment = activecontour(gray_img,mask,150);
    plant_segment =bwareaopen(plant_segment ,60);
    ImageFolder='D:\semester B\computer vision\assessement\task 1\plant_segment\';
    imwrite(plant_segment,[ImageFolder,file_name,'_plant_seg_active.png'])
    Bw_g_truth=g_truth>0;
    bw=createMask(img);
    imwrite(bw,[ImageFolder,file_name,'_plant_seg_mask.png'])
    imwrite(Bw_g_truth,[ImageFolder,file_name,'_gt1.png'])
    similarity1(i)=dice(plant_segment,Bw_g_truth);
    similarity2(i)=dice(bw,Bw_g_truth);
     
end
similarity=[similarity1 similarity2];
mean_sim1=mean(similarity1);
mean_sim2=mean(similarity2);
figure,bar(similarity,'grouped')
xlabel('number of image')
ylabel('dice value')
legend('acti', 'mask','Location','bestoutside')
disp(['average of dice for active contour methos is: ',num2str(mean_sim1)])
disp(['average of dice for mask methos is: ',num2str(mean_sim2)])


