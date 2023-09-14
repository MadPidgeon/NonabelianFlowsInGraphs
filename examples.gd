# Generates data on some selected groups
Read("leaks.gd");

PrintLeaks := function( G )
	local H, p;
	p := HasLeak(G);
	H := fail;
	if p then
		H := LeakingSubgroup(G);
	fi;
	Print( StructureDescription(G), "\nhas leak: ", p, "\nleaking subgroup: " );
	if H = fail then
		Print( "none\n" );
	else
		Print( StructureDescription(H), "\n" );
	fi;
end;

PrintLeaks( ExtraspecialGroup(2^5,'-') );
PrintLeaks( SymmetricGroup(6) );
PrintLeaks( AlternatingGroup(7) );