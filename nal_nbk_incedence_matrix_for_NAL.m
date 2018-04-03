function  incedence_matrix_for_NAL =  nal_nbk_incedence_matrix_for_NAL(cktnetlist)
% --------------------------------------------------------------------------------
% syntax : incedence_matrix_for_NAL = nal_nbk_incedence_matrix_for_NAL(cktnetlist)
%
% This function will return incedence matrix of network NAL i.e. graph Gx(AUL).
% --------------------------------------------------------------------------------

% -------------------------- written on : Mar 13, 2018 ---------------------------

    
    modified_edges_for_NAL = nal_nbk_modified_edges_for_NAL_graph(cktnetlist) ;
    [nodeVisited,edgeId_of_tree_of_A,dfs_nodes_of_A]= nal_nbk_dfs_search_of_G_dot_A(cktnetlist);
    incedence_matrix_for_NAL = sparse(zeros(length(dfs_nodes_of_A),size(modified_edges_for_NAL,1)));
    
    for k = 1:size(modified_edges_for_NAL,1)
        incedence_matrix_for_NAL (modified_edges_for_NAL(k,1),k) = 1;
        incedence_matrix_for_NAL (modified_edges_for_NAL(k,2),k) = -1;
    end
end
