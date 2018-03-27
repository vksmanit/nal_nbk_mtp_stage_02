function  [edgeId_for_NBK,tree_branch_for_NBK, link_branch_for_NBK] = nal_nbk_edge_identity_of_NBK(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax :[edgeId_for_NBK,tree_brach_for_NBK, link_branch_for_NBK] = nal_nbk_edge_identity_of_NBK(cktnetlist)
%
% This function return link branch, tree branch and edgeId of NBK network,
% which is used to write the loop matrix for NBK. 
% --------------------------------------------------------------------------------

% ------------------------ written on : Mar 17, 2018 -----------------------------
    [nodeVisited, tree_branch_for_NBK,dfs_nodes_of_B]= nal_nbk_dfs_search_of_G_dot_B(cktnetlist);

    % This function will give the tree for graph NBK i.e. for graph G.(BUK).
    % Is this true ???
    % Tree for G.B is as same as tree for graph NBK.
    % Also will the K branches will be the Link branched of NBK.
    nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist);
    B_branch_index = find(not(nal_nbk_A_and_B_part));
    K_branch = nal_nbk_K_branch_hybrid_analysis(cktnetlist);

    link_branch_for_NBK = [K_branch];
    for i = 1:length(B_branch_index)
        if not (ismember(B_branch_index(i),tree_branch_for_NBK))
            % can we delete the member so that the serch won't be in full array
            link_branch_for_NBK = [link_branch_for_NBK, B_branch_index(i)];
        end
    end
    edgeId_for_NBK = [link_branch_for_NBK, tree_branch_for_NBK];
end
