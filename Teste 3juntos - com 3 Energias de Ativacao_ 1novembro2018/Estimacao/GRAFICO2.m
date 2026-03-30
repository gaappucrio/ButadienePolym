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
n = 87;
fid = fopen(RCfile,'r');         % Lendo o arquivo
A = fscanf(fid,'%f',[12,n]);         % [coluna,linhas]  
B = A';   % [linhas,colunas]  
pp = 0.2; % erros de predicao de Mn de 60, Mn de 70 e Mw de 70
pp2 = 0.32; % erro de predicao de Mw de 60
n1 = 25;
% 60 C
t            = B(1:n1,2); 
Texp         = B(1:n1,3) - 273.15e0; 
Tm           = B(1:n1,4) - 273.15e0;
TmI          = B(1:n1,5) - 273.15e0;
TmS          = B(1:n1,6) - 273.15e0;
Terr         = B(1:n1,7); 

Pexp         = B(1:n1,8); 
Pm           = B(1:n1,9);
PmI          = B(1:n1,10);
PmS          = B(1:n1,11);
Perr         = B(1:n1,12);

tf            = t(end);
cisexp        = B(n1+1,3)*100;
cis           = B(n1+1,4)*100;
cisI          = B(n1+1,5)*100;
cisS          = B(n1+1,6)*100;
Errocis       = B(n1+1,7)*100

transexp       = B(n1+2,3)*100;
trans          = B(n1+2,4)*100;
transI         = B(n1+2,5)*100;
transS         = B(n1+2,6)*100;
Errotrans      = B(n1+2,7)*100

Mnexp        = B(n1+3,3);
Mn           = B(n1+3,4);
MnI          = Mn - pp*Mn; %B(n1+3,5);
MnS          = Mn + pp*Mn; %B(n1+3,6);
ErroMn       = B(n1+3,7);

Mwexp        = B(n1+4,3);
Mw           = B(n1+4,4)
MwI          = Mw - pp2*Mw %B(n1+4,5);
MwS          = Mw + pp2*Mw %B(n1+4,6); 
ErroMw       = B(n1+4,7);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n2 = 54;
n1 = 30;

% 70 C
t7            = B(n1:n2,2); 
Texp7         = B(n1:n2,3) - 273.15e0; 
Tm7           = B(n1:n2,4) - 273.15e0;
TmI7          = B(n1:n2,5) - 273.15e0;
TmS7          = B(n1:n2,6) - 273.15e0;
Terr7         = B(n1:n2,7); 

Pexp7         = B(n1:n2,8); 
Pm7           = B(n1:n2,9);
PmI7         = B(n1:n2,10);
PmS7          = B(n1:n2,11);
Perr7         = B(n1:n2,12);

tf7            = t7(end);
cisexp7        = B(n2+1,3)*100;
cis7           = B(n2+1,4)*100;
cisI7          = B(n2+1,5)*100;
cisS7          = B(n2+1,6)*100;
Errocis7       = B(n2+1,7)*100;

transexp7       = B(n2+2,3)*100;
trans7          = B(n2+2,4)*100;
transI7         = B(n2+2,5)*100;
transS7         = B(n2+2,6)*100
Errotrans7      = B(n2+2,7)*100

Mnexp7        = B(n2+3,3);
Mn7           = B(n2+3,4);
MnI7          = Mn7 - pp*Mn7; %B(n2+3,5);
MnS7          = Mn7 + pp*Mn7; %B(n2+3,6);
ErroMn7       = B(n2+3,7);

Mwexp7        = B(n2+4,3);
Mw7           = B(n2+4,4);
MwI7          = Mw7 - pp*Mw7; %B(n2+4,5);
MwS7          = Mw7 + pp*Mw7; %B(n2+4,6); 
ErroMw7       = B(n2+4,7);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n2 =83;
n1 =59;

% 80 C
t8            = B(n1:n2,2); 
Texp8         = B(n1:n2,3) - 273.15e0; 
Tm8           = B(n1:n2,4) - 273.15e0;
TmI8          = B(n1:n2,5) - 273.15e0;
TmS8          = B(n1:n2,6) - 273.15e0;
Terr8         = B(n1:n2,7); 

Pexp8         = B(n1:n2,8); 
Pm8           = B(n1:n2,9);
PmI8        = B(n1:n2,10);
PmS8          = B(n1:n2,11);
Perr8         = B(n1:n2,12);

tf8            = t8(end);
cisexp8        = B(n2+1,3)*100;
cis8           = B(n2+1,4)*100;
cisI8          = B(n2+1,5)*100;
cisS8          = B(n2+1,6)*100;
Errocis8       = B(n2+1,7)*100

transexp8       = B(n2+2,3)*100;
trans8          = B(n2+2,4)*100;
transI8         = B(n2+2,5)*100;
transS8         = B(n2+2,6)*100;
Errotrans8      = B(n2+2,7)*100

Mnexp8        = B(n2+3,3);
Mn8           = B(n2+3,4);
MnI8          = B(n2+3,5);
MnS8          = B(n2+3,6);
ErroMn8       = B(n2+3,7);

Mwexp8        = B(n2+4,3);
Mw8           = B(n2+4,4);
MwI8          = B(n2+4,5);
MwS8          = B(n2+4,6); 
ErroMw8       = B(n2+4,7);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pos = length(Pm);
Pm2 = zeros(pos,1);
% rm = 17;  % Estou robando assim =(
% Pm2(1:rm) = Pexp(1:rm);
% Pm2(rm+1:end) = Pm(rm+1:end);

% Pm2(1:pos-rm) = Pm(rm+1:end);
% Pm2(pos-rm+1:end) = Pm(end);



% ErroMn = (Mnexp*0.01d0); 
% ErroMw = (Mwexp*0.01d0); 
% Errocis = 0.5; %sqrt(cis*0.002d0); 
% Errotrans = 0.5; %sqrt(cis*0.002d0); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

width = 5;      % inches
height = 4;     %inches
pp = 1.0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Suavizar as curvas inferior e superior
% x0 = 0;
% xf = 90;
% x = t;
% xi = x0:1:xf;
% yS = TmS;
% yiS = spline(x,yS,xi);
% yI = TmI;
% yiI = spline(x,yI,xi);
% 
% ySP = PmS;
% yiSP = spline(x,ySP,xi);
% yIP = PmI;
% yiIP = spline(x,yIP,xi);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(1) 
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits','inches');
% papersize = get(gcf,'PaperSize');
% left = (papersize(1)-width)/2;
% bottom = (papersize(2)-height)/2;
% myfiguresize = [left,bottom,width,height];
% set(gcf,'PaperPosition',myfiguresize);
% h = axes('FontSize',f); 
%  
% %plot(t,Texp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
% errorbar(t,Texp,Terr,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
% hold on
% plot(xi,yiI,type3,'LineWidth', ss);
% plot(t,Tm,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
% plot(xi,yiS,type3,'LineWidth', ss);
% 
% y0 = 50;
% yf = 100;
% ylim([y0,yf]) 
% set(gca,'ytick',[y0:10:yf])
%  
% x0 = 0;
% xf = 100;
% xlim([x0 xf]) 
% set(gca,'xtick',[x0:20:xf])
% 
% legend_handle = legend(lg1,lg2);
% set(legend_handle, 'Box', 'off','Location',legendposition1)
% title('60 C')
% xlabel(eixo1,'FontSize',s)
% ylabel(eixo2,'FontSize',s)
% 
% set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
% 
% print('-dtiff','-r600','Temp.tiff') % -djpg, -dpng
% hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(2) 
% 
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits','inches');
% papersize = get(gcf,'PaperSize');
% left = (papersize(1)-width)/2;
% bottom = (papersize(2)-height)/2;
% myfiguresize = [left,bottom,width,height];
% set(gcf,'PaperPosition',myfiguresize);
% h = axes('FontSize',f); 
%  
% % plot(tf,Mnexp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
% errorbar(tf,Mnexp,ErroMn,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
% hold on
% plot(tf,MnI,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
% plot(tf,Mn,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
% plot(tf,MnS,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
% 
% y0 = 1.0e4;
% yf = 10.0e4;
% ylim([y0,yf]) 
% set(gca,'ytick',[y0:2.e4:yf])
%  
% x0 = 0;
% xf = 100;
% xlim([x0 xf]) 
% set(gca,'xtick',[x0:20:xf])
% 
% legend_handle = legend(lg1,lg3,lg2);
% set(legend_handle, 'Box', 'off','Location',legendposition2)
% title('60 C')
% 
% xlabel(eixo1,'FontSize',s)
% ylabel(eixoMn,'FontSize',s)
% 
% set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
% print('-dtiff','-r600','Mn.tiff') % -djpg, -dpng
% hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(4) 
% 
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits','inches');
% papersize = get(gcf,'PaperSize');
% left = (papersize(1)-width)/2;
% bottom = (papersize(2)-height)/2;
% myfiguresize = [left,bottom,width,height];
% set(gcf,'PaperPosition',myfiguresize);
% h = axes('FontSize',f); 
%  title('60 C')
% 
% % plot(tf,Mwexp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
% errorbar(tf,Mwexp,ErroMw,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
% hold on
% plot(tf,MwI,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
% plot(tf,Mw,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
% plot(tf,MwS,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
% 
% y0 = 1.e5;
% yf = 8.e5;
% ylim([y0,yf]) 
% set(gca,'ytick',[y0:1.e5:yf])
%  
%  
% x0 = 0;
% xf = 100;
% xlim([x0 xf]) 
% set(gca,'xtick',[x0:20:xf])
% 
% legend_handle = legend(lg1,lg3,lg2);
% set(legend_handle, 'Box', 'off','Location',legendposition2)
% 
% xlabel(eixo1,'FontSize',s)
% ylabel(eixoMw,'FontSize',s)
% 
% set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
% print('-dtiff','-r600','Mw.tiff') % -djpg, -dpng
% hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
title('60 C')

legend_handle = legend(lg1,lg3,lg2);
set(legend_handle, 'Box', 'off','Location',legendposition3)

xlabel(eixo1,'FontSize',s)
ylabel(eixocis,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
print('-dtiff','-r600','cis.tiff') % -djpg, -dpng
hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
errorbar(tf,transexp,Errotrans,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
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
title('60 C')

legend_handle = legend(lg1,lg3,lg2);
set(legend_handle, 'Box', 'off','Location',legendposition2)

xlabel(eixo1,'FontSize',s)
ylabel(eixotrans,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
print('-dtiff','-r600','trans.tiff') % -djpg, -dpng
hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(7) 
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits','inches');
% papersize = get(gcf,'PaperSize');
% left = (papersize(1)-width)/2;
% bottom = (papersize(2)-height)/2;
% myfiguresize = [left,bottom,width,height];
% set(gcf,'PaperPosition',myfiguresize);
% h = axes('FontSize',f); 
%  
% % plot(t,Pexp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
% errorbar(t,Pexp,Perr,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
% hold on
% plot(xi,yiIP,type3,'LineWidth', ss);
% plot(t,Pm,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
% plot(xi,yiSP,type3,'LineWidth', ss);
% 
% y0 = 0;
% yf = 5;
% ylim([y0,yf]) 
% set(gca,'ytick',[y0:0.5:yf])
%  
% x0 = 0;
% xf = 100;
% xlim([x0 xf]) 
% set(gca,'xtick',[x0:20:xf])
% title('60 C')
% 
% legend_handle = legend(lg1,lg2);
% set(legend_handle, 'Box', 'off','Location',legendposition1)
% 
% xlabel(eixo1,'FontSize',s)
% ylabel(eixoP,'FontSize',s)
% 
% set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
% 
% print('-dtiff','-r600','Pres.tiff') % -djpg, -dpng
% hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%% 70 C
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % Suavizar as curvas inferior e superior
% x0 = 0;
% xf = 90;
% x = t7;
% xi = x0:1:xf;
% yS = TmS7;
% yiS = spline(x,yS,xi);
% yI = TmI7;
% yiI = spline(x,yI,xi);
% 
% ySP = PmS7;
% yiSP = spline(x,ySP,xi);
% yIP = PmI7;
% yiIP = spline(x,yIP,xi);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(8) 
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits','inches');
% papersize = get(gcf,'PaperSize');
% left = (papersize(1)-width)/2;
% bottom = (papersize(2)-height)/2;
% myfiguresize = [left,bottom,width,height];
% set(gcf,'PaperPosition',myfiguresize);
% h = axes('FontSize',f); 
%  
% %plot(t,Texp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
% errorbar(t7,Texp7,Terr7,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
% hold on
% plot(xi,yiI,type3,'LineWidth', ss);
% plot(t7,Tm7,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
% plot(xi,yiS,type3,'LineWidth', ss);
% 
% y0 = 50;
% yf = 100;
% ylim([y0,yf]) 
% set(gca,'ytick',[y0:10:yf])
%  
% x0 = 0;
% xf = 100;
% xlim([x0 xf]) 
% set(gca,'xtick',[x0:20:xf])
% title('70 C')
% 
% legend_handle = legend(lg1,lg2);
% set(legend_handle, 'Box', 'off','Location',legendposition1)
% 
% xlabel(eixo1,'FontSize',s)
% ylabel(eixo2,'FontSize',s)
% 
% set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
% 
% print('-dtiff','-r600','Temp70.tiff') % -djpg, -dpng
% hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(9) 
% 
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits','inches');
% papersize = get(gcf,'PaperSize');
% left = (papersize(1)-width)/2;
% bottom = (papersize(2)-height)/2;
% myfiguresize = [left,bottom,width,height];
% set(gcf,'PaperPosition',myfiguresize);
% h = axes('FontSize',f); 
%  
% % plot(tf,Mnexp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
% errorbar(tf7,Mnexp7,ErroMn7,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
% hold on
% plot(tf7,MnI7,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
% plot(tf7,Mn7,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
% plot(tf7,MnS7,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
% 
% y0 = 1.0e4;
% yf = 10.0e4;
% ylim([y0,yf]) 
% set(gca,'ytick',[y0:2.e4:yf])
%  
% x0 = 0;
% xf = 100;
% xlim([x0 xf]) 
% set(gca,'xtick',[x0:20:xf])
% 
% legend_handle = legend(lg1,lg3,lg2);
% set(legend_handle, 'Box', 'off','Location',legendposition2)
% title('70 C')
% 
% xlabel(eixo1,'FontSize',s)
% ylabel(eixoMn,'FontSize',s)
% 
% set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
% print('-dtiff','-r600','Mn70.tiff') % -djpg, -dpng
% hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(10) 
% 
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits','inches');
% papersize = get(gcf,'PaperSize');
% left = (papersize(1)-width)/2;
% bottom = (papersize(2)-height)/2;
% myfiguresize = [left,bottom,width,height];
% set(gcf,'PaperPosition',myfiguresize);
% h = axes('FontSize',f); 
%  
% % plot(tf,Mwexp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
% errorbar(tf7,Mwexp7,ErroMw7,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
% hold on
% plot(tf7,MwI7,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
% plot(tf7,Mw7,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
% plot(tf7,MwS7,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
% 
% y0 = 1.e5;
% yf = 8.e5;
% ylim([y0,yf]) 
% set(gca,'ytick',[y0:1.e5:yf])
%  
%  
% x0 = 0;
% xf = 100;
% xlim([x0 xf]) 
% set(gca,'xtick',[x0:20:xf])
% 
% legend_handle = legend(lg1,lg3,lg2);
% set(legend_handle, 'Box', 'off','Location',legendposition2)
% title('70 C')
% 
% xlabel(eixo1,'FontSize',s)
% ylabel(eixoMw,'FontSize',s)
% 
% set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
% print('-dtiff','-r600','Mw70.tiff') % -djpg, -dpng
% hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(11) 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
%plot(tf,cisexp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
errorbar(tf7,cisexp7,Errocis7,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
hold on
plot(tf7,cisI7,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
plot(tf7,cis7,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
plot(tf7,cisS7,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 

y0 = 90;
yf = 100;
ylim([y0,yf]) 
set(gca,'ytick',[y0:2:yf])
 
x0 = 120-50;
xf = 120+50;
xlim([x0 xf]) 
set(gca,'xtick',[x0:10:xf])
title('70 C')

legend_handle = legend(lg1,lg3,lg2);
set(legend_handle, 'Box', 'off','Location',legendposition3)

xlabel(eixo1,'FontSize',s)
ylabel(eixocis,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
print('-dtiff','-r600','cis70.tiff') % -djpg, -dpng
hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(12)
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
%plot(tf,cisexp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
errorbar(tf7,transexp7,Errotrans7,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
hold on
plot(tf7,transI7,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
plot(tf7,trans7,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
plot(tf7,transS7,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
title('70 C')

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
print('-dtiff','-r600','trans70.tiff') % -djpg, -dpng
hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(13) 
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits','inches');
% papersize = get(gcf,'PaperSize');
% left = (papersize(1)-width)/2;
% bottom = (papersize(2)-height)/2;
% myfiguresize = [left,bottom,width,height];
% set(gcf,'PaperPosition',myfiguresize);
% h = axes('FontSize',f); 
%  
% % plot(t,Pexp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
% errorbar(t7,Pexp7,Perr7,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
% hold on
% plot(xi,yiIP,type3,'LineWidth', ss);
% plot(t7,Pm7,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
% plot(xi,yiSP,type3,'LineWidth', ss);
% title('70 C')
% 
% y0 = 0;
% yf = 5;
% ylim([y0,yf]) 
% set(gca,'ytick',[y0:0.5:yf])
%  
% x0 = 0;
% xf = 100;
% xlim([x0 xf]) 
% set(gca,'xtick',[x0:20:xf])
% 
% legend_handle = legend(lg1,lg2);
% set(legend_handle, 'Box', 'off','Location',legendposition1)
% 
% xlabel(eixo1,'FontSize',s)
% ylabel(eixoP,'FontSize',s)
% 
% set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
% 
% print('-dtiff','-r600','Pres70.tiff') % -djpg, -dpng
% hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%% 80 C
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % Suavizar as curvas inferior e superior
% x0 = 0;
% xf = 60;
% x = t8;
% xi = x0:1:xf;
% yS = TmS8;
% yiS = spline(x,yS,xi);
% yI = TmI8;
% yiI = spline(x,yI,xi);
% 
% ySP = PmS8;
% yiSP = spline(x,ySP,xi);
% yIP = PmI8;
% yiIP = spline(x,yIP,xi);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(14) 
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits','inches');
% papersize = get(gcf,'PaperSize');
% left = (papersize(1)-width)/2;
% bottom = (papersize(2)-height)/2;
% myfiguresize = [left,bottom,width,height];
% set(gcf,'PaperPosition',myfiguresize);
% h = axes('FontSize',f); 
%  
% %plot(t,Texp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
% errorbar(t8,Texp8,Terr8,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
% hold on
% plot(xi,yiI,type3,'LineWidth', ss);
% plot(t8,Tm8,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
% plot(xi,yiS,type3,'LineWidth', ss);
% 
% y0 = 50;
% yf = 100;
% ylim([y0,yf]) 
% set(gca,'ytick',[y0:10:yf])
%  
% x0 = 0;
% xf = 100;
% xlim([x0 xf]) 
% set(gca,'xtick',[x0:20:xf])
% title('80 C')
% 
% legend_handle = legend(lg1,lg2);
% set(legend_handle, 'Box', 'off','Location',legendposition1)
% 
% xlabel(eixo1,'FontSize',s)
% ylabel(eixo2,'FontSize',s)
% 
% set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
% 
% print('-dtiff','-r600','Temp80.tiff') % -djpg, -dpng
% hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(15) 
% 
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits','inches');
% papersize = get(gcf,'PaperSize');
% left = (papersize(1)-width)/2;
% bottom = (papersize(2)-height)/2;
% myfiguresize = [left,bottom,width,height];
% set(gcf,'PaperPosition',myfiguresize);
% h = axes('FontSize',f); 
%  
% % plot(tf,Mnexp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
% errorbar(tf8,Mnexp8,ErroMn8,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
% hold on
% plot(tf8,MnI8,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
% plot(tf8,Mn8,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
% plot(tf8,MnS8,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
% 
% y0 = 1.0e4;
% yf = 10.0e4;
% ylim([y0,yf]) 
% set(gca,'ytick',[y0:2.e4:yf])
%  
% x0 = 0;
% xf = 100;
% xlim([x0 xf]) 
% set(gca,'xtick',[x0:20:xf])
% title('80 C')
% legend_handle = legend(lg1,lg3,lg2);
% set(legend_handle, 'Box', 'off','Location',legendposition2)
% 
% xlabel(eixo1,'FontSize',s)
% ylabel(eixoMn,'FontSize',s)
% 
% set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
% print('-dtiff','-r600','Mn80.tiff') % -djpg, -dpng
% hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(16) 
% 
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits','inches');
% papersize = get(gcf,'PaperSize');
% left = (papersize(1)-width)/2;
% bottom = (papersize(2)-height)/2;
% myfiguresize = [left,bottom,width,height];
% set(gcf,'PaperPosition',myfiguresize);
% h = axes('FontSize',f); 
%  
% % plot(tf,Mwexp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
% errorbar(tf8,Mwexp8,ErroMw8,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
% hold on
% plot(tf8,MwI8,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
% plot(tf8,Mw8,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
% plot(tf8,MwS8,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
% 
% y0 = 1.e5;
% yf = 8.e5;
% ylim([y0,yf]) 
% set(gca,'ytick',[y0:1.e5:yf])
%  
%  
% x0 = 0;
% xf = 100;
% xlim([x0 xf]) 
% set(gca,'xtick',[x0:20:xf])
% 
% legend_handle = legend(lg1,lg3,lg2);
% set(legend_handle, 'Box', 'off','Location',legendposition2)
% title('80 C')
% xlabel(eixo1,'FontSize',s)
% ylabel(eixoMw,'FontSize',s)
% 
% set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
% print('-dtiff','-r600','Mw80.tiff') % -djpg, -dpng
% hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(17) 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
%plot(tf,cisexp,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3,'LineWidth', ss0);
errorbar(tf8,cisexp8,Errocis8,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
hold on
plot(tf8,cisI8,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
plot(tf8,cis8,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
plot(tf8,cisS8,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
 
y0 = 90;
yf = 100;
ylim([y0,yf]) 
set(gca,'ytick',[y0:2:yf])
  
x0 = 40;
xf = 100;
xlim([x0 xf]) 
set(gca,'xtick',[x0:10:xf])
title('80 C')
legend_handle = legend(lg1,lg3,lg2);
set(legend_handle, 'Box', 'off','Location',legendposition3)

xlabel(eixo1,'FontSize',s)
ylabel(eixocis,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
print('-dtiff','-r600','cis80.tiff') % -djpg, -dpng
hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(18)
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
 
errorbar(tf8,transexp8,Errotrans8,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
hold on
plot(tf8,transI8,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 
plot(tf8,trans8,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
plot(tf8,transS8,type33,'MarkerFaceColor',color_dado3,'MarkerSize',size3,'LineWidth', ss); 

y0 = 0.00;
yf = 5.0;
ylim([y0,yf]) 
set(gca,'ytick',[y0:1.:yf])
 
x0 = 40;
xf = 100;
xlim([x0 xf]) 
set(gca,'xtick',[x0:10:xf])
title('80 C')
legend_handle = legend(lg1,lg3,lg2);
set(legend_handle, 'Box', 'off','Location',legendposition2)

xlabel(eixo1,'FontSize',s)
ylabel(eixotrans,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
print('-dtiff','-r600','trans80.tiff') % -djpg, -dpng
hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(19) 
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits','inches');
% papersize = get(gcf,'PaperSize');
% left = (papersize(1)-width)/2;
% bottom = (papersize(2)-height)/2;
% myfiguresize = [left,bottom,width,height];
% set(gcf,'PaperPosition',myfiguresize);
% h = axes('FontSize',f); 
%  
% errorbar(t8,Pexp8,Perr8,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp);   
% hold on
% plot(xi,yiIP,type3,'LineWidth', ss);
% plot(t8,Pm8,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
% plot(xi,yiSP,type3,'LineWidth', ss);
% 
% y0 = 0;
% yf = 5;
% ylim([y0,yf]) 
% set(gca,'ytick',[y0:0.5:yf])
%  
% x0 = 0;
% xf = 100;
% xlim([x0 xf]) 
% set(gca,'xtick',[x0:20:xf])
% title('80 C')
% legend_handle = legend(lg1,lg2);
% set(legend_handle, 'Box', 'off','Location',legendposition1)
% 
% xlabel(eixo1,'FontSize',s)
% ylabel(eixoP,'FontSize',s)
% 
% set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico
% 
% print('-dtiff','-r600','Pres80.tiff') % -djpg, -dpng
% hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Suavizar as curvas inferior e superior
% 60 C -------------------------------------------------------------------- 

x0 = 0;
xf = 90;
x = t;
xi6 = x0:1:xf;
yS = TmS;
yiS6 = spline(x,yS,xi6);
yI = TmI;
yiI6 = spline(x,yI,xi6);

% ySP = PmS;
% yiSP = spline(x,ySP,xi);
% yIP = PmI;
% yiIP = spline(x,yIP,xi);
% Suavizar as curvas inferior e superior

% 70 C -------------------------------------------------------------------- 

x0 = 0;
xf = 90;
x = t7;
xi7 = x0:1:xf;
yS = TmS7;
yiS7 = spline(x,yS,xi7);
yI = TmI7;
yiI7 = spline(x,yI,xi7);

% ySP = PmS7;
% yiSP = spline(x,ySP,xi);
% yIP = PmI7;
% yiIP = spline(x,yIP,xi);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 80 C -------------------------------------------------------------------- 

x0 = 0;
xf = 60;
x = t8;
xi8 = x0:1:xf;
yS = TmS8;
yiS8 = spline(x,yS,xi8);
yI = TmI8;
yiI8 = spline(x,yI,xi8);

% ySP = PmS8;
% yiSP = spline(x,ySP,xi);
% yIP = PmI8;
% yiIP = spline(x,yIP,xi);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
type1 = 'ko';
type1b = 'bo';
type1c = 'mo';
type2 = 'kv';
type3 = '-.r';
type4 = '-.rp';
type5 = '-.bh';
type6 = '-.k*';
type7 = '-.gs';
type8 = '-.gx';
type33 = '-.rh';

color_dado1 = 'blue';
color_dado1b = 'black';
color_dado1c = 'magenta';
color_dado2 = 'red';
color_dado3 = 'red';
color_dado4 = 'black';
color_dado5 = 'white';
color_dado6 = [0 .7 .7];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(20) 
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits','inches');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
h = axes('FontSize',f); 
% 60 C -------------------------------------------------------------------- 
errorbar(t,Texp,Terr,type1,'MarkerFaceColor',color_dado1b,'MarkerSize',size4,'LineWidth',pp,'MarkerEdgeColor','black');   
hold on
plot(xi6,yiI6,type3,'LineWidth', ss);
plot(t,Tm,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);

% 70 C -------------------------------------------------------------------- 
errorbar(t7,Texp7,Terr7,type1b,'MarkerFaceColor',color_dado1,'MarkerSize',size4,'LineWidth',pp,'MarkerEdgeColor','black');   
plot(xi7,yiI7,type3,'LineWidth', ss);
plot(t7,Tm7,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);
% 80 C -------------------------------------------------------------------- 
errorbar(t8,Texp8,Terr8,type1c,'MarkerFaceColor',color_dado1c,'MarkerSize',size4,'LineWidth',pp,'MarkerEdgeColor','black');   
plot(xi8,yiI8,type3,'LineWidth', ss);
plot(t8,Tm8,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3,'LineWidth', ss0);

plot(xi6,yiS6,type3,'LineWidth', ss);
plot(xi7,yiS7,type3,'LineWidth', ss);

plot(xi8,yiS8,type3,'LineWidth', ss);
%  -------------------------------------------------------------------- 

y0 = 50;
yf = 100;
ylim([y0,yf]) 
set(gca,'ytick',[y0:10:yf])
 
x0 = 0;
xf = 100;
xlim([x0 xf]) 
set(gca,'xtick',[x0:20:xf])

legend_handle = legend('ED (60C)','MCI (60C)','MP (60 C)','ED (70C)','MCI (70C)','MP (70 C)','ED (80C)','MCI (80C)','MP (80 C)');

set(legend_handle, 'Box', 'off','Location',legendposition1)
%title('60 C')
xlabel(eixo1,'FontSize',s)
ylabel(eixo2,'FontSize',s)

set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

print('-dtiff','-r600','Temp607080.tiff') % -djpg, -dpng
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%