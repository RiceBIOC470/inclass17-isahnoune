%In this folder, you will find two images img1.tif and img2.tif that have
%some overlap. Use two different methods to align them - the first based on
%pixel values in the original images and the second using the fourier
%transform of the images. In both cases, display your results. 

img1 = imread('img1.tif');
imshow(img1, [200 1000]);

img2 = imread('img2.tif');
imshow(img2, [200 1000]);

diffs = zeros(1, 600);
for ov = 1:599
    pix1 = img1(:,(end-ov):end);
    pix2 = img2(:,1:(1+ov));
    diffs(ov)=sum(sum(abs(pix1-pix2)))/ov;
end


[~,overlap] = min(diffs);
img2_align = [zeros(600, size(img2,2)-overlap+1), img2];
imshowpair(img1,img2_align);

img1ft = fft2(img1); img2ft = fft2(img2);
CC=ifft2(img1ft.*conj(img2ft));
CCabs = abs(CC);
figure; imshow(CCabs,[]);

[row_shift, col_shift] = find(CCabs == max(CCabs(:)));
[nr,nc] = size(img2ft);
Nr = ifftshift(-fix(nr/2):ceil(nr/2)-1);
Nc = ifftshift(-fix(nc/2):ceil(nc/2)-1);
row_shift = Nr(row_shift);
col_shift = Nc(col_shift);

img_shift = zeros(size(img2) + [row_shift, col_shift]);
img_shift((end-599):end, (end-599:end)) = img2;
imshowpair(img1, img_shift);



    