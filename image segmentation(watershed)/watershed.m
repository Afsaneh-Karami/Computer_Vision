clc;
close all;
leaf_count=zeros(16,1);
for i=1:16
    if i<10
        file_name=['plant00',num2str(i)];
    else
        file_name=['plant0',num2str(i)];
    end
    
    img=imread([file_name,'_rgb.png']);
    I1= rgb2gray(img);
    level=graythresh(I1);
    I=imbinarize(I1,level);
    figure;
    subplot(2,2,1);
    imshow(img)
    title('RGB image')
    se = strel('disk',3);
    se1 = strel('disk',1);
    Ie = imopen(I,se);
    Ie1=imerode(Ie,se1);
    Ie3=edge(Ie1,"canny");
    Ie4=Ie1+Ie3;
    Ie5=bwareaopen(Ie4,20);
    subplot(2,2,2);
    imshow(Ie5)
    title('BW image')
    D=bwdist(~Ie5,"quasi-euclidean");
    L=watershed(-D,8);
    subplot(2,2,3);
    imshow(-D,[])
    title('bwdist')
    L(~Ie5)=0;
    out = bwareaopen(L ~= 0, 20);
    Lfinal = zeros(size(L));
    Lfinal(out) = L(out);
    CC = bwconncomp(Lfinal,4);
    L1 = labelmatrix(CC);
    rgb=label2rgb(L1,'jet',[0.5,0.5,0.5]);
    subplot(2,2,4);
    imshow(rgb)
    title(['num of leaves:',num2str(max(max(L1)))])
    leaf_count(i)=(max(max(L1)));
    filename = fullfile('\leaf_segmentation\', [file_name,'_leafseg.png']);
    saveas(gcf, filename, 'png');
end
Leaf_real_number = xlsread( 'Leaf_counts.csv', 'B:B' );
leaf_data=[leaf_count Leaf_real_number];
figure,bar(leaf_data,'grouped')
xlabel('number of image')
ylabel('number of leaves')
legend('count', 'GT','Location','bestoutside')
leaf_diff=abs(Leaf_real_number-leaf_count);
mean_diff=mean(leaf_diff);
tabel=table(leaf_diff,leaf_count,Leaf_real_number);
disp(['Average of diference between real number of leaves and counted by segmentation code is ' ,num2str(mean_diff)])

