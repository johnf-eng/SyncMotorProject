function [Van_tot,Vbn_tot,Vcn_tot,T_A,T_B,T_C,T_SW] = SVM_Timing_and_Vph(sector,Vdc,Tsw,alpha,ratio)
%SVM_Timing_and_Vph takes in Space Vector Modulation parameters in order to calculate
%both the timing parameters and the phase voltages
    
%% Timing Calculations

    t_beta = Tsw*ratio*((sind(60-mod(alpha,60)))/sind(60));       % t_beta calculation from class
    t_gamma = Tsw*ratio*(sind(mod(alpha,60))/sind(60));           % t_gamma calculation from class
    t_alpha = (1/2)*(Tsw-t_beta-t_gamma);                      % t_alpha calculation done after t_beta and t_gamma to account for small periods
    t_delta = t_alpha;                                            % t_delta should equal t_alpha to simplify
    
    T_A = t_alpha;
    T_B = t_alpha+t_beta;
    T_C = t_alpha+t_beta+t_gamma;
    T_SW = t_alpha+t_beta+t_gamma+t_delta;

%% V phase Calculations

    V_first_state = zeros([3 1]);                   % Initializing temp variables
    V_second_state = zeros([3 1]);
    
    V1 = [2/3 -1/3 -1/3]*Vdc;                       % Phase voltage values (Van, Vbn, Vcn) by voltage vectors
    V2 = [1/3 1/3 -2/3]*Vdc;
    V3 = [-1/3 2/3 -1/3]*Vdc;
    V4 = [-2/3 1/3 1/3]*Vdc;
    V5 = [-1/3 -1/3 2/3]*Vdc;
    V6 = [1/3 -2/3 1/3]*Vdc;

    if (sector == 1)                                % Assigning bounding voltage for the sector
        V_first_state = V1; V_second_state = V2;
    elseif (sector == 2)
        V_first_state = V2; V_second_state = V3;
    elseif (sector == 3)
        V_first_state = V3; V_second_state = V4;
    elseif (sector == 4)
        V_first_state = V4; V_second_state = V5;
    elseif (sector == 5)
        V_first_state = V5; V_second_state = V6;
    elseif (sector == 6)
        V_first_state = V6; V_second_state = V1;
    end
    
    % Voltage phase calculations for t_beta period

    Van_t_beta = (t_beta/Tsw)*V_first_state(1);     % Multiplying phase voltage by proportion of period that it is active
    Vbn_t_beta = (t_beta/Tsw)*V_first_state(2);
    Vcn_t_beta = (t_beta/Tsw)*V_first_state(3);
    
    % Voltage phase calculations for t_gamma period
    
    Van_t_gamma = (t_gamma/Tsw)*V_second_state(1);
    Vbn_t_gamma = (t_gamma/Tsw)*V_second_state(2);
    Vcn_t_gamma = (t_gamma/Tsw)*V_second_state(3);
    
    % Total of weighted voltages based on period length. (zero switch
    % states considered in full period, but not shown, as they are 0 V)
    
    Van_tot = Van_t_beta + Van_t_gamma;
    Vbn_tot = Vbn_t_beta + Vbn_t_gamma;
    Vcn_tot = Vcn_t_beta + Vcn_t_gamma;
    
end

