GT = imread('C:\Users\roosv_000\Documents\Natural-Computing-Project\Dataset\11_edge.jpg')/255; 
P_Color = imread('C:\Users\roosv_000\Documents\Natural-Computing-Project\Code\ACO_RGB_separate\kat3_or.jpg')/255;
P_Gray = imread('C:\Users\roosv_000\Documents\Natural-Computing-Project\Code\ACO_RGB_separate\kat0_grayscale_edge.jpg')/255;
P_Color_Vector = imread('C:\Users\roosv_000\Documents\Natural-Computing-Project\Code\ACO_Vector\test_edge - kopie.jpg')/255;

GT=double(GT)

P_Color_s = sum(P_Color,3)/3;
P_Color_Vector_s = sum(P_Color_Vector,3);
P_Gray_s = sum(P_Gray,3)/3;

EVAL_P_Color = Evaluate(P_Color_s,GT)
EVAL_P_Gray = Evaluate(P_Gray_s,GT)
EVAL_P_Color_Vector = Evaluate(P_Color_Vector,GT)

figure
imshow(GT)

figure
imshow(P_Color_s)

figure
imshow(P_Gray_s)

figure
imshow(P_Color_Vector_s)


