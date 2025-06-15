function pp10d

figHeight = 5;      % height of figure in tex file
figWidth = 6.5;       % width of figure in tex file

hh = figHeight*1.2;         % sizing factor
zAxRatio = .58;             % extra sizing factor
va = [1.36,-82,26];     % camera position
swManColor = .65*[1,1,1];   % switching manifold colour
faceAlpha = .8;             % opacity

xMin = -1.2;
xMax = 1.2;
yMin = -5;
yMax = 5;
zMin = -5;
zMax = 5;

xAxMin = -.7;
xAxMax = 1;
yAxMin = -14;
yAxMax = 14;
zAxMin = -6.5;
zAxMax = 6.5;

ySwManMin = -8;
ySwManMax = 8;
zSwManMin = -5;
zSwManMax = 5;

sR = .05;
sN = 15;
[sx,sy,sz] = sphere(sN);
sx = .35*sx*(xMax-xMin)/(zMax-zMin);
sy = .5*sy*(yMax-yMin)/(zMax-zMin);

DATA = importdata('pp_10D.csv');

DATA(:, 2)

DATA(:,2) = DATA(:,2)*10^22;
DATA(:,3) = DATA(:,3)*10^22;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
clf
hold on
set(gcf,'Position',[500,300,420*figWidth/figHeight,420])
set(gca,'Position',[-.27,.06,1.34,.88],...
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
%surf(X_star(1)+sR*sx,X_star(2)+sR*sy,X_star(3)+sR*sz,'FaceColor','k')
%surf(Y_star(1)+sR*sx,Y_star(2)+sR*sy,Y_star(3)+sR*sz,'FaceColor','k')

% labels
text(xAxMax,0,0,'$x_1$','Interpreter','latex','FontSize',116/hh)
text(-.05,yAxMax+.0002,0.3,'$x_9$','Interpreter','latex','FontSize',116/hh)
text(-.07,0,zAxMax+0.5,'$x_{10}$','Interpreter','latex','FontSize',116/hh)
%text(X_star(1)-.02,X_star(2),X_star(3)-.00029,'$X$','Interpreter','latex','FontSize',116/hh)
%text(Y_star(1)+.05,Y_star(2),Y_star(3)-.00004,'$Y$','Interpreter','latex','FontSize',116/hh)
text(.03,ySwManMin,zSwManMax-.001,'$\Sigma$','Interpreter','latex','FontSize',116/hh)
