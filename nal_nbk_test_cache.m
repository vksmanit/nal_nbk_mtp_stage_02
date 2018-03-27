function my_variable =  nal_nbk_test_cache(cktnetlist)
    global edges_for_NBK;
    global fundamental_circuit_edgeId;
    my_variable ={}; 
    N = length(cktnetlist.nodenames) + 1;
    [edgeId_for_NBK,tree_brach_for_NBK, link_branch_for_NBK] = nal_nbk_edge_identity_of_NBK(cktnetlist);
    for i = 1:length(link_branch_for_NBK)
        node_visited = zeros(N,1) ;
        [g1_of_NBK,edges_for_NBK] = nal_nbk_nodeInfo_with_edge_identity_of_NBK(cktnetlist);
        fundamental_circuit_edgeId = [];
        edge = cktnetlist.elements{link_branch_for_NBK(i)}.nodes;
        node1 = edge(1,1);
        node2 = edge(1,2);
        if (strcmp(node1,'gnd'))
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% correct upto here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        dfs_search_of_fundamental_circuit_node = str2num(cell2mat(edges_for_NBK(link_branch_for_NBK(i))));

        fundamental_circuit_edgeId = dfs_search_NBK(node_visited,dfs_search_of_fundamental_circuit_node,dfs_search_of_fundamental_circuit_node,g1_of_NBK);
        my_variable = [my_variable;unique(fundamental_circuit_edgeId)]
    end
end


function fundamental_circuit_edgeId = dfs_search_NBK(node_visited,nodeId,initial_and_final_node,g1_of_NBK)
    
    global edges_for_NBK;
    global fundamental_circuit_edgeId;
    if (~isempty(g1_of_NBK{nodeId}))
        node_visited(nodeId) = 1;
    end

    k = 1;
    adjEdgeIdsOfCurrentNode = g1_of_NBK{nodeId} ;
    for edgeId = adjEdgeIdsOfCurrentNode
        if (isempty(fundamental_circuit_edgeId))
            fundamental_circuit_edgeId = [edgeId];
        end
        edge = edges_for_NBK(edgeId, :);
        otherNode = edge(1,2);
        if (strcmp(otherNode,'gnd'))
            otherNode = length(node_visited);
        else
            otherNode = str2num(cell2mat(edge(1,2)));
        end
        if (k == 1)
            if otherNode == nodeId 
                otherNode = str2num(cell2mat(edge(1,1)));
                if isempty(otherNode)
                    otherNode = length(node_visited);
                end
            end
    %        fundamental_circuit_edgeId = [fundamental_circuit_edgeId, edgeId]
        else 
            if otherNode == initial_and_final_node %nodeId
                %fundamental_circuit_edgeId = [fundamental_circuit_edgeId, edgeId]
                break
            end
        end 
        if 1 == node_visited(otherNode) 
            continue 
        end 
        k = k + 1;
        fundamental_circuit_edgeId = [fundamental_circuit_edgeId, dfs_search_NBK(node_visited,otherNode,initial_and_final_node,g1_of_NBK)];
    end
        fundamental_circuit_edgeId = unique(fundamental_circuit_edgeId);
end
