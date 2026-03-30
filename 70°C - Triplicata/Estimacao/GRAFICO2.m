clear all
clc
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eixox2 = 'k_{p_{12}} (L.mol^{-1}.s^{-1})';
eixox1 = 'Orthogonal Collocation Points';

eixo1 = 't (min)';
eixo2 = 'Temperature (^{\circ}C) ';
eixoP = 'Pressure (bar)';
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
lg1 = 'ED';
lg2 =  'MD';
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
n = 29;
fid = fopen(RCfile,'r');         % Lendo o arquivo
A = fscanf(fid,'%f',[12,n]);         % [coluna,linhas]  
B = A';   % [linhas,colunas]  

n1 = 25;

t            = B(1:n1,2); 
Texp         = B(1:n1,3) - 273.15e0; 
Tm           = B(1:n1,4) - 273.15e0;
TmI          = B(1:n1,5) - 273.15e0;
TmS          = B(1:n1,6) - 273.15e0;
Terr         = 0.05*Texp;
%Terr         = B(1:n1,7); 

Pexp         = B(1:n1,8); 
Pm           = B(1:n1,9);
PmI          = B(1:n1,10);
PmS          = B(1:n1,11);
Perr         = Pexp*0.1;
%Perr         = B(1:n1,12);


pos = length(Pm);
Pm2 = zeros(pos,1);
% rm = 17;  % Estou robando assim =(
% Pm2(1:rm) = Pexp(1:rm);
% Pm2(rm+1:end) = Pm(rm+1:end);

% Pm2(1:pos-rm) = Pm(rm+1:end);
% Pm2(pos-rm+1:end) = Pm(end);

tf            = t(end);
cisexp        = B(n1+1,3)*100;
cis           = B(n1+1,4)*100;
cisI          = B(n1+1,5)*100;
cisS          = B(n1+1,6)*100;
Errocis       = B(n1+1,7);

transexp       = B(n1+2,3)*100;
trans          = B(n1+2,4)*100;
transI         = B(n1+2,5)*100;
transS         = B(n1+2,6)*100;
Errotrans      = B(n1+2,7);

Mnexp        = B(n1+3,3);
Mn           = B(n1+3,4);
MnI          = B(n1+3,5);
MnS          = B(n1+3,6);
ErroMn       = B(n1+3,7);

Mwexp        = B(n1+4,3);
Mw           = B(n1+4,4);
MwI          = B(n1+4,5);
MwS          = B(n1+4,6); 
ErroMw       = B(n1+4,7);


% ErroMn = (Mnexp*0.01d0); 
% ErroMw = (Mwexp*0.01d0); 
% Errocis = 0.5; %sqrt(cis*0.002d0); 
% Errotrans = 0.5; %sqrt(cis*0.002d0); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

width = 5;      % inches
height = 4;     %inches
pp = 1.0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Suavizar as curvas inferior e superior
x0 = 0;
xf = 125;
x = t;
xi = x0:1:xf;
yS = TmS;
yiS = spline(x,yS,xi);
yI = TmI;
yiI = spline(x,yI,xi);

ySP = PmS;
yiSP = spline(x,ySP,xi);
yIP = PmI;
yiIP = spline(x,yIP,xi);

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
errorbar(t,Texp,Terr,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
hold on
plot(xi,yiI,type3,'LineWidth', ss);
plot(t,Tm,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
plot(xi,yiS,type3,'LineWidth', ss);

y0 = 50;
yf = 95;
ylim([y0,yf]) 
set(gca,'ytick',[y0:15:yf])
 
x0 = 0;
xf = 100;
xlim([x0 xf]) 
set(gca,'xtick',[x0:20:xf])

legend_handle = legend(lg1,lg2);
set(legend_handle, 'Box', 'off','Location',legendposition1)

xlabel(eixo1,'FontSize',s)
ylabel(eixo2,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','Temp.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2) 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
% plot(tf,Mnexp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
errorbar(tf,Mnexp,ErroMn,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
hold on
plot(tf,MnI,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
plot(tf,Mn,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
plot(tf,MnS,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 

%y0 = 1.50e5;
% yf = 2.5e5;
% ylim([y0,yf]) 
% set(gca,'ytick',[y0:0.1e5:yf])
 
x0 = 120-50;
xf = 120+50;
xlim([x0 xf]) 
set(gca,'xtick',[x0:10:xf])

legend_handle = legend(lg1,lg3,lg2);
set(legend_handle, 'Box', 'off','Location',legendposition2)

xlabel(eixo1,'FontSize',s)
ylabel(eixoMn,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
print('-dtiff','-r600','Mn.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4) 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
% plot(tf,Mwexp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
errorbar(tf,Mwexp,ErroMw,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
hold on
plot(tf,MwI,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
plot(tf,Mw,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
plot(tf,MwS,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 

%y0 = 5.e5;
%yf = 6.e5;
%ylim([y0,yf]) 
%set(gca,'ytick',[y0:0.1e5:yf])
 
 
x0 = 120-50;
xf = 120+50;
xlim([x0 xf]) 
set(gca,'xtick',[x0:10:xf])

legend_handle = legend(lg1,lg3,lg2);
set(legend_handle, 'Box', 'off','Location',legendposition2)

xlabel(eixo1,'FontSize',s)
ylabel(eixoMw,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
print('-dtiff','-r600','Mw.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(5) 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
%plot(tf,cisexp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
errorbar(tf,cisexp,Errocis,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
hold on
plot(tf,cisI,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
plot(tf,cis,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
plot(tf,cisS,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 

y0 = 90;
yf = 100;
ylim([y0,yf]) 
set(gca,'ytick',[y0:2:yf])
 
x0 = 120-50;
xf = 120+50;
xlim([x0 xf]) 
set(gca,'xtick',[x0:10:xf])

legend_handle = legend(lg1,lg3,lg2);
set(legend_handle, 'Box', 'off','Location',legendposition3)

xlabel(eixo1,'FontSize',s)
ylabel(eixocis,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
print('-dtiff','-r600','cis.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(6) 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
%plot(tf,cisexp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
errorbar(tf,transexp,Errocis,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
hold on
plot(tf,transI,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
plot(tf,trans,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
plot(tf,transS,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 

y0 = 0.00;
yf = 5.0;
ylim([y0,yf]) 
set(gca,'ytick',[y0:1.:yf])
 
x0 = 120-50;
xf = 120+50;
xlim([x0 xf]) 
set(gca,'xtick',[x0:10:xf])

legend_handle = legend(lg1,lg3,lg2);
set(legend_handle, 'Box', 'off','Location',legendposition2)

xlabel(eixo1,'FontSize',s)
ylabel(eixotrans,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
print('-dtiff','-r600','trans.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
 
% plot(t,Pexp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
errorbar(t,Pexp,Perr,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
hold on
plot(xi,yiIP,type3,'LineWidth', ss);
plot(t,Pm,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
plot(xi,yiSP,type3,'LineWidth', ss);

y0 = 0.00;
yf = 5.0;
ylim([y0,yf]) 
set(gca,'ytick',[y0:1.:yf])
 
x0 = 0;
xf = 100;
xlim([x0 xf]) 
set(gca,'xtick',[x0:20:xf])

legend_handle = legend(lg1,lg2);
set(legend_handle, 'Box', 'off','Location',legendposition1)

xlabel(eixo1,'FontSize',s)
ylabel(eixoP,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','Pres.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%