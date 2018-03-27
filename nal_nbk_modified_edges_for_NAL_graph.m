function modified_edges_for_NAL =  nal_nbk_modified_edges_for_NAL_graph(cktnetlist)
% --------------------------------------------------------------------------------
% syntax :- modified_edges_for_NAL = nal_nbk_modified_edges_for_NAL_graph(cktnetlist) 
%
% This function will return modified_edges_for_NAL which is used to make incedence 
% matrix for a graph associated with circuit NAL i.e. Gx(AUL) 
% --------------------------------------------------------------------------------

% --------------------------- written on : Mar 13, 2018 --------------------------

    L_Branch = nal_nbk_L_branch_hybrid_analysis(cktnetlist);
    K_Branch = nal_nbk_K_branch_hybrid_analysis(cktnetlist);
    common_nodes = nal_nbk_A_and_B_common_nodes(cktnetlist);
    [hybridTreeEdgeId_of_A, hybridTreeEdgeId_of_B] = nal_nbk_tree_partition_for_hybrid_analysis(cktnetlist);
    [nodeVisited,edgeId_of_tree_of_G,dfs_nodes_of_A,dfs_nodes_of_B]= nal_nbk_dfs_search_of_G(cktnetlist);
    super_node = {dfs_nodes_of_B};
    for edgeId = hybridTreeEdgeId_of_B
        nodeId = cktnetlist.elements{edgeId}.nodes;
        start_node = nodeId(1);
        end_node = nodeId(2);
        if (strcmp(start_node, 'gnd'))
            start_node = length(nodeVisited);
        else
            start_node = str2num(cell2mat(start_node));
        end
        if (strcmp(end_node,'gnd'))
            end_node = length(nodeVisited);
        else
            end_node = str2num(cell2mat(end_node));
        end
        if (isempty(find(start_node == dfs_nodes_of_B)))
            super_node{1} = [super_node{1}, start_node];
        elseif (isempty(find(end_node == dfs_nodes_of_B)))
            super_node{1} = [super_node{1}, end_node ];
        else 
            super_node = super_node;
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % this below line code will aggregate all the super_node to get Reduced incedence matrix 
    % for NAL graph
    super_node = cell2mat(super_node);
    common_nodes_index = find(common_nodes);
    for k = 1:length(common_nodes_index)
        if(~isempty(find(common_nodes_index(k) == super_node)))
            aggregate_super_node = common_nodes_index(k);
            break;
        end 
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    all_modified_edges_for_NAL = []; 
    N = length(cktnetlist.nodenames)+1;
    for i = 1:length(cktnetlist.elements)
        edge = cktnetlist.elements{i}.nodes;
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
        if (~isempty(find(node1 == super_node)))
            node1 = aggregate_super_node;
        end
        if (~isempty(find(node2 == super_node)))
            node2 = aggregate_super_node;
        end
        all_modified_edges_for_NAL = [all_modified_edges_for_NAL ; node1 node2];

    end

    modified_edges_for_NAL = []; 
    A_and_B_part = nal_nbk_partition(cktnetlist);
    for i = 1:length(A_and_B_part)
        if(A_and_B_part(i) ~= 0)
            modified_edges_for_NAL = [modified_edges_for_NAL;all_modified_edges_for_NAL(i,:)];
        end
    end
   
    for i = 1:length(L_Branch)
        modified_edges_for_NAL = [modified_edges_for_NAL;all_modified_edges_for_NAL(L_Branch(i),:)];
    end
end
