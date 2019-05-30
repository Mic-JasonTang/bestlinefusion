% filename1 = 'dragon_left.jpg';
% filename2 = 'dragon_right.jpg';
% A = imread(filename1);
% B = imread(filename2);
% (i=599, j=600), (x=599, y=301)
% A.shape=(600, 600), B.shape=(600, 600), result.shape=(600, 900)
% L=300, R=600, margin=301
% xmove = -301;
% bestlinefusion2(A, B, xmove);
% [H, W, ~] = size(A);
% rowBegin = 1;
% rowEnd = H;
% colBegin = 300;
% colEnd = W;
% 
% % (i=599, j=600), (x=599, y=302)
% % A.shape=(600, 600), B.shape=(600, 600), result.shape=(600, 900)
% % L=299, R=600, margin=301
% bestlinefusion(A, B, rowBegin, rowEnd, colBegin, colEnd, 0);
% 
% filename3 = 'lake_left.jpg';
% filename4 = 'lake_right.jpg';
% A = imread(filename3);
% B = imread(filename4);
% [H, W, ~] = size(A);
% rowBegin = 1;
% rowEnd = H;
% colBegin = 300;
% colEnd = W;
% bestlinefusion(A, B, rowBegin, rowEnd, colBegin, colEnd, 0);

% filename5 = 'building_left.jpg';
% filename6 = 'building_right.jpg';
% rowBegin = 1;
% rowEnd = 807;
% colBegin = 554;
% colEnd = 646;
% filename5 = 'lab_transform2.jpg';
% filename6 = 'KinectScreenshot-Color-10-50-23.bmp';
% A = imread(filename5);
% B = imread(filename6);
% % L=1238;
% % R=1561;
% %
% % A_ = A(:, L:R, :);
% % B_ = B(:, 1:R-L+1, :);
% 
% % (i=1086, j=1561), (x=719, y=324)
% % size(A_)
% % size(B_)
% % figure(5);
% % imshow(A);
% % figure(6);
% % imshow(B);
% [H, W, ~] = size(A);
% rowBegin = 1;
% rowEnd = H;
% colBegin = 968;
% colEnd = 1334;
% bestlinefusion(A, B, rowBegin, rowEnd, colBegin, colEnd, 1);


filename5 = 'imageTransform1.jpg';
filename6 = '20190105103615.jpg';
A = imread(filename5);
B = imread(filename6);
[H, W, ~] = size(A);
rowBegin = 1;
rowEnd = H;
colBegin = 1439;
colEnd = 1935;
bestlinefusion(A, B, rowBegin, rowEnd, colBegin, colEnd, 1);


