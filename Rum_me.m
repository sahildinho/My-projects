clc
clear all
close all

%% get image
p = figure(1);
n = 1;
while ishandle(p)
    c = webcam(1); 
    img = snapshot(c);
    sz = size(img);
    c_axis = floor([0,sz(2)/2.6;sz(1),sz(2)/2.6]); %imaginary axis
    %i_w_l = insertShape(img,'line',c_axis,'color','yellow','linewidth',3); %draw imaginary axis
    [bw,~] = Me_in_Mask(img); %tool mask get binary image bw
    %image(mask_img)
    c_img = bwareaopen(bw,200); %remove noise of less than 200 pix area
    [a,b] = size(c_img); 
    ne = zeros(1,2);
    m = 1;
    for px = 1:a
        for qy = 1:b
            if c_img(px,qy) == 1
                ne(m,1) = qy;
                ne(m,2) = px;
                m = m+1;
            end
        end
    end
    
    x_max = max(ne(:,1));
    x_min = min(ne(:,1));
    y_max = max(ne(:,2));
    y_min = min(ne(:,2));
    tip_t(1,1) = x_max;
    tip_t(1,2) = y_min;
    
    if activate(img,50) == 0
        i_wl_ = insertMarker(img,tip_t,'*','color','black','size',2);
        image(i_wl_);
    elseif activate(img,50) == 1
        tip_t(n,1) = x_max;
        tip_t(n,2) = y_min;
        i_wl_wc_wt = insertMarker(img,tip_t,'*','color','black','size',2);
        image(i_wl_wc_wt);
        %tipss(n,1) = tip_t(1,1);
        %tipss(n,2) = tip_t(1,2);
    end
    drawnow;
    n = n+1;
end