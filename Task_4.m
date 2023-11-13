%% Camden Miller
% Networking Engineering 
% LAN Reliability Project

%Clear
clc;
clear;
close all;

% Task 4
% Parameters
%  K - the number of packets in the application message
%  p - the probability of failure 
%  N - the number of simulations to run

K_range = [1, 5, 15, 50, 100];
N = 1000; 

%Set range before then setting p = p_range
p_range = linspace(0.01, 0.99, 100);


% Looping through each K value
for k = 1:length(K_range)
    K = K_range(k);
    
    % Array for simulated results
    simulatedResults = zeros(size(p_range));
    
    % Calculate results for each p value
    for i = 1:length(p_range)
        p = p_range(i);
        simulatedResults(i) = runCompoundNetworkSim(K, p, N); % Simulated result
    end
    
    % Store simulated results in the preallocated cell array
    allSimulatedResults{k} = simulatedResults;
    
    % Plot individual figures for each K value
    figure;
    set(gca, 'YScale', 'log');
    hold on;
    plot(p_range, simulatedResults, 'o-', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'none'); % Simulated result
    title(['K = ' num2str(K)]);
    xlabel('Probability (p)');
    ylabel('Number of Transmissions');
    grid on;
    hold off;
    
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