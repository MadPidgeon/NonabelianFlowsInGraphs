# Enumerates all leaking groups of order less than 64

Read("leaks.gd");

for G in AllSmallGroups(Size,[1..63],IsAbelian,false) do
	if HasLeak(G) then
		Print( StructureDescription(G), "\n" );
	fi;
od;
