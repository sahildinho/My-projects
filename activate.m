function y_n = activate(img,thr)
[im,im2] = Me_actv_Mask(img);
eto = regionprops(im);
% bbox = [176.500000000000,24.5000000000000,80,144];
% IMG = insertShape(img,'rectangle',bbox,'LineWidth',5);
% imshow(IMG)
if ~isempty(eto) && eto(1).Area >= thr
    y_n = 1;
else
    y_n = 0;
end
end