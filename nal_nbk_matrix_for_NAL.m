function [GA, EA, JA] = nal_nbk_matrix_for_NAL(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax :- [GA,EA, JA] = nal_nbk_matrix_for_NAL(cktnetlist)
%
% This function will return Conductance Matrix (GA), Voltage Matrix (EA) and 
% Current Matrix (JA) for network NAL i.e. graph Gx(AUL).
% --------------------------------------------------------------------------------

% ----------------------------- written on : Mar 13, 2018 ------------------------- 

     nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist) ;
     dimension_of_matrix = max(find(nal_nbk_A_and_B_part)); % this is working fine for only this type of model but if we are having disconnected model then it won't work 
     % keeping same as of now
     GA = zeros(dimension_of_matrix);
     EA  = zeros(dimension_of_matrix,1);
     JA  = zeros(dimension_of_matrix,1);
     max_iter = length(GA); 
     for i = 1:max_iter
         if (strcmp(cktnetlist.elements{i}.name(1),'R'))
             resistance_value = cell2mat(cktnetlist.elements{i}.parms);
             GA(i,i) = 1/resistance_value;
         end

        if (strcmp(cktnetlist.elements{i}.name(1),'V'))
            voltage_souce_value = cktnetlist.elements{i}.udata{1}.QSSval;
            EA(i) = voltage_souce_value;
        end

        if (strcmp(cktnetlist.elements{i}.name(1),'I'))
            current_souce_value = cktnetlist.elements{i}.udata{1}.QSSval;
            JA(i) = current_souce_value;
        end
     end
end
