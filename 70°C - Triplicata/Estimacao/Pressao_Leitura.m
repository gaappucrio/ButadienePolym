clear all
clc
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eixox2 = 'k_{p_{12}} (L.mol^{-1}.s^{-1})';
eixox1 = 'Orthogonal Collocation Points';

eixo1 = 't (min)';
eixo2 = 'T (^{\circ}C) ';
eixo3 = 'P (bar)';
eixoy1 = 'Value of Ort. Colloc. Points';
eixoy2 = 'k_b (L.mol^{-1}.s^{-1})';
eixoy3 = 'w_{log(Molecular weight)}';
eixoy4 = 'LCB/chain';
eixoy5 = 'Log{(LCB/chain)}';

lg1 = 'P_{butadieno}';
lg2 = 'P_{n-hexano}';
lg3 = 'P_{N_2}';
 
f = 16;
s = 16; 
lw = 1.5;
ss = 2.0;
ss0 = 2.0;
size1 = 6; %type1 
size2 = 9; %type2
size3 = 7; % type3
size4 = 5;
 
type1 = '-bo';
type2 = '-rv';
type3 = '-gs';
type4 = '-.rp';
type5 = '-.bh';
type6 = '-.k*';
type7 = '-.gs';
type8 = '-.gx';

color_dado1 = 'blue';
color_dado2 = 'red';
color_dado3 = 'green';
color_dado4 = 'black';
color_dado5 = 'white';
color_dado6 = [0 .7 .7];

legendposition1 = 'NorthEast';
legendposition2 = 'NorthWest';
legendposition3 = 'SouthEast';
legendposition4 = 'NorthOutside';
legendposition5 = 'SouthWest';

RCfile = 'Pressao.txt';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  LEITURA DOS DADOS DOS ARQUIVOS.TXT                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 10000;
fid = fopen(RCfile,'r');         % Lendo o arquivo
A = fscanf(fid,'%f',[5,n]);         % [coluna,linhas]  
B = A';                             % [linhas,colunas]  

t            = B(:,1); 
P            = B(:,2);
PM           = B(:,3);
PS           = B(:,4);
PI           = B(:,5);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

width = 5;      % inches
height = 4;     %inches
pp = 1.0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
 
plot(t,PM,type1,'MarkerFaceColor',color_dado4,'MarkerSize',size3,'LineWidth', ss0);
hold on
plot(t,PS,type2,'MarkerFaceColor',color_dado4,'MarkerSize',size3,'LineWidth', ss0);
plot(t,PI,type3,'MarkerFaceColor',color_dado4,'MarkerSize',size3,'LineWidth', ss0);

y0 = 0;
yf = 2.4;
ylim([y0,yf]) 
set(gca,'ytick',[y0:0.2:yf])
 
x0 = 0;
xf = 125;
xlim([x0 xf]) 
set(gca,'xtick',[x0:20:xf])

legend_handle = legend(lg1,lg2,lg3);
set(legend_handle, 'Box', 'off','Location',legendposition1)

xlabel(eixo1,'FontSize',s)
ylabel(eixo3,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','Pparciais.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
 
plot(t,PM+PS+PI,type1,'MarkerFaceColor',color_dado4,'MarkerSize',size3,'LineWidth', ss0);
hold on

y0 = 1.5;
yf = 3.5;
ylim([y0,yf]) 
set(gca,'ytick',[y0:0.25:yf])
 
x0 = 0;
xf = 125;
xlim([x0 xf]) 
set(gca,'xtick',[x0:20:xf])

% legend_handle = legend(lg1,lg2,lg3);
% set(legend_handle, 'Box', 'off','Location',legendposition1)

xlabel(eixo1,'FontSize',s)
ylabel(eixo3,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','Ptot.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
 
plot(t,PM,type1,'MarkerFaceColor',color_dado4,'MarkerSize',size3,'LineWidth', ss0);
hold on
plot(t,PS,type2,'MarkerFaceColor',color_dado4,'MarkerSize',size3,'LineWidth', ss0);
plot(t,PI,type3,'MarkerFaceColor',color_dado4,'MarkerSize',size3,'LineWidth', ss0);

y0 = 0;
yf = 2.4;
ylim([y0,yf]) 
set(gca,'ytick',[y0:0.2:yf])
 
x0 = 0;
xf = 20;
xlim([x0 xf]) 
set(gca,'xtick',[x0:5:xf])

legend_handle = legend(lg1,lg2,lg3);
set(legend_handle, 'Box', 'off','Location',legendposition1)

xlabel(eixo1,'FontSize',s)
ylabel(eixo3,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','Pparciaiszoom.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%