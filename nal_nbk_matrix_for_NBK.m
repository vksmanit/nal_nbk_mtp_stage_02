function [RB, EB, JB] = nal_nbk_matrix_for_NBK(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax :- [RB, EB, JB] = nal_nbk_matrix_for_NBK(cktnetlist)
% 
% This function will return the Resistance Matrix(RB), Voltage Matrix (VB) and 
% Current Matrix (JB) for network NBK i.e. G.(BUK)
% --------------------------------------------------------------------------------

     nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist) ;
     dimension_of_matrix = max(find(not(nal_nbk_A_and_B_part))) - min(find(not(nal_nbk_A_and_B_part))) + 1;
      % this is working fine for only this type of model but if we are having disconnected model then it won't work 
    %dimension_of_matrix = max(find(nal_nbk_A_and_B_part));
     RB = zeros(dimension_of_matrix);
     EB  = zeros(dimension_of_matrix,1);
     JB  = zeros(dimension_of_matrix,1);
     max_iter = length(RB); 
     index_for_matrix = 1;
     for i = min(find(not(nal_nbk_A_and_B_part))) : max(find(not(nal_nbk_A_and_B_part)))

         if (strcmp(cktnetlist.elements{i}.name(1),'R'))
             resistance_value = cell2mat(cktnetlist.elements{i}.parms);
             RB(index_for_matrix,index_for_matrix) = resistance_value;
         end

        if (strcmp(cktnetlist.elements{i}.name(1),'V'))
            voltage_souce_value = cktnetlist.elements{i}.udata{1}.QSSval;
            EB(index_for_matrix) = voltage_souce_value;
        end

        if (strcmp(cktnetlist.elements{i}.name(1),'I'))
            current_souce_value = cktnetlist.elements{i}.udata{1}.QSSval;
            JB(index_for_matrix) = current_souce_value;
        end
         index_for_matrix = index_for_matrix + 1; 
     end
end
