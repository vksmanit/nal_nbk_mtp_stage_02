
function fundamentalCircuitEdgeIds =  nal_nbk_fundamental_circuit_for_NBK(cktnetlist)
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
    global MyOutput;

    [tree, link] = nal_nbk_tree_and_link_branch_for_NBK(cktnetlist);
    N = length(cktnetlist.nodenames) + 1;
    [g1_of_tree_of_NBK, edges_for_NBK] = nal_nbk_nodeInfo_with_edge_identity_of_tree_of_NBK(cktnetlist);
    %edgeId_visited = zeros(length(edges_for_NBK),1)';
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
        dfs_to_get_fundamental_circuit(node1,node2, g1_of_tree_of_NBK);%, MyCktIds);
        fundamentalCircuitEdgeIds{i} = [MyOutput, link(i)] ;
    end
end
%
function MyOutput = dfs_to_get_fundamental_circuit(start_node,end_node,modified_g1_of_tree_of_NBK)
   %global MyCktIds;
   %%%%%global g1_of_tree_of_NBK;
   global edges_for_NBK;
   global MyOutput;
   global node_visited;
   global MyCktIds;
   %global edgeId_visited;

   node_visited (start_node) = 1;
   adjEdgeIdsOfCurrentNode = modified_g1_of_tree_of_NBK{start_node};
   
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

       if (otherNode == end_node)
           MyOutput = [MyCktIds,edgeId];
           return 
       end

       if (node_visited(otherNode) == 1 & length(modified_g1_of_tree_of_NBK{start_node}) == 1) 
%          if(length(MyCktIds) == 1) 
%              MyCktIds = [];
%          else
%              MyCktIds = MyCktIds(1:end-1); % this will remove an edge when it find a terminated node.
%          end
           modified_g1_of_tree_of_NBK = remove_coloops(start_node,modified_g1_of_tree_of_NBK);
          % if (length(modified_g1_of_tree_of_NBK{otherNode}) == 1)
           %    modified_g1_of_tree_of_NBK = re
       elseif (node_visited(otherNode) == 0) 
           MyCktIds = [ MyCktIds, edgeId] 
           dfs_to_get_fundamental_circuit(otherNode, end_node, modified_g1_of_tree_of_NBK);
       elseif node_visited(otherNode == 1) 
           continue;
       end
   end
end

function removed_coloops_g1_of_NBK = remove_coloops(node,g1)
    global end_node;
    global edges_for_NBK;
    global node_visited;
    global MyCktIds;
    edgeId = g1{node};
    g1{node} = [];
    edge = edges_for_NBK(edgeId,:);
    otherNode = edge(1,2);
    if (strcmp(otherNode,'gnd'))
        otherNode = length(node_visited);
    else
        otherNode = str2num(cell2mat(edge(1,2)));
    end
    if otherNode == node 
        otherNode = str2num(cell2mat(edge(1,1)));
        if (isempty(otherNode))
            otherNode = length(node_visited);
        end
    end
    g1{otherNode} = g1{otherNode}(g1{otherNode}~=edgeId);
    %%%%%%%%%%% working for single coloop branch %%%%%%%%%%%%%%%%%
    if(length(g1{otherNode}) == 1 & node_visited(otherNode) == 1)
        if (length(MyCktIds) == 1) 
            MyCktIds = [];
        else 
            MyCktIds = MyCktIds(1:end-1) % this will remove an edge when it find a terminated node.
        end
        if isempty(MyCktIds) % == [])
            removed_coloops_g1_of_NBK = g1;
            return 
        end
        removed_coloops_g1_of_NBK = remove_coloops(otherNode,g1);
    elseif(length(g1{otherNode}) == 1 & node_visited(otherNode) ~= 1)
        removed_coloops_g1_of_NBK = g1;
    end
end

