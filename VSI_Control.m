function [T1,T2,T3] = VSI_Control(simTime,Vref,fsw,simEnd,alpha)
%VSI_CONTROL Summary of this function goes here
%   Detailed explanation goes here

Tsw = 1/fsw;                    % Switching period
%t_zero_min = 0.05*Tsw;          % Min time of zero switches T7 and T8
Vref_max = (1/sqrt(3))*Vdc;     % Maximum Voltage Amplitude for smooth Vref (346.4 V)
Vref = 0.8*Vref_max;            % Selected Vref(277.12 V)
ratio = abs(Vref)/((2/3)*Vdc);  % Ratio of Vref to Vdc
normalized_simTime = mod(simTime,Tsw);
ratio = abs(Vref)/((2/3)*Vdc);

V1 = [1 0 0];
V2 = [1 1 0];
V3 = [0 1 0];
V4 = [0 1 1];
V5 = [0 0 1];
V6 = [1 0 1];
V7 = [1 1 1];
V8 = [0 0 0];

for t=0:Tsw:simEnd
    
    %Calculate timing parameters
    normalized_alpha = mod(alpha,360);
    sector = ciel(mod(alpha,720)/60);
    normalized_simTime = mod(simTime,Tsw);
    t_beta = Tsw*ratio*((sind(60-mod(normalized_alpha,60)))/sind(60));       % t_beta calculation from class
    t_gamma = Tsw*ratio*(sind(mod(normalized_alpha,60))/sind(60));           % t_gamma calculation from class
    t_alpha = (1/2)*(Tsw-t_beta-t_gamma);                      % t_alpha calculation done after t_beta and t_gamma to account for small periods
    t_delta = t_alpha;                                            % t_delta should equal t_alpha to simplify
    
     T_A = t_alpha;
     T_B = t_alpha+t_beta;
     T_C = t_alpha+t_beta+t_gamma;
     T_SW = t_alpha+t_beta+t_gamma+t_delta;
    
    %assign V1 & V2 switch states
    
    if (sector == 1)                                % Assigning bounding voltage for the sector
        V_first_state = V7; V_second_state = V2; V_third_state = V1; V_fourth_state = V8;
    elseif (sector == 2)
        V_first_state = V7; V_second_state = V2; V_third_state = V3; V_fourth_state = V8;
    elseif (sector == 3)
        V_first_state = V7; V_second_state = V4; V_third_state = V3; V_fourth_state = V8;
    elseif (sector == 4)
        V_first_state = V7; V_second_state = V4; V_third_state = V5; V_fourth_state = V8;
    elseif (sector == 5)
        V_first_state = V7; V_second_state = V6; V_third_state = V5; V_fourth_state = V8;
    elseif (sector == 6)
        V_first_state = V7; V_second_state = V6; V_third_state = V1; V_fourth_state = V8;
    elseif (sector == 7)
        V_first_state = V8; V_second_state = V1; V_third_state = V2; V_fourth_state = V7;
    elseif (sector == 8)
        V_first_state = V8; V_second_state = V3; V_third_state = V2; V_fourth_state = V7;
    elseif (sector == 9)
        V_first_state = V8; V_second_state = V3; V_third_state = V4; V_fourth_state = V7;
    elseif (sector == 10)
        V_first_state = V8; V_second_state = V5; V_third_state = V4; V_fourth_state = V7;
    elseif (sector == 11)
        V_first_state = V8; V_second_state = V5; V_third_state = V6; V_fourth_state = V7;
    elseif (sector == 12)
        V_first_state = V8; V_second_state = V1; V_third_state = V6; V_fourth_state = V7;
    end
    
    %Using chart, assign t1,t2,t3,and t4
    
    while (normalized_simTime < T_A)
        T1 = V_first_state(1); T2 = V_first_state(2); T3 = V_first_state(3);
    end
    
    while (normalized_simTime < T_B)
        T1 = V_second_state(1); T2 = V_second_state(2); T3 = V_second_state(3);
    end
    
    while (normalized_simTime < T_C)
        T1 = V_third_state(1); T2 = V_third_state(2); T3 = V_third_state(3);
    end
    
    while (normalized_simTime < T_SW)
        T1 = V_fourth_state(1); T2 = V_fourth_state(2); T3 = V_fourth_state(3);
    end
    
end

end