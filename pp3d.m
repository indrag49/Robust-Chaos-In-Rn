function pp3d

figHeight = 5;      % height of figure in tex file
figWidth = 8;       % width of figure in tex file

hh = figHeight*1.2;         % sizing factor
zAxRatio = .58;             % extra sizing factor
va = [1.81,-.011,.011];     % camera position
swManColor = .65*[1,1,1];   % switching manifold colour
faceAlpha = .8;             % opacity

xMin = -3;
xMax = 1.2;
yMin = -.001;
yMax = .0004;
zMin = -.001;
zMax = .002;

xAxMin = -2.7;
xAxMax = 1.16;
yAxMin = -.0019;
yAxMax = .0017;
zAxMin = -.0027;
zAxMax = .0027;

ySwManMin = -.001;
ySwManMax = .001;
zSwManMin = -.002;
zSwManMax = .002;

sR = .00005;
sN = 15;
[sx,sy,sz] = sphere(sN);
sx = .35*sx*(xMax-xMin)/(zMax-zMin);
sy = .5*sy*(yMax-yMin)/(zMax-zMin);

X_star = [4.08000065e-01 -3.99840064e-04 -2.36640038e-04];
Y_star = [-2.50100040e+00  4.00160064e-04  1.40056022e-03];
DATA = importdata('pp_3D.csv');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
clf
hold on
set(gcf,'Position',[500,300,420*figWidth/figHeight,420])
set(gca,'Position',[-.13,.17,1.12,.74],...
        'CameraPosition',va,...
        'Clipping','off')
axis([xMin,xMax,yMin,yMax,zMin,zMax])
axis off

% axes
arrSize = .13/hh;
plot3(xAxMin+[0,.98*(xAxMax-xAxMin)],[0,0],[0,0],'k-','LineWidth',10/hh)
ARR = getArrow3dNew([xAxMin,xAxMax;0,0;0,0]',2,1,arrSize,xMax-xMin,yMax-yMin,zMax-zMin,va,...
    zAxRatio,get(gca,'Position'),get(gcf,'Position'),.5,.5,0);
fill3(ARR([2,1,4],1),ARR([2,1,4],2),ARR([2,1,4],3),'k',...
    'EdgeColor','none')

plot3([0,0],yAxMin+[0,.98*(yAxMax-yAxMin)],[0,0],'k-','LineWidth',10/hh)
ARR = getArrow3dNew([0,0;yAxMin,yAxMax;0,0]',2,1,arrSize,xMax-xMin,yMax-yMin,zMax-zMin,va,...
    zAxRatio,get(gca,'Position'),get(gcf,'Position'),.5,.5,0);
fill3(ARR([2,1,4],1),ARR([2,1,4],2),ARR([2,1,4],3),'k',...
    'EdgeColor','none')

plot3([0,0],[0,0],zAxMin+[0,.98*(zAxMax-zAxMin)],'k-','LineWidth',10/hh)
ARR = getArrow3dNew([0,0;0,0;zAxMin,zAxMax]',2,1,arrSize,xMax-xMin,yMax-yMin,zMax-zMin,va,...
    zAxRatio,get(gca,'Position'),get(gcf,'Position'),.5,.5,0);
fill3(ARR([2,1,4],1),ARR([2,1,4],2),ARR([2,1,4],3),'k',...
    'EdgeColor','none')

% switching manifold
fill3([0,0,0,0],[ySwManMin,ySwManMin,ySwManMax,ySwManMax],[zSwManMin,zSwManMax,zSwManMax,zSwManMin],swManColor,...
    'EdgeColor','none','FaceAlpha',faceAlpha)

% attractor
ind0 = 50;   % remove transient
DATA = DATA(ind0:end,:);
plot3(DATA(:,1),DATA(:,2),DATA(:,3),'k.','MarkerSize',25/hh)

% fixed points
surf(X_star(1)+sR*sx,X_star(2)+sR*sy,X_star(3)+sR*sz,'FaceColor','k')
surf(Y_star(1)+sR*sx,Y_star(2)+sR*sy,Y_star(3)+sR*sz,'FaceColor','k')

% labels
text(xAxMax+.03,0,0,'$x_1$','Interpreter','latex','FontSize',116/hh)
text(-.07,yAxMax+.0002,0,'$x_2$','Interpreter','latex','FontSize',116/hh)
text(-.07,0,zAxMax+.0002,'$x_3$','Interpreter','latex','FontSize',116/hh)
text(X_star(1)-.02,X_star(2),X_star(3)-.00029,'$X$','Interpreter','latex','FontSize',116/hh)
text(Y_star(1)+.05,Y_star(2),Y_star(3)-.00004,'$Y$','Interpreter','latex','FontSize',116/hh)
text(.03,ySwManMin,zSwManMax-.0002,'$\Sigma$','Interpreter','latex','FontSize',116/hh)
