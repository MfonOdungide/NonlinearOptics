%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%         ODUNGIDE, MFON         %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%             8489771            %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%         Al(x)Ga As(1-x)        %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%      EFFICIENCY OF AlGaAs      %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%           18 NOV 2018          %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&%%%%%
%% Program to compute the efficiency of AlGaAs using 
% signal peak, Pump Peak, Pump base, Signal Base, 
% Idler peak, and Idler base
% 
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%clearing variables

clear all
clc;
%% Data Import variables


prompt = input('Input Waveguide: [REF3, W0.9, W0.6] ', 's');
waveguide = prompt;
sDevice = 'Strand';
Data_label = [num2str(sDevice),'_', num2str(waveguide),'_',];
prompt = input('Input Signal Wavelength ');
SignalWavelength = prompt;
output_line = '========================================================================================';
prompt = input('Input Pump Wavelength ');
PumpWavelength = prompt;
disp(output_line)
st = prompt;
sn = 1;

%% Signal Input Only
SignalInput_str = ['Signal_Input _', num2str(SignalWavelength),'.lvm'];
SignalInput_Data =importdata(SignalInput_str);
SignalInput_lambda = SignalInput_Data(:,2);
SignalInput_power = SignalInput_Data(:,3);
[signalpks,signallocs]=findpeaks(SignalInput_power,SignalInput_lambda);
plot(SignalInput_lambda, SignalInput_power), grid
findpeaks(SignalInput_power,SignalInput_lambda,'MinPeakDistance',15)
text(signallocs+.02,signalpks,num2str((1:numel(signalpks))')) % anotate the graph with numbers
xlabel('\lambda (nm)'), ylabel('[Power dBm]')
SignalPeakTable=[signalpks signallocs];

% Signal Peak
prompt = 'Input Signal peak reference label ' ;
signallabel = input(prompt);
signalpeak = SignalPeakTable(signallabel,1);
signallambda = SignalPeakTable(signallabel,2);

%Signal Base
signalbase = SignalInput_Data(1,3);

%%
for k = st:5:1540
DataLine = ['Data for Pump Wavelength @ ',num2str(PumpWavelength),'nm'];
disp(DataLine)
IdlerWavelength = round(1240/(2*(1240/PumpWavelength)-(1240/SignalWavelength)));

FWM_str = [num2str(Data_label),'FWM_', num2str(PumpWavelength), '(', num2str(SignalWavelength),'_', num2str(IdlerWavelength),').lvm'];
% disp(FWM_str)c
SignalOnly_str = [num2str(Data_label),'S_', num2str(PumpWavelength), '(', num2str(SignalWavelength),'_', num2str(IdlerWavelength),').lvm'];
PumpOnly_str = [num2str(Data_label),'P_', num2str(PumpWavelength), '(', num2str(SignalWavelength),'_', num2str(IdlerWavelength),').lvm'];
%% Import Data
FWM_Data=importdata(FWM_str);
Signal_Data =importdata(SignalOnly_str);
Pump_Data =importdata(PumpOnly_str);

%% Declaring variables
lambda = FWM_Data(:,2);
power = FWM_Data(:,3);
power_signalonly = Signal_Data(:,3);
lambda_signalonly = Signal_Data(:,2);
power_pumponly = Pump_Data(:,3);
lambda_pumponly = Pump_Data(:,2);
[pks,locs]=findpeaks(power,lambda);
plot(lambda, power), grid
findpeaks(power,lambda,'MinPeakDistance',15)
text(locs+.02,pks,num2str((1:numel(pks))')) % anotate the graph with numbers

%% Print Plot
xlabel('\lambda (nm)'), ylabel('[Power dBm]')
PeakTable=[pks locs];
%% Peaks
% idler Peak
disp(output_line)
prompt = 'Input Idler peak reference label ';
idlerlabel = input(prompt);
if idlerlabel == 0
    prompt = 'Input Idler Peak wavelength ';
    idlerlambda = input(prompt);   
    prompt = 'Input Idler Peak Power ';
    idlerpeak = input(prompt);  

else
    idlerpeak = PeakTable(idlerlabel,1);
    idlerlambda = PeakTable(idlerlabel,2); 
end


% % Pump Peak
% prompt = 'Input Pump peak reference label ' ;
% pumplabel = input(prompt);
% pumppeak = PeakTable(pumplabel,1);
% pumplambda = PeakTable(pumplabel,2);

% % Signal Peak
% prompt = 'Input Signal peak reference label ' ;
% signallabel = input(prompt);
% signalpeak = PeakTable(signallabel,1);
% signallambda = PeakTable(signallabel,2);



%% Bases
pumpbase = Pump_Data(1,3);

%% at idler
signal_at_idler =  power_signalonly(lambda_signalonly == idlerlambda);
pump_at_idler =  power_pumponly(lambda_pumponly == idlerlambda);

%% Efficiency
idlerbase = 10*log10(10.^(pump_at_idler/10)+10.^(signal_at_idler/10));
Pidler = idlerpeak-idlerbase;
Psignal = signalpeak-signalbase;
Efficiency = Pidler - Psignal;

%% Data Output
% DataTable_Out(sn,:) = [idlerpeak idlerlambda idlerbase Pidler signalpeak signalbase Psignal pump_at_idler signal_at_idler Efficiency];
Data_Output(sn,:) = [PumpWavelength idlerpeak idlerlambda signalpeak signalbase pump_at_idler signal_at_idler Efficiency];

sn =sn +1;
PumpWavelength = PumpWavelength + 5;
% prompt = input('Continue Y/N', 's');
% cnt = prompt;
%     if cnt == "N"
%         break
%     elseif cnt == "Y"
%        
%     end
disp(output_line);

end