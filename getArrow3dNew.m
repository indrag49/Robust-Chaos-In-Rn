% va: CameraPosition of axes, may need manual adjustment
% zAxRatio: manual estimate of ratio of length of z-axis to height of axes
function ARR = getArrow3dNew(DATA,j,d,w,xRange,yRange,zRange,va,zAxRatio,axPosition,figPosition,ca1,ca2,showConstruct)

YFigRange = 1;
XFigRange = figPosition(3)/figPosition(4)*YFigRange;
XAxRange = axPosition(3)*XFigRange;
YAxRange = axPosition(4)*YFigRange;

aVec = [1,1;va(1)/xRange,va(2)/yRange]\[XAxRange;0];
bVec = [1,1;-va(1)/xRange,va(2)/yRange]\[(1-zAxRatio)*YAxRange;-va(3)*zAxRatio*YAxRange/zRange];

A = [aVec(1)/xRange,aVec(2)/yRange,0;-bVec(1)/xRange,bVec(2)/yRange,zAxRatio*YAxRange/zRange];

vb = (DATA(j-d,:)-DATA(j,:))';
XYb = A*vb;
vb = w*vb/norm(XYb);

XYc = [-XYb(2);XYb(1)];
vc = [A;va]\[XYc;0];
vc = w*vc/norm(XYc);

p = DATA(j,:)';
ARR = [p,p+(1+ca1)*vb+ca2*vc,p+vb,p+(1+ca1)*vb-ca2*vc]';

if showConstruct == 1
    disp(['calculated ratio of height where z-axis starts: ',num2str(bVec(1)/YAxRange)])
    plot3(p(1)+[0,va(1);0,vb(1);0,vc(1)]',p(2)+[0,va(2);0,vb(2);0,vc(2)]',p(3)+[0,va(3);0,vb(3);0,vc(3)]','c*-')
end
