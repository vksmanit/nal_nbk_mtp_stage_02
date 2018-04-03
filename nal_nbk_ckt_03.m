function cktnetlist = nal_nbk_ckt_01()

% --------------------------------------------------------------------------------
% Syntax : cktnetlist = nal_nbk_ckt_03()
%
% This will return the cktnetlist for nal_nbk hybrid analysis simulation.
% To see the graph of this ckt just run 
% >>   showimage('nal_nbk_ckt_03.png')    
% 
% --------------------------------------------------------------------------------

% ------------------------- written : Sep 07, 2017 -------------------------------
% image of ckt diagram in folder ~/Desktop/MTP2/drawing_for_stage_02
 
    clear cktnetlist;
    cktnetlist.cktname = 'nal_nbk_ckt_03';
 
    cktnetlist.nodenames = {'1','2','3','4','5','6','7','8','9','10','11','12', ...
    						 '13','14','15','16','17','18','19','20','21','22','23','24','25','26','27'};
    cktnetlist.groundnodename = 'gnd'; % 
    rM = resModSpec();
   % cM = capModSpec();
    iM = isrcModSpec();
    vM = vsrcModSpec();
%%%% ============================= (A-network) ========================================%%%
	cktnetlist = add_element(cktnetlist, vM, 'V1', {'2', '4'}, {},...
    {{'DC',10}});
    cktnetlist = add_element(cktnetlist, rM, 'R2', {'1','2'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R3', {'1','3'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R4', {'2','3'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R5', {'3','5'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R6', {'4','5'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R7', {'4','6'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R8', {'5','6'}, {{'R', 100}});



%%%% ============================= (B-network) ========================================%%%

    cktnetlist = add_element(cktnetlist, rM, 'R9', {'1','8'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R10', {'3','8'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R11', {'3','12'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R12', {'5','18'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R13', {'6','26'}, {{'R', 1e5}});
    
%%%% ============================= (A-network) ========================================%%%
    cktnetlist = add_element(cktnetlist, rM, 'R14', {'7','8'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R15', {'7','9'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R16', {'8','9'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R17', {'8','10'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R18', {'9','11'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R19', {'10','11'}, {{'R', 100}}); 

%%%% ============================= (B-network) ========================================%%%

    cktnetlist = add_element(cktnetlist, rM, 'R20', {'10','12'}, {{'R', 1e5}}); 
 	cktnetlist = add_element(cktnetlist, rM, 'R21', {'11','13'}, {{'R', 1e5}});
 	cktnetlist = add_element(cktnetlist, rM, 'R22', {'12','13'}, {{'R', 1e5}});
 	cktnetlist = add_element(cktnetlist, rM, 'R23', {'13','19'}, {{'R', 1e5}});
 	cktnetlist = add_element(cktnetlist, rM, 'R24', {'18','19'}, {{'R', 1e5}});
 	cktnetlist = add_element(cktnetlist, rM, 'R25', {'12','18'}, {{'R', 1e5}});
 	cktnetlist = add_element(cktnetlist, rM, 'R26', {'14','15'}, {{'R', 1e5}});
 	cktnetlist = add_element(cktnetlist, rM, 'R27', {'15','17'}, {{'R', 1e5}});
 	cktnetlist = add_element(cktnetlist, rM, 'R28', {'16','17'}, {{'R', 1e5}});
    %cktnetlist = add_element(cktnetlist, iM, 'I29', {'12','18'}, {},...
  %  {{'DC',1e-3}});
    cktnetlist = add_element(cktnetlist, iM, 'I29', {'14','16'}, {},...
    {{'DC',1e-3}});
 	cktnetlist = add_element(cktnetlist, rM, 'R30', {'12','14'}, {{'R', 1e5}});
 	cktnetlist = add_element(cktnetlist, rM, 'R31', {'13','15'}, {{'R', 1e5}});
 	cktnetlist = add_element(cktnetlist, rM, 'R32', {'17','19'}, {{'R', 1e5}});
 	cktnetlist = add_element(cktnetlist, rM, 'R33', {'16','18'}, {{'R', 1e5}});

%%%% ============================= (A-network) ========================================%%%
	cktnetlist = add_element(cktnetlist, rM, 'R34', {'24','25'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R35', {'25','gnd'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R36', {'27','gnd'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R37', {'26','27'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R38', {'26','gnd'}, {{'R', 100}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R39', {'24','gnd'}, {{'R', 100}}); 




%%%% ============================= (B-network) ========================================%%%
    cktnetlist = add_element(cktnetlist, rM, 'R40', {'9','21'}, {{'R', 1e5}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R41', {'13','20'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R42', {'19','22'}, {{'R', 1e5}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R43', {'23','27'}, {{'R', 1e5}});


%%%% ============================= (A-network) ========================================%%%

    cktnetlist = add_element(cktnetlist, rM, 'R44', {'20','22'}, {{'R', 100}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R45', {'20','21'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R46', {'21','23'}, {{'R', 100}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R47', {'22','23'}, {{'R', 100}});
    

    cktnetlist;

end
