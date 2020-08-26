%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%         ODUNGIDE, MFON         %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%             8489771            %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%     In(1-x)Ga(x)As(y)P(1-y)    %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  REFRACTIVE INDEX AND BANDGAP  %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%      ENERGY/WAVELENGTH OF      %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%              InGaAsP            %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%           18 NOV 2018          %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&%%%%%
%% Program to compute the wavelength and Bandgap Energy of InGaAsP
% 
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%clearing variables
clear all;

%%
% Read excel Data on the same directory
%
dataset = xlsread('data.xlsx','InGaAsP_Dispersion_MATLAB','A4:AG64');
%%

% prompt = 'Input [0] for Refractive Index, [1] for Wavelength ';
% sel = input(prompt);
% if sel == 0
%     prompt = 'Input the Wavelength in nm of In(1-x)Ga(x)As(y)P(1-y)  ';
%     h = findobj(gca,'Type','line');
%     x=get(h,'Xdata');
%     y=get(h,'Ydata');    
%     xx = input(prompt); % Any value
%     yy = interp1(x, y, xx);
%     plot(yn,lambda,'DisplayName','lambdaeriment');
%     output_line = '========================================================================================';
%     disp(output_line)
%     disp(output)
%     fprintf(1, 'Energy Gap (eV) = %12.6g\n Composition = %12.6g\n Refractive Index = %12.6g\n Wavelength (nm) = %12.6g\n', E0, conc, yy, xx)
% elseif sel == 1
%     prompt = 'Input the Refractive Index In(1-x)Ga(x)As(y)P(1-y)  ';
%     h = findobj(gca,'Type','line');
%     y=get(h,'Xdata');
%     x=get(h,'Ydata') ;   
%     xx = input(prompt); % Any value
%     yy = interp1(x, y, xx);
    conc =1.0;
% end
for i = 1:1:11
    
As = 1-conc;
y = As*10;
s = 3; % step size
increment = s*y;
%%
ref_index = 3 + increment;
wavelength = 2 + increment;
yn = dataset(:,wavelength);
lambda = dataset(:,ref_index);
plot(yn,lambda,'DisplayName','lambdaeriment')

%% 
E0=1.35-(0.72*conc)+(0.12*conc*conc);
Eg = 1.06*(1240/E0); %lambda gap
CGa=0.1896*conc/(0.4176-0.0125*conc);
CIn=1-CGa;
CAs=conc;
CP=1-CAs;


    h = findobj(gca,'Type','line');
    x=get(h,'Xdata');
    y=get(h,'Ydata');    
    xx = Eg; % Any value
    yy = interp1(x, y, xx);
    plot(yn,lambda,'DisplayName','lambdaeriment');
%%
output = ['In(',num2str(CIn),')Ga(', num2str(CGa), ')As(', num2str(CAs),') P(', num2str(CP),')'];

output_line = '========================================================================================';
disp(output_line)
disp(output)
fprintf(1, ' Energy Gap (eV) = %12.6g\n Composition = %12.6g\n Refractive Index = %12.6g\n Wavelength (nm) = %12.6g\n', E0, conc, xx, yy)
 disp(output_line);
 tableout(As,:)=[E0 xx yy];
conc=conc+0.1;
end

%%