function [outputArg1,outputArg2] = VSI_Control(simTime,Vref,fsw,simEnd)
%VSI_CONTROL Summary of this function goes here
%   Detailed explanation goes here

Tsw = 1/fsw;                    % Switching period
t_zero_min = 0.05*Tsw;          % Min time of zero switches T7 and T8
Vref_max = (1/sqrt(3))*Vdc;     % Maximum Voltage Amplitude for smooth Vref (346.4 V)
Vref = 0.8*Vref_max;            % Selected Vref(277.12 V)
ratio = abs(Vref)/((2/3)*Vdc);  % Ratio of Vref to Vdc
x = 1;                          % Initializing variables


for 


end