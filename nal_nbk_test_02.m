%function fundamentalCircuitEdgeIds =  nal_nbk_fundamental_circuit_for_NBK(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : fundamentalCircuitEdgeIds = nal_nbk_fundamental_circuit_for_NBK(cktnetlist)
%
% This function will return the cell object fundamentalCircuitEdgeIds which is the 
% EdgeIds of fundamental cirucuit. 
% The link branch is attached at the end to get compatibility with function 
% nal_nbk_hybird_analysis_equation(cktnetlist). 
% --------------------------------------------------------------------------------

% ----------------------- Written On : Apr 14, 2018 ------------------------------
    global g1_of_tree_of_NBK;
    global edges_for_NBK;
    global node_visited;
    global MyCktIds;

    [tree, link] = nal_nbk_tree_and_link_branch_for_NBK(cktnetlist);
    N = length(cktnetlist.nodenames) + 1;
    [g1_of_tree_of_NBK, edges_for_NBK] = nal_nbk_nodeInfo_with_edge_identity_of_tree_of_NBK(cktnetlist);
    fundamentalCircuitEdgeIds = cell(length(link),1);
    for i = 1 :length(link)
        edge = cktnetlist.elements{link(i)}.nodes;
        node_visited = zeros(N,1);
        node1 = edge(1,1);
        node2 = edge(1,2);
        if (strcmp(node1, 'gnd'))
            node1 = N ;
        else 
            node1 = str2num(cell2mat(node1));
        end
        if (strcmp(node2, 'gnd'))
            node2 = N ;
        else 
            node2 = str2num(cell2mat(node2));
        end
        MyCktIds = [];
        dfs_to_get_fundamental_circuit(node1,node2);%, MyCktIds);
        %fundamentalCircuitEdgeIds{i} = [link(i),MyCktIds] ;
        fundamentalCircuitEdgeIds{i} = [MyCktIds,link(i)] ;
    end
end

function  dfs_to_get_fundamental_circuit(start_node,end_node)
    global edges_for_NBK;
    global node_visited;
    global g1_of_tree_of_NBK;
    global MyCktIds ;

    node_visited(start_node) = 1;
    adjEdgeIdsOfCurrentNode = g1_of_tree_of_NBK{start_node};
    for edgeId = adjEdgeIdsOfCurrentNode
        edge = edges_for_NBK(edgeId, :);
        otherNode = edge(1,2);
        if (strcmp(otherNode,'gnd'))
            otherNode = length(node_visited);
        else
            otherNode = str2num(cell2mat(edge(1,2)));
        end
        if otherNode == start_node 
            otherNode = str2num(cell2mat(edge(1,1)));
            if (isempty(otherNode))
                otherNode = length(node_visited);
            end
        end
        
        if (node_visited(otherNode) == 0)
            MyCktIds = [MyCktIds, edgeId];
            if (otherNode == end_node)
                return 
            end
            dfs_to_get_fundamental_circuit(otherNode, end_node);
        elseif (node_visited(otherNode) == 1)
            if (length(g1_of_tree_of_NBK{start_node}) == 1) 
                MyCktIds = [];
            end
                continue;
            if (length(MyCktIds) == 1) 
                MyCktIds = [];
            else
                MyCktIds = MyCktIds(1:end-1);
            end
        end
    end
end
