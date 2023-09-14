# Enumerates all binary leaking groups of order less than 64

Read("leaks.gd");

for G in AllSmallGroups(Size,[1..63],IsAbelian,false) do
	if HasBinLeak(G) then
		Print( StructureDescription(G), "\n" );
	fi;
od;
