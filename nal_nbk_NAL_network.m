function nal_nbk_NAL_network(cktnetlist)
    L_Branch = nal_nbk_L_branch_hybrid_analysis(cktnetlist);
    K_Branch = nal_nbk_K_branch_hybrid_analysis(cktnetlist);
    nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist);
    hybrid_nal_ckt.cktname  = strcat('NAL ckt of', ' : ', cktnetlist.cktname);
    hybrid_nal_ckt.node
end
