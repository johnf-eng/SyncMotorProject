clear
clc

%% Initialization

Vdc = 600;
fe = 200;
Te = 1/fe;
fsw = 5000;
Tsw = 1/fsw;

V1 = [1 0 0];
V2 = [1 1 0];
V3 = [0 1 0];
V4 = [0 1 1];
V5 = [0 0 1];
V6 = [1 0 1];
V7 = [1 1 1];
V8 = [0 0 0];

%T1_signal =
%% Loop

for z = 0:(Tsw/(2*Te)):(2*Te)

sector = ceil(mod(alpha,720)/60);

switch sector
    case 1
        first_state = V7;
        second_state = V2;
        third_state = V1;
        fourth_state = V8;
    case 2
        first_state = V7;
        second_state = V2;
        third_state = V3;
        fourth_state = V8;
    case 3
        first_state = V7;
        second_state = V4;
        third_state = V3;
        fourth_state = V8;
    case 4
        first_state = V7;
        second_state = V4;
        third_state = V5;
        fourth_state = V8;
    case 5
        first_state = V7;
        second_state = V6;
        third_state = V5;
        fourth_state = V8;
    case 6
        first_state = V7;
        second_state = V6;
        third_state = V1;
        fourth_state = V8;
    case 7
        first_state = V8;
        second_state = V1;
        third_state = V2;
        fourth_state = V7;
    case 8
        first_state = V8;
        second_state = V3;
        third_state = V2;
        fourth_state = V7;
    case 9
        first_state = V8;
        second_state = V3;
        third_state = V4;
        fourth_state = V7;
    case 10
        first_state = V8;
        second_state = V5;
        third_state = V4;
        fourth_state = V7;
    case 11
        first_state = V8;
        second_state = V5;
        third_state = V6;
        fourth_state = V7;
    case 12
        first_state = V8;
        second_state = V1;
        third_state = V6;
        fourth_state = V7;
end

    t_beta = Tsw*ratio*((sind(60-mod(alpha,60)))/sind(60));       % t_beta calculation from class
    t_gamma = Tsw*ratio*(sind(mod(alpha,60))/sind(60));           % t_gamma calculation from class
    t_alpha = (1/2)*(Tsw-t_beta-t_gamma);                      % t_alpha calculation done after t_beta and t_gamma to account for small periods
    t_delta = t_alpha;                                            % t_delta should equal t_alpha to simplify
    
    T_A = t_alpha;
    T_B = t_alpha+t_beta;
    T_C = t_alpha+t_beta+t_gamma;
    %T_SW = t_alpha+t_beta+t_gamma+t_delta;

for x=0:100:Tsw
    T1_signal = zeros(1,100); T2_signal = zeros(1,100); T3_signal = zeros(1,100);
    if (x < T_A)
        T1_signal = first_state(1); T2_signal = first_state(2); T3_signal = first_state(3);
    elseif (x < T_B)
        T1_signal = second_state(1); T2_signal = second_state(2); T3_signal = second_state(3);
    elseif (x < T_C)
        T1_signal = third_state(1); T2_signal = third_state(2); T3_signal = third_state(3);
    else
        T1_signal = fourth_state(1); T2_signal = fourth_state(2); T3_signal = fourth_state(3);
    end
    
    T1(((sector-1)*100)+x) = T1_signal; 
    T2(((sector-1)*100)+x) = T2_signal; 
    T3(((sector-1)*100)+x) = T3_signal;
end
