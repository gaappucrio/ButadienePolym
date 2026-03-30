    clear all
    clc
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 eixox2 = 'Chain length (r)';
 eixox1 = 'Log(MW)';
 
 eixoy1 = 'f(r)';
 eixoy2 = 'w_{MW}';
 eixoy3 = 'w_{log(MW)}';
 eixoy4 = 'LCB/chain';
 eixoy5 = 'Log{(LCB/chain)}';
 %eixoy5 = 'log{(RCL/cadeia)}';

 lg1 = 'Dead'; 
 lg2 = 'Living';
 lg3 = 'Overall';
 lg4 = 'LCB/chain';
 
 f = 15;
 s = 15; 
 lw = 1.5;
 
 size1 = 4; %type1 
 size2 = 4; %type2
 size3 = 4; % type3
 
  
 type1 = '--r*';
 type2 = '-bv';
 type3 = 'bo';
 type4 = 'rh';
 type5 = '-.ko';
 
 color_dado1 = 'red';
 color_dado2 = 'blue';
 color_dado3 = 'blue';
 color_dado4 = 'red';
 color_dado5 = 'black';

 legendposition1 = 'NorthEast';
 legendposition2 = 'NorthWest';

 MCfile = 'DTM2.txt';

width = 5;      % inches
height = 4;     %inches
pp = 3.0;
MM = 54.09;
n = 250000;
delta = 10;

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                  LEITURA DOS DADOS DOS ARQUIVOS.TXT                    %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen(MCfile,'r');         % Lendo o arquivo
A = fscanf(fid,'%f',[2,n]);         % [coluna,linhas]  
B = A';                             % [linhas,colunas]  

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                              ESPECIFICACOES                            %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 r          = B(:,1);
 D          = B(:,2); %B Bifuncional
 
nn = n/delta;

'MC molecular weight'

Mw = sum(r(:).*r(:).*(D(:)))/sum(r(:).*(D(:)));
Mn = sum(r(:).*(D(:)))/sum(D(:));
Mw = Mw*MM
Mn = Mn*MM
PDI = Mw/Mn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tamD = zeros(nn,1);
hist = zeros(nn,1);

bg = 1;
fim = delta;
for i = 1:nn
    for j = bg:fim
        tamD(i) = tamD(i) + D(j); 
    end
    bg = bg + delta;
    fim = fim + delta;
end
 
for i = 1:nn
    hist(i) = i*delta - delta/2.e0;  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(10)
plot(hist,tamD)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% MULTIFUNCIONAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
logB = zeros(nn,1);
iiB  = zeros(nn,1);

for i = 1:nn
    logB(i) = log10(hist(i)*MM);  
end
iiB = hist.*hist.*tamD;  %i2Pi

soma = 0.e0;
for i = 1:length(hist)-1
    soma = soma + (logB(i+1)-logB(i))*(iiB(i+1)+iiB(i))/2.e0;
end
iiB(:) = iiB(:)./soma;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              PLOTS                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
 
plot(logB,iiB,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3);
hold on

legend_handle = legend('Dead chains');
set(legend_handle, 'Box', 'off','Location',legendposition1)

%  ylim([0,1.0]) 
%  set(gca,'ytick',[0:0.1:1.0])
%  
%  xlim([2 8]) 
%  set(gca,'xtick',[2:0.5:8])

 xlabel(eixox1,'FontSize',s)
 ylabel(eixoy3,'FontSize',s)
%  grid on

 set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

 print('-dtiff','-r600','MWD_Simul1.tiff') % -djpg, -dpng
 hold off
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Suavizar as curvas inferior e superior
x0 = 2.20;
xf = 7;
x = logB;
xi = x0:0.05:xf;
y = iiB;
yi = spline(x,y,xi);


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
 
plot(xi,yi,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3);
hold on

legend_handle = legend('Dead chains');
set(legend_handle, 'Box', 'off','Location',legendposition1)

 ylim([0 1.4]) 
 set(gca,'ytick',[0:0.2:1.4])
 
 xlim([1.0 6]) 
 set(gca,'xtick',[1.0:1:6])


 xlabel(eixox1,'FontSize',s)
 ylabel(eixoy3,'FontSize',s)
%  grid on

 set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

 print('-dtiff','-r600','MWD_Simul2.tiff') % -djpg, -dpng
 hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m = 5000;
 fid = fopen('MWDexp.dat','r');         % Lendo o arquivo
A = fscanf(fid,'%f',[2,m]);         % [coluna,linhas]  
B = A';                             % [linhas,colunas]  

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                              ESPECIFICACOES                            %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 rexptemp       = B(:,2);
 logDtemp       = B(:,1); %B Bifuncional
 
 rexp = zeros(length(rexptemp),1);
 logD = zeros(length(rexptemp),1);
 
 rexp(1) = rexptemp(end);
 logD(1) = logDtemp(end);  
 
 for i = 2:length(rexptemp)-1
    rexp(i) = rexptemp(end-i+1);
    logD(i) = logDtemp(end-i+1);
 end
 
 rexp(end) = rexptemp(end);
 logD(end) = logDtemp(end);  
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
logE2 = zeros(length(rexptemp),1);

for i = 1:length(rexptemp)
    logE2(i) = log10(rexp(i));  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% MULTIFUNCIONAL

soma = 0.e0;
for i = 1:length(rexptemp)-1
    soma = soma + (logE2(i+1)-logE2(i))*(logD(i+1)+logD(i))/2.e0
end
logD(:) = logD(:)./soma

soma = 0.e0;
for i = 1:length(rexptemp)-1
    soma = soma + (logE2(i+1)-logE2(i))*(logD(i+1)+logD(i))/2.e0;
end
soma
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
 
plot(logE2,logD,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3);
hold on

legend_handle = legend('Dead chains');
set(legend_handle, 'Box', 'off','Location',legendposition1)

 ylim([0,1.1]) 
 set(gca,'ytick',[0:0.1:1.1])
%  
%  xlim([5e3 5e7]) 
%  set(gca,'xtick',[5e3:1e6:1e7])

 xlabel(eixox1,'FontSize',s)
 ylabel(eixoy3,'FontSize',s)
%  grid on

 set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

 print('-dtiff','-r600','MWD_real.tiff') % -djpg, -dpng
 hold off 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
 
plot(logE2,logD,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3);
%plot(rexp,logD,type1,'MarkerFaceColor',color_dado1,'MarkerSize',size3);
hold on
plot(xi,yi,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3);
%plot(logB,iiB,type2,'MarkerFaceColor',color_dado2,'MarkerSize',size3);

legend_handle = legend('MWD exp', 'MWD predicted (24 h)');
set(legend_handle, 'Box', 'off','Location',legendposition1)

 ylim([0,2]) 
 set(gca,'ytick',[0:0.5:2])
 
 xlim([1 7]) 
 set(gca,'xtick',[1:1:7])

 xlabel(eixox1,'FontSize',s)
 ylabel(eixoy3,'FontSize',s)
%  grid on

 set(h,'LineWidth',lw) % Definir a espessura das bordas do grafico

 print('-dtiff','-r600','MWD_both.tiff') % -djpg, -dpng
 hold off 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
