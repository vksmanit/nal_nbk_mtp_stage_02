function cktnetlist = nal_nbk_ckt_02_v2()

% --------------------------------------------------------------------------------
% syntax : cktnetlist = nal_nbk_ckt_02_v2()
% This will return the cktnetlist for nal_nbk hybrid analysis simulation.
% 
% To see the graph of this ckt just run 
% >>   showimage('nal_nbk_ckt_02.jpg')    
% In this version-2 ckt just node 6 and 'gnd' are exchanged
% --------------------------------------------------------------------------------

% ------------------------- written : Sep 25, 2017 -------------------------------
 

    clear cktnetlist;
    cktnetlist.cktname = 'nal_nbk_ckt_2';
 
    cktnetlist.nodenames = {'1','2','3','4','5','6','7','8'};
    cktnetlist.groundnodename = 'gnd'; % 
    rM = resModSpec();
   % cM = capModSpec();
    iM = isrcModSpec();
    vM = vsrcModSpec();
%%%% ===================== block 01 (A-network) ========================================%%%
	cktnetlist = add_element(cktnetlist, vM, 'V1', {'3', '4'}, {},{{'DC',10}});

    cktnetlist = add_element(cktnetlist, rM, 'R2', {'3','5'}, {{'R', 100}});
    %cktnetlist = add_element(cktnetlist, rM, 'R2', {'1','3'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R3', {'4','5'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R4', {'1','3'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R5', {'1','2'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R6', {'2','3'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R7', {'4','gnd'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R8', {'5','gnd'}, {{'R', 100}});

%%%% ====================== block 02 (A-network) ================================== %%%
%   cktnetlist = add_element(cktnetlist, rM, 'R1', {'1','2'}, {{'R', 1e3}});

    cktnetlist = add_element(cktnetlist, rM, 'R9', {'gnd','7'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R10', {'gnd','8'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R11', {'4','7'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R12', {'5','8'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, iM, 'I13', {'7','8'}, {},{{'DC',1e-3}});
    cktnetlist = add_element(cktnetlist, rM, 'R14', {'7','6'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R15', {'8','6'}, {{'R', 1e5}});

    cktnetlist;
end
