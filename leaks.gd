# Functions for determining whether a group leaks

# Computes a vector of length n consisting of 1's at the coordinates in L and 0's elsewhere
IndicatorFunction := function( n, L )
	local v, i;
	v := [];
	for i in [1..n] do
		v[i] := 0;
	od;
	for i in L do
		v[i] := v[i]+1;
	od;
	return v;
end;

# Computes a vector of length n consisting of a 1 at x, a -1 at y and 0's elsewhere
EqualizerFunction := function( n, x, y )
	local v, i;
	v := [];
	for i in [1..n] do
		v[i] := 0;
	od;
	v[x] := 1;
	v[y] := v[y]-1;
	return v;
end;

# Compute a matrix whose cokernel is G_\bullet \cong G^\bullet
LeakGroupMatrix := function( G )
	local n, L, M, i, j, k, v;
	n := Order( G );
	L := List( G );
	M := [];
	for i in [1..n] do for j in [1..i] do
		if Comm( L[i], L[j] ) = One(G) then;
			k := PositionCanonical( L, Inverse( L[i]*L[j] ) );
			v := IndicatorFunction( n, [i, j, k] );
			if not v in M then
				Add( M, v );
			fi;
		fi;
	od; od;
	Add( M, IndicatorFunction( n, [1] ) );
	return M;
end;

# Decides whether G leaks
HasLeak := function( G )
	local n, M, i;
	n := Order( G );
	M := BaseIntMat( LeakGroupMatrix( G ) );
	for i in [2..n] do 
		if SolutionIntMat( M, IndicatorFunction( n, [i] ) ) <> fail then
			return true;
		fi;
	od;
	return false;
end;

# Decides whether G binary-leaks
HasBinLeak := function( G )
	local n, M, i, j;
	n := Order( G );
	M := BaseIntMat( LeakGroupMatrix( G ) );
	for i in [2..n] do for j in [1..(i-1)] do
		if SolutionIntMat( M, EqualizerFunction( n, i, j ) ) <> fail then
			return true;
		fi;
	od; od;
	return false;
end;

# Computes a leaking subgroup of G or fails
LeakingSubgroup := function( G )
	local R;
	for R in MaximalSubgroupClassReps( G ) do
		if HasLeak( R ) then
			return R;
		fi;	
	od;
	return fail;
end;
