
%Calculate the average number of black pixels in the ground truth images.

%Get the directory to the folder of the ground truth images
files = dir ('C:\Users\roosv_000\Documents\Natural-Computing-Project\Dataset\Trainset\');
[a,b] = size(files);
count=0;

%For all files in this folder do the following:
for i=1:a 
   % see if the name contains edge.png
   s= findstr(files(i).name,'edge.png');
   k = isempty(s);
   l = size(files(i).name);
   
   %if it does contain edge.png (and it contains more than 3 characters) than it is a ground truth image so do the
   %following:
    if k==0 && l(2)>3;
        %get the ground truth image and normalize it
        direct = strcat('C:\Users\roosv_000\Documents\Natural-Computing-Project\Dataset\Trainset\',files(i).name);
        GT = imread(direct)/255; 
        %Sum over the hole ground truth image to get the amount of pixel
        %with value 1 (white pixels)
        sumgt(i) = sum(GT(:));
        count=count+1;
    end
    
end
sumgt(sumgt==0)=[]
p=size(GT);

sumgt= p(1)*p(2)-sumgt

%get the average number of the type of pixels
average_nr_black_pixels = sum(sumgt)/count
