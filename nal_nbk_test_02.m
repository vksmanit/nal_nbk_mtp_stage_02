function loop_matrix_for_NBK = nal_nbk_loop_matrix_for_NBK(cktnetlist)
% Syntax : loop_matrix_for_NBK = nal_nbk_loop_matrix_for_NBK(cktnetlist)

    fundamental_circuit_for_NBK = nal_nbk_fundamental_circuit_for_NBK(cktnetlist);
    [edgeId_for_NBK] = nal_nbk_edge_identity_of_NBK(cktnetlist);
    edgeId_for_NBK = unique(edgeId_for_NBK); % this needs modification when we deal with not rordered K branch 
    % how to put K branch as the initial column 
    rows =  length(fundamental_circuit_for_NBK);
    cols =  length(edgeId_for_NBK);
    loop_matrix_for_NBK = zeros (rows, cols);
    [g1_of_NBK, edges_for_NBK] = nal_nbk_nodeInfo_with_edge_identity_of_NBK(cktnetlist);
    N = length(cktnetlist.nodenames) + 1; 

    for i =1:rows
        %%%%%%%%%currentNode = edges_for_NBK
       my_temp_01 = length(fundamental_circuit_for_NBK{i});
       for k = 1:my_temp_01
           %for k = 1:length(fundamental_circuit_for_NBK{i})
           current_branch = fundamental_circuit_for_NBK{i}(my_temp_01 - k + 1);
           edge = edges_for_NBK(current_branch, :);
           otherNode = edge(1,2);
           if ( strcmp(otherNode, 'gnd'))
               otherNode = N;
           else 
               otherNode = str2num( cell2mat(edge(1,2)));
           end

         %  if otherNode == currentNode 
               %otherNode = str2num(cell2mat(edge(1,1)));
                %if (isempty(otherNode))
                    %otherNode = length(node_visited);
                %end
           %end

           if k == 1
               currentNode = otherNode;
               loop_matrix_for_NBK(i,fundamental_circuit_for_NBK{i}(my_temp_01 - k + 1)) = 1;
          % else 
              %if otherNode == currentNode 
                  %otherNode = str2num(cell2mat(edge(1,1)));
                  %if (isempty(otherNode))
                      %otherNode = N;
                  %end
              %end
           end

           if ( otherNode == currentNode & k~=1)
               loop_matrix_for_NBK(i,fundamental_circuit_for_NBK{i}(my_temp_01 - k + 1)) = 1;
           else
               loop_matrix_for_NBK(i,fundamental_circuit_for_NBK{i}(my_temp_01 - k + 1)) = -1;
               %loop_matrix_for_NBK(i,k) = -1;
           end

           currentNode = otherNode;


    end



end
