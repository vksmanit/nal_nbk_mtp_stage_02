function [fundamental_circuit_for_NBK] =  nal_nbk_fundamental_circuit_for_NBK(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : fundamental_circuit_for_NBK = nal_nbk_fundamental_circuit_for_NBK(cktnetlist)
%
% This function will return the fundamental circuit edgeId each corresponding with 
% a perticular link and in order. 
% The link brach informaiton can be get from function nal_nbk_edge_identity_of_NBK.
% --------------------------------------------------------------------------------

% --------------------------- written on : Mar 20, 2018 --------------------------
% This code is not able to get fundamental ciruit for nal_nbk_FPGA_ckt_01 in GNU-
% Octave. Hence it is modified to get fundamental_circuit_for_NBK in Octave.
% ---------------------------- Modified on : Apr 03, 2018 ------------------------
% 
   global edges_for_NBK;
   global fundamental_circuit_for_NBK;

   N = length (cktnetlist.nodenames) + 1;
   [edgeId_for_NBK,tree_brach_for_NBK, link_branch_for_NBK] = nal_nbk_edge_identity_of_NBK(cktnetlist);
   fundamental_circuit_for_NBK = cell(length(link_branch_for_NBK),1);
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
       dfs_search_NBK(i, start_node, link_branch_for_NBK(i), node_visited,start_node,start_node, g1_of_NBK,fundamental_circuit_edgeId);
   end

end

function  dfs_search_NBK(index, node_list, link_branch, node_visited, nodeId, initial_and_final_node, g1_of_NBK,fundamental_circuit_edgeId)
    
    global edges_for_NBK;
    global fundamental_circuit_for_NBK;
    global my_output;
    
    temp_cell =  [];

    if (~isempty(g1_of_NBK{nodeId}))
        node_visited(nodeId) = 1;
    end
    
    adjEdgeIdsOfCurrentNode = g1_of_NBK{nodeId};
    
    for edgeId = adjEdgeIdsOfCurrentNode
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
        g1_of_NBK_minus_edgeId = g1_of_NBK{otherNode} - edgeId;
        for i = 1:length(g1_of_NBK_minus_edgeId)
            if g1_of_NBK_minus_edgeId(i) ~= 0
                temp_cell = [temp_cell , g1_of_NBK{otherNode}(i)];
            end
        end
        g1_of_NBK{otherNode} = temp_cell; 
        if (ismember(otherNode,node_list) | isempty(g1_of_NBK{otherNode}))
            if ( ~isempty(fundamental_circuit_edgeId))
                last_edge = fundamental_circuit_edgeId(size(fundamental_circuit_edgeId,2));
                if ( last_edge == edgeId)
                    fundamental_circuit_edgeId = [fundamental_circuit_edgeId(1:end-1)] ;
                end
            else 
                fundamental_circuit_edgeId = fundamental_circuit_edgeId(1:end -1);
            end
        else
            fundamental_circuit_edgeId = [fundamental_circuit_edgeId, edgeId];
        end
        a = fundamental_circuit_edgeId;
        if ismember(link_branch,g1_of_NBK{otherNode})
            fundamental_circuit_edgeId = [fundamental_circuit_edgeId, link_branch];
           % fundamental_circuit_edgeId = [link_branch, fundamental_circuit_edgeId];
            my_output = fundamental_circuit_edgeId;
            return   % fundamental_circuit_edgeId;
        end

        node_list = [node_list, otherNode];
        if 1 == node_visited(otherNode)
            continue 
        end
        
        dfs_search_NBK(index, node_list, link_branch,node_visited, otherNode, initial_and_final_node, g1_of_NBK,fundamental_circuit_edgeId);
    end
    fundamental_circuit_for_NBK{index} = my_output;
    %return;
end
