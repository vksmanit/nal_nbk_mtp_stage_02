
function my_variable =  nal_nbk_test_02(cktnetlist)
   global edges_for_NBK;
  % global fundamental_circuit_edgeId;

   N = length (cktnetlist.nodenames) + 1;
   [edgeId_for_NBK,tree_brach_for_NBK, link_branch_for_NBK] = nal_nbk_edge_identity_of_NBK(cktnetlist);
   my_variable = cell(length(link_branch_for_NBK),1);
   for i = 1:length(link_branch_for_NBK)
       fundamental_circuit_edgeId = [];
       node_visited = zeros(N,1);
       [g1_of_NBK, edges_for_NBK] = nal_nbk_nodeInfo_with_edge_identity_of_NBK(cktnetlist);
       edge = cktnetlist.elements{link_branch_for_NBK(i)}.nodes;
       node1 = edge(1,1);
       node2 = edge(1,2);
       
       if (strcmp(node1, 'gnd'))
           node1 = N;
       else 
           node1 = str2num(cell2mat(node1));
       end

       if (strcmp(node2,'gnd'))
           node2 = N;
       else 
           node2 = str2num(cell2mat(node2));
       end
        g1_of_NBK{node1} = [g1_of_NBK{node1}, link_branch_for_NBK(i)];
        g1_of_NBK{node2} = [g1_of_NBK{node2}, link_branch_for_NBK(i)];

       start_node = str2num(cell2mat(edges_for_NBK(link_branch_for_NBK(i))));

       my_variable{i} = dfs_search_NBK(node_visited,start_node,start_node, g1_of_NBK,fundamental_circuit_edgeId);
   end

end

function a = dfs_search_NBK(node_visited, nodeId, initial_and_final_node, g1_of_NBK,fundamental_circuit_edgeId)
    
   global edges_for_NBK;
  % global fundamental_circuit_edgeId;

    if (~isempty(g1_of_NBK{nodeId}))
        node_visited(nodeId) = 1;
    end
    
    adjEdgeIdsOfCurrentNode = g1_of_NBK{nodeId};
    
    for edgeId = adjEdgeIdsOfCurrentNode
        %if (isempty(fundamental_circuit_edgeId))
        fundamental_circuit_edgeId = [fundamental_circuit_edgeId, edgeId] ;
        %end

        edge = edges_for_NBK(edgeId, :);
        otherNode = edge(1,2);

        if (strcmp(otherNode, 'gnd'))
            otherNode = length(node_visited);
        else 
            otherNode = str2num (cell2mat(edge(1,2)));
        end

        if otherNode == nodeId 
            otherNode = str2num(cell2mat(edge(1,1)));
            if (isempty(otherNode))
                otherNode = length(node_visited);
            end
        end
        
        % this will termintate the for loop if it is having fundamental circuit
        if otherNode == initial_and_final_node
            break;
        end

        
        if 1 == node_visited(otherNode)
            continue 
        end

        dfs_search_NBK(node_visited, otherNode, initial_and_final_node, g1_of_NBK,fundamental_circuit_edgeId);

    end

    a = unique(fundamental_circuit_edgeId);



end

