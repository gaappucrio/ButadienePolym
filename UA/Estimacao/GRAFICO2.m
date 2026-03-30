clear all
clc
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eixox2 = 'k_{p_{12}} (L.mol^{-1}.s^{-1})';
eixox1 = 'Orthogonal Collocation Points';

eixo1 = 't (min)';
eixo2 = 'T (^{\circ}C) ';
eixoP = 'P (bar)';
eixoy1 = 'Value of Ort. Colloc. Points';
eixoy2 = 'k_b (L.mol^{-1}.s^{-1})';
eixoy3 = 'w_{log(Molecular weight)}';
eixoy4 = 'LCB/chain';
eixoy5 = 'Log{(LCB/chain)}';
eixoMn = 'Mn (g.mol^{-1})';
eixoMw = 'Mw (g.mol^{-1})';
eixocis = 'cis (%)';
eixotrans = 'trans (%)';

%eixoy5 = 'log{(RCL/cadeia)}';
lg1 = 'Experimental data';
lg2 =  'Model data';
lg3 =  'Model confidence interval';
 
f = 16;
s = 16; 
lw = 1.5;
ss = 2.0;
ss0 = 1.0;
size1 = 6; %type1 
size2 = 9; %type2
size3 = 7; % type3
size4 = 5;
 
type1 = 'ko';
type2 = 'kv';
type3 = '-.r';
type4 = '-.rp';
type5 = '-.bh';
type6 = '-.k*';
type7 = '-.gs';
type8 = '-.gx';
type33 = '-.rh';

color_dado1 = 'blue';
color_dado2 = 'red';
color_dado3 = 'red';
color_dado4 = 'black';
color_dado5 = 'white';
color_dado6 = [0 .7 .7];

legendposition1 = 'NorthEast';
legendposition2 = 'NorthWest';
legendposition3 = 'SouthEast';
legendposition4 = 'NorthOutside';
legendposition5 = 'SouthWest';

RCfile = 'grafico.dat';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  LEITURA DOS DADOS DOS ARQUIVOS.TXT                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 24*3;
fid = fopen(RCfile,'r');         % Lendo o arquivo
A = fscanf(fid,'%f',[7,n]);         % [coluna,linhas]  
B = A';   % [linhas,colunas]  

t            = B(:,2); 
Texp         = B(:,3) - 273.15e0; 
Tm           = B(:,4) - 273.15e0;
TmI          = B(:,5) - 273.15e0;
TmS          = B(:,6) - 273.15e0;
Terr         = B(:,7); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

width = 5;      % inches
height = 4;     %inches
pp = 1.0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n0 = 1;
nn = 24;

% Suavizar as curvas inferior e superior
x0 = 0;
xf = 50;
x = t(n0:nn);
xi = x0:1:xf;
yS = TmS(n0:nn);
yiS = spline(x,yS,xi);
yI = TmI(n0:nn);
yiI = spline(x,yI,xi);


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
 
%plot(t,Texp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
errorbar(t(n0:nn),Texp(n0:nn),Terr(n0:nn),type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
hold on
plot(xi,yiI,type3,'LineWidth', ss);
plot(t(n0:nn),Tm(n0:nn),type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
plot(xi,yiS,type3,'LineWidth', ss);

y0 = 50;
yf = 70;
ylim([y0,yf]) 
set(gca,'ytick',[y0:2.5:yf])
 
x0 = 0;
xf = 50;
xlim([x0 xf]) 
set(gca,'xtick',[x0:10:xf])

legend_handle = legend(lg1,lg3,lg2);
set(legend_handle, 'Box', 'off','Location',legendposition1)

xlabel(eixo1,'FontSize',s)
ylabel(eixo2,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','Temp60.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n0 = 25;
nn = 24*2;

% Suavizar as curvas inferior e superior
x0 = 0;
xf = 50;
x = t(n0:nn);
xi = x0:1:xf;
yS = TmS(n0:nn);
yiS = spline(x,yS,xi);
yI = TmI(n0:nn);
yiI = spline(x,yI,xi);


figure(2) 
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
%plot(t,Texp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
errorbar(t(n0:nn),Texp(n0:nn),Terr(n0:nn),type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
hold on
plot(xi,yiI,type3,'LineWidth', ss);
plot(t(n0:nn),Tm(n0:nn),type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
plot(xi,yiS,type3,'LineWidth', ss);

y0 = 50;
yf = 80;
ylim([y0,yf]) 
set(gca,'ytick',[y0:2.5:yf])
 
x0 = 0;
xf = 50;
xlim([x0 xf]) 
set(gca,'xtick',[x0:10:xf])

legend_handle = legend(lg1,lg3,lg2);
set(legend_handle, 'Box', 'off','Location',legendposition1)

xlabel(eixo1,'FontSize',s)
ylabel(eixo2,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','Temp70.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n0 = 49;
nn = 24*3;

% Suavizar as curvas inferior e superior
x0 = 0;
xf = 50;
x = t(n0:nn);
xi = x0:1:xf;
yS = TmS(n0:nn);
yiS = spline(x,yS,xi);
yI = TmI(n0:nn);
yiI = spline(x,yI,xi);


figure(3) 
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
%plot(t,Texp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
errorbar(t(n0:nn),Texp(n0:nn),Terr(n0:nn),type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
hold on
plot(xi,yiI,type3,'LineWidth', ss);
plot(t(n0:nn),Tm(n0:nn),type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
plot(xi,yiS,type3,'LineWidth', ss);

y0 = 60;
yf = 100;
ylim([y0,yf]) 
set(gca,'ytick',[y0:2.5:yf])
 
x0 = 0;
xf = 50;
xlim([x0 xf]) 
set(gca,'xtick',[x0:10:xf])

legend_handle = legend(lg1,lg3,lg2);
set(legend_handle, 'Box', 'off','Location',legendposition1)

xlabel(eixo1,'FontSize',s)
ylabel(eixo2,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','Temp80.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
