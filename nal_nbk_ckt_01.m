function cktnetlist = nal_nbk_ckt_01()
% --------------------------------------------------------------------------------
% Syntax : cktnetlist = nal_nbk_ckt_01()
%
% This will return the cktnetlist for nal_nbk hybrid analysis simulation.
% To see the graph of this ckt just run 
% >>   showimage('nal_nbk_ckt_01.png')    
% 
% --------------------------------------------------------------------------------

% ------------------------- written : Sep 04, 2017 -------------------------------
 

    clear cktnetlist;
    cktnetlist.cktname = 'nab_nbk_ckt';
 
    cktnetlist.nodenames = {'1','2','3','4','5','6','7','8','9','10','11','12', ...
    						 '13','14','15','16','17','18','19','20','21','22','23','24','25','26'};
    cktnetlist.groundnodename = 'gnd'; % 
    rM = resModSpec();
   % cM = capModSpec();
    iM = isrcModSpec();
    vM = vsrcModSpec();
%%%% ===================== block 01 (A-network) ========================================%%%
	cktnetlist = add_element(cktnetlist, vM, 'V1', {'2', '4'}, {},...
    {{'DC',10}});
    cktnetlist = add_element(cktnetlist, rM, 'R2', {'1','2'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R3', {'1','3'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R4', {'2','3'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R5', {'2','4'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R6', {'3','5'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R7', {'4','5'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R8', {'4','6'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R9', {'5','6'}, {{'R', 100}});

    cktnetlist = add_element(cktnetlist, rM, 'R10', {'1','7'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R11', {'3','7'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R12', {'5','10'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R13', {'5','24'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R14', {'6','22'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R15', {'24','25'}, {{'R', 1e5}});
 	cktnetlist = add_element(cktnetlist, rM, 'R16', {'25','26'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R17', {'24','26'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R18', {'23','24'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R19', {'23','26'}, {{'R', 1e5}}); 
    cktnetlist = add_element(cktnetlist, iM, 'I20', {'26', '24'}, {},...
    {{'DC',1e-3}});
 	cktnetlist = add_element(cktnetlist, rM, 'R21', {'26','18'}, {{'R', 1e5}});
 	cktnetlist = add_element(cktnetlist, rM, 'R22', {'10','18'}, {{'R', 1e5}});


 	cktnetlist = add_element(cktnetlist, rM, 'R23', {'7','8'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R24', {'7','10'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R25', {'8','9'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R26', {'8','9'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R27', {'9','11'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R28', {'10','11'}, {{'R', 100}});
	cktnetlist = add_element(cktnetlist, rM, 'R29', {'8','10'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R30', {'18','22'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R31', {'18','19'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R32', {'19','20'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R33', {'20','gnd'}, {{'R', 100}});
	cktnetlist = add_element(cktnetlist, rM, 'R34', {'22','gnd'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R35', {'21','gnd'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R36', {'20','21'}, {{'R', 100}});
 	cktnetlist = add_element(cktnetlist, rM, 'R37', {'18','21'}, {{'R', 100}});


 	cktnetlist = add_element(cktnetlist, rM, 'R38', {'9','13'}, {{'R', 1e5}}); 
 	cktnetlist = add_element(cktnetlist, rM, 'R39', {'11','12'}, {{'R', 1e5}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R40', {'12','13'}, {{'R', 1e5}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R41', {'13','14'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R42', {'12','14'}, {{'R', 1e5}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R43', {'13','14'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R44', {'12','15'}, {{'R', 1e5}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R45', {'14','16'}, {{'R', 1e5}});
    cktnetlist = add_element(cktnetlist, rM, 'R46', {'15','19'}, {{'R', 1e5}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R47', {'17','20'}, {{'R', 1e5}});


    cktnetlist = add_element(cktnetlist, rM, 'R48', {'15','16'}, {{'R', 100}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R49', {'16','17'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R50', {'15','17'}, {{'R', 100}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R51', {'16','17'}, {{'R', 100}});



    cktnetlist;

end
