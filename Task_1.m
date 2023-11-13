%% Camden Miller
% Networking Engineering 
% LAN Reliability Project

%Clear
clc;
clear;
close all;

% Task 1
% Parameters
%  K - the number of packets in the application message
%  p - the probability of failure 
%  N - the number of simulations to run

K_range = [1, 5, 15, 50, 100];
N = 1000; 

%Set range before then setting p = p_range
p_range = linspace(0.01, 0.99, 100);

%Start sim
%Run through the entire range of k values
for k = 1:length(K_range)
    K = K_range(k);
    
    % Create arrays for both sim and calculated results 
    calculatedResults = zeros(size(p_range));
    simulatedResults = zeros(size(p_range));
    
    % Sim and Calc for p value(s)
    for i = 1:length(p_range) % i = placeholder to run for the entire p_range
        p = p_range(i);
        
        %Gather Calc/Sim results 
        calculatedResults(i) = K / (1 - p); % Formula for calculated results 
        simulatedResults(i) = runSingleLinkSim(K, p, N); %Call runSingleLink to gather sim data
    end
  
    % Now that all simulated and calculated results are stored, I need
    % to generate a plot for each K value (1, 5, 15, 50, 100)
    
    figure;
    plot(p_range, calculatedResults, 'k', 'LineWidth', 1); %Create black line for my calculated results 
    hold on;
    plot(p_range, simulatedResults, 'o', 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'none'); %Create red circle at every simulation point
    % I had to make this plot consist points instead of a solid line since they
    % overlay so closely 
    
    %When observing the generated plot, my calculated results will be
    %displayed in a black line while my simulated results will be shown via
    %a series of red circles. If my Calc results and my Sim results are
    %both accurate, my epected plot is an exponental curve with red circles
    %along the line
    
    title(['(Log Scale) K = ' num2str(K)]); %Add the appropriate K value to its corresponding plot
    xlabel('Probability (%)');
    ylabel('Transmissions (#)');
    set(gca, 'YScale', 'log');
    grid on;
    
    %Add Key 
    legend('Calculated', 'Simulated');
    hold off;
    
    % Create array for future combined plot
    allSimulatedResults{k} = simulatedResults;
    
end

% Plot all K values
figure;
hold on;
for k_index = 1:length(K_range)
    K = K_range(k_index);
    simulatedResults = allSimulatedResults{k_index};
    plot(p_range, simulatedResults, 'o-', 'DisplayName', ['K = ', num2str(K)]);
end
title('Results of All K Values (Log Scale)');
xlabel('Probability (%)');
ylabel('Transmissions (#)');
%Scale
legend('Location', 'Best');
set(gca, 'YScale', 'log');
hold off;

