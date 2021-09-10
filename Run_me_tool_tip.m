clc
clear all
close all

%% get image
p = figure(1);
while ishandle(p)
    c = webcam(3); 
    img = snapshot(c);
    sz = size(img);
    c_axis = floor([0,sz(2)/2.6;sz(1),sz(2)/2.6]); %imaginary axis
    i_w_l = insertShape(img,'line',c_axis,'color','yellow','linewidth',3); %draw imaginary axis
    [bw,mask_img] = tool_Mask2(img); %tool mask get binary image bw
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
    
    
    
    
    c_tool_t = regionprops('table',bw,'Centroid','area');
    if isempty(c_tool_t)
        yu = sprintf('no tool');
        disp(yu)
        image(i_w_l)
    else
        tab_a = sortrows(c_tool_t,'Area');
        cen_tool = table2array(tab_a(1,2));
        i_wl_wc = insertMarker(i_w_l,cen_tool,'x');
        
        %distance between centroid and line
        d_cen = lin2pt(cen_tool,c_axis);
        
        if d_cen <= 0
            tip_t(1,1) = x_min;
            tip_t(1,2) = y_min;
        else
            tip_t(1,1) = x_min;
            tip_t(1,2) = y_max;
        end
        i_wl_wc_wt = insertShape(i_wl_wc,'FilledCircle',[tip_t,8],'color','red','Opacity',0.9);
        image(i_wl_wc_wt)
        %distance between tip of tool to line
        d_tip = lin2pt(tip_t,c_axis);
        yu = sprintf('tool tip is %.3f',abs(d_tip));
        disp(yu)
    end
    drawnow
end