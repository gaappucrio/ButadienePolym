    clear all
    clc
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 eixox2 = 'k_{p_{12}} (L.mol^{-1}.s^{-1})';
 eixox1 = 'Orthogonal Collocation Points';
 
 eixo1 = 'Param(01)';
 eixo2 = 'Param(02)';
 eixo3 = 'Param(03)';
 eixo4 = 'Param(04)';
 eixo5 = 'Param(05)';
 eixo6 = 'Param(06)';

 eixoy1 = 'Value of Ort. Colloc. Points';
 eixoy2 = 'k_b (L.mol^{-1}.s^{-1})';
 eixoy3 = 'w_{log(Molecular weight)}';
 eixoy4 = 'LCB/chain';
 eixoy5 = 'Log{(LCB/chain)}';
 %eixoy5 = 'log{(RCL/cadeia)}';

 lg1 = 'Dead'; 
 lg2 = 'Living';
 lg3 = 'Overall';
 lg4 = 'LCB/chain';
 
 f = 16;
 s = 16; 
 lw = 1.5;
 
 size1 = 1; %type1 
 size2 = 4; %type2
 size3 = 6; % type3
 sizePO = 6;
 
  
 type1 = '-rh';
 type2 = '-bv';
 type3 = '-mo';
 type4 = '-g^';
 type5 = '-k*';
 type6 = '-rp';
 type7 = '-b^';
 type8 = '-mx';
 type9 = '-g+';
 type10 = '-ks';
 typea = 'ko';
 typePO = 'ro';

 
 color_dado1 = 'red';
 color_dado2 = 'blue';
 color_dado3 = 'magenta';
 color_dado4 = 'green';
 color_dado5 = 'black';
 color_dadoPO = 'white';

 legendposition1 = 'NorthEast';
 legendposition2 = 'NorthWest';

 
RCfile = 'RegConf.dat';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  LEITURA DOS DADOS DOS ARQUIVOS.TXT                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 10000;
fid = fopen(RCfile,'r');         % Lendo o arquivo
A = fscanf(fid,'%f',[7,n]);         % [coluna,linhas]  
B = A';                             % [linhas,colunas]  

param1       = B(:,1); %k1
param2       = B(:,2); %Akp
param3       = B(:,3); %UA
param4       = B(:,4); %ktx
param5       = B(:,5);
param6       = B(:,6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
width = 5;      % inches
height = 4;     %inches
pp = 1.0;

k1	=	-1.916890	;
k2	=	-1.915410	;
k3	=	2.530710	;
k4	=	2.101290	;
k5	=	-1.283150	;
k6	=	-1.639350	;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1)

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
plot(param1,param2,typea,'MarkerFaceColor',color_dado5,'MarkerSize',size1); 
hold on
plot(k1,k2,typePO,'MarkerFaceColor',color_dadoPO,'MarkerSize',sizePO); 

%  y0 = 0;
%  yf = 1.5e4;
%  ylim([y0,yf]) 
%  set(gca,'ytick',[y0:0.25e4:yf])
%  
%  x0 = 0;
%  xf = 0.25e4;
%  xlim([x0 xf]) 
%  set(gca,'xtick',[x0:0.05e4:xf])

xlabel(eixo1,'FontSize',s)
ylabel(eixo2,'FontSize',s)
set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','RC12.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2) 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
 plot(param1,param3,typea,'MarkerFaceColor',color_dado5,'MarkerSize',size1); 
 hold on
plot(k1,k3,typePO,'MarkerFaceColor',color_dadoPO,'MarkerSize',sizePO); 

%  y0 = 0;
%  yf = 1.5e4;
%  ylim([y0,yf]) 
%  set(gca,'ytick',[y0:0.25e4:yf])
%  
%  x0 = 0;
%  xf = 0.25e4;
%  xlim([x0 xf]) 
%  set(gca,'xtick',[x0:0.05e4:xf])

xlabel(eixo1,'FontSize',s)
ylabel(eixo3,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','RC13.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3) 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
plot(param2,param3,typea,'MarkerFaceColor',color_dado5,'MarkerSize',size1); 
hold on
plot(k2,k3,typePO,'MarkerFaceColor',color_dadoPO,'MarkerSize',sizePO); 

%  y0 = 0;
%  yf = 1.5e4;
%  ylim([y0,yf]) 
%  set(gca,'ytick',[y0:0.25e4:yf])
%  
%  x0 = 0;
%  xf = 0.25e4;
%  xlim([x0 xf]) 
%  set(gca,'xtick',[x0:0.05e4:xf])

xlabel(eixo2,'FontSize',s)
ylabel(eixo3,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','RC23.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4) 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
plot(param2,param4,typea,'MarkerFaceColor',color_dado5,'MarkerSize',size1); 
hold on
plot(k2,k4,typePO,'MarkerFaceColor',color_dadoPO,'MarkerSize',sizePO); 

%  y0 = 0;
%  yf = 1.5e4;
%  ylim([y0,yf]) 
%  set(gca,'ytick',[y0:0.25e4:yf])
%  
%  x0 = 0;
%  xf = 0.25e4;
%  xlim([x0 xf]) 
%  set(gca,'xtick',[x0:0.05e4:xf])

xlabel(eixo2,'FontSize',s)
ylabel(eixo4,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','RC24.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(5) 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
plot(param1,param4,typea,'MarkerFaceColor',color_dado5,'MarkerSize',size1); 
hold on
plot(k1,k4,typePO,'MarkerFaceColor',color_dadoPO,'MarkerSize',sizePO); 

%  y0 = 0;
%  yf = 1.5e4;
%  ylim([y0,yf]) 
%  set(gca,'ytick',[y0:0.25e4:yf])
%  
%  x0 = 0;
%  xf = 0.25e4;
%  xlim([x0 xf]) 
%  set(gca,'xtick',[x0:0.05e4:xf])

xlabel(eixo1,'FontSize',s)
ylabel(eixo4,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','RC14.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(6) 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
plot(param3,param4,typea,'MarkerFaceColor',color_dado5,'MarkerSize',size1); 
hold on
plot(k3,k4,typePO,'MarkerFaceColor',color_dadoPO,'MarkerSize',sizePO); 

%  y0 = 0;
%  yf = 1.5e4;
%  ylim([y0,yf]) 
%  set(gca,'ytick',[y0:0.25e4:yf])
%  
%  x0 = 0;
%  xf = 0.25e4;
%  xlim([x0 xf]) 
%  set(gca,'xtick',[x0:0.05e4:xf])

xlabel(eixo3,'FontSize',s)
ylabel(eixo4,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','RC34.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(7) 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
plot(param3,param5,typea,'MarkerFaceColor',color_dado5,'MarkerSize',size1); 
hold on
plot(k3,k5,typePO,'MarkerFaceColor',color_dadoPO,'MarkerSize',sizePO); 

%  y0 = 0;
%  yf = 1.5e4;
%  ylim([y0,yf]) 
%  set(gca,'ytick',[y0:0.25e4:yf])
%  
%  x0 = 0;
%  xf = 0.25e4;
%  xlim([x0 xf]) 
%  set(gca,'xtick',[x0:0.05e4:xf])

xlabel(eixo3,'FontSize',s)
ylabel(eixo5,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','RC35.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(8) 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
plot(param4,param5,typea,'MarkerFaceColor',color_dado5,'MarkerSize',size1); 
hold on
plot(k4,k5,typePO,'MarkerFaceColor',color_dadoPO,'MarkerSize',sizePO); 

%  y0 = 0;
%  yf = 1.5e4;
%  ylim([y0,yf]) 
%  set(gca,'ytick',[y0:0.25e4:yf])
%  
%  x0 = 0;
%  xf = 0.25e4;
%  xlim([x0 xf]) 
%  set(gca,'xtick',[x0:0.05e4:xf])

xlabel(eixo4,'FontSize',s)
ylabel(eixo5,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','RC45.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(9) 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
plot(param2,param5,typea,'MarkerFaceColor',color_dado5,'MarkerSize',size1); 
hold on
plot(k2,k5,typePO,'MarkerFaceColor',color_dadoPO,'MarkerSize',sizePO); 

%  y0 = 0;
%  yf = 1.5e4;
%  ylim([y0,yf]) 
%  set(gca,'ytick',[y0:0.25e4:yf])
%  
%  x0 = 0;
%  xf = 0.25e4;
%  xlim([x0 xf]) 
%  set(gca,'xtick',[x0:0.05e4:xf])

xlabel(eixo2,'FontSize',s)
ylabel(eixo5,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','RC25.tiff') % -djpg, -dpng
hold off 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(10) 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
plot(param1,param5,typea,'MarkerFaceColor',color_dado5,'MarkerSize',size1); 
hold on
plot(k1,k5,typePO,'MarkerFaceColor',color_dadoPO,'MarkerSize',sizePO); 

%  y0 = 0;
%  yf = 1.5e4;
%  ylim([y0,yf]) 
%  set(gca,'ytick',[y0:0.25e4:yf])
%  
%  x0 = 0;
%  xf = 0.25e4;
%  xlim([x0 xf]) 
%  set(gca,'xtick',[x0:0.05e4:xf])

xlabel(eixo1,'FontSize',s)
ylabel(eixo5,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','RC15.tiff') % -djpg, -dpng
hold off 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(11) 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
plot(param1,param6,typea,'MarkerFaceColor',color_dado5,'MarkerSize',size1); 
hold on
plot(k1,k6,typePO,'MarkerFaceColor',color_dadoPO,'MarkerSize',sizePO); 

%  y0 = 0;
%  yf = 1.5e4;
%  ylim([y0,yf]) 
%  set(gca,'ytick',[y0:0.25e4:yf])
%  
%  x0 = 0;
%  xf = 0.25e4;
%  xlim([x0 xf]) 
%  set(gca,'xtick',[x0:0.05e4:xf])

xlabel(eixo1,'FontSize',s)
ylabel(eixo6,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','RC16.tiff') % -djpg, -dpng
hold off 