function   ratio= ol_ratio( GTframe,Reframe)
%OL_RATIO 此处显示有关此函数的摘要
%GTframe  检测到得BB 格式为左上角点坐标和边界框的长宽
%Reframe  标定的BB   格式为左上角点坐标和边界框的长宽

x1 = Reframe(2);
y1 = Reframe(1);
width1 = Reframe(4);
height1 = Reframe(3);

x2 = GTframe(2);
y2 = GTframe(1);
width2 = GTframe(4);
height2 = GTframe(3);

endx = max(x1+width1,x2+width2);
startx = min(x1,x2);
width = width1+width2-(endx-startx);

endy = max(y1+height1,y2+height2);
starty = min(y1,y2);
height = height1+height2-(endy-starty);

if width<=0||height<=0
    ratio = 0;
else
    Area = width*height;
    Area1 = width1*height1;
    Area2 = width2*height2;
    ratio = Area/(Area1+Area2-Area);
end