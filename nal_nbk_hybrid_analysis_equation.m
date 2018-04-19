function [A, B, mcg_index] = nal_nbk_hybrid_analysis_equation(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [A, B, mcg_index] = nal_nbk_hybrid_analysis_equation(cktnetlist)
% 
% This function will return the final equation which is used to solve using 
% Modified Conjugate Gradient (MCG). 
% It also return a term mcg_index which is used in modified conjugate gradient.
% --------------------------------------------------------------------------------

% ---------------------------- written on : Apr 01, 2018 -------------------------

    loop_matrix_for_NBK = nal_nbk_loop_matrix_for_NBK(cktnetlist);
    incedence_matrix_for_NAL = nal_nbk_incedence_matrix_for_NAL(cktnetlist);
    incedence_matrix_for_NAL = incedence_matrix_for_NAL(1:end-1, :);
    L_branch = nal_nbk_L_branch_hybrid_analysis(cktnetlist);
    K_branch = nal_nbk_K_branch_hybrid_analysis(cktnetlist);
    partition = nal_nbk_partition(cktnetlist);
    [GA, EA, JA, RB, EB, JB] = nal_nbk_matrix_for_NAL_and_NBK(cktnetlist);
  %  [GA,EA,JA] = nal_nbk_matrix_for_NAL(cktnetlist);
   % [RB,EB,JB] = nal_nbk_matrix_for_NBK(cktnetlist);
    ArA= sparse([]);
    Bb = sparse([]);
    ArL =sparse([]);
    BK = sparse([]);
    ArK =sparse([]);
    BL = sparse([]);
    index = 1;
    for item = partition 
        if item == 1 
            ArA = [ArA, incedence_matrix_for_NAL(:,index)];
        else
            Bb = [Bb, loop_matrix_for_NBK(:,index)];
        end
        index = index + 1;
    end
    for item = L_branch
        ArL = [ArL,incedence_matrix_for_NAL(:,item)];
        BL = [BL, loop_matrix_for_NBK(:,item)];
    end
    for item = K_branch
        BK = [BK,loop_matrix_for_NBK(:,item)];
        ArK = [ArK, incedence_matrix_for_NAL(:,item)];
    end

    A_left_top = ArA * GA * ArA';
    A_left_bottom = BK * ArK';
    A_right_top = ArL * BL';
    A_right_bottom = Bb * RB * Bb' ;
    A = [ A_left_top, A_right_top ; A_left_bottom, A_right_bottom];
    B_top = ArA * GA * EA - ArA * JA;
    B_bottom = Bb * RB * JB - Bb * EB;
    B = [B_top;B_bottom];

    mcg_index = size(A_left_bottom,2);
                                       
end
