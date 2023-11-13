%% Function runTwoParallelLinkSim()
% Parameters
%  K - the number of packets in the application message
%  p - the probability of failure 
%  N - the number of simulations to run
%
% Returns: the average numeric result across the total simulations

function result = runTwoParallelLinkSim(K, p, N)
    simResults = ones(1, N); % a place to store the result of each simulation
    
    for i = 1:N
        txAttemptCount = 0; % transmission count
        pktSuccessCount = 0; % number of packets that have made it across
    
        while pktSuccessCount < K
            r = rand; % generate random number for link 1
            r2 = rand; % generate random number for link 2
            txAttemptCount = txAttemptCount + 1; % count 1st attempt
            
            % Ensure the loop exits if either r or r2 is greater than or equal to p
            while r < p && r2 < p
                r = rand; % transmit again, generate new success check value r for link 1
                r2 = rand; % transmit again, generate new success check value r2 for link 2
                txAttemptCount = txAttemptCount + 1; % count additional attempt
            end
           
            pktSuccessCount = pktSuccessCount + 1; % increase success count after success (either r >= p or r2 >= p)
        end
        
        simResults(i) = txAttemptCount; % record the total number of attempted transmissions before the entire application message (K successful packets) is transmitted
    end

    result = mean(simResults);
end
